---
layout: pattern
order: 1
title: API Management (APIM)
date: 2026-02-16 # this should be the date that the content was most recently amended or formally reviewed
# use `tags: []` for no tags 
# Note: tags must use sentence case capitalisation
tags:
  - Digital
  - Infrastructure
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related links
      items:
        - text: Writing a standard
          href: /standards/writing-a-standard/ # Note: use an absolute link from the site home page
---

<!-- Pattern description -->

<!-- 

# Notes on line breaks

Please see https://x-govuk.github.io/govuk-eleventy-plugin/markdown/#line-breaks for notes on usage of line breaks.

# Notes on linking to headings within a page

Heading tags are automatically assigned an id, converting spaces to `kebab-case` and applying URL encoding. If you want to link to a specific heading, you can obtain the URL encoded link by running the site locally, inspecting the appropriate <h3> element in the browser's developer tools and copying the value from the 'id' attribute.
-->

This pattern defines how a developer could use an API Management service and when best to use them

---

## Use Cases

- Any APIs that are intended for public consumption, particularly for external developers; this is because API Management allows for rate limiting and control over access of endpoints
- Function Apps and other services that make usage of consumption plans, as this protects such services from scaling out of control
- As a façade to standardise headers (for example, correlation), enforce JWT authentication, and centrally manage backend access tokens

---

## API Importation

- For APIM to import successfully, you must have a set of triggers defined (for function apps) or an OpenAPI spec for APIM to detect
- APIs can then be imported using the "APIs" tab and following the screens presented.
- A list of endpoints will then be generated; each can then be configured with both inbound and outbound processing, as well as a specific backend such as a function app
- Processing can be useful for a number of reasons, including redirecting old links to new ones, rate limiting and tracking of usage
- By default, subscriptions are turned **on** - if your API is fully public and doesn't need a subscription key (e.g. the Register) then this should be turned off
- Note that each import is effectively adding a "new" API into API management, even if you're reusing the same backend. This is useful for access control when APIs are semi-public, as you can then use Products and Subscriptions to provide access to the private version of the API, whilst the other API can act as the public version. An example can be found in the Register's APIM instances

---

## Policies

- Policies are what is used to define how an incoming or outgoing request should be handled, or what should happen when an error occurs
- These are written in XML Format, but a visual GUI is also provided in most cases to help you
- Custom policies can also be created through policy fragments

### Example Policy

```xml
<policies>
    <inbound>
        <base />
        <set-backend-service id="apim-generated-policy" backend-id="ofq-dev-fn-register-api" />
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
```

---

## Products and Subscriptions

- Products are used to group APIs together, put legal terms on a set of APIs, and apply runtime policies for that product, such as differing rate limits
- To use a Product, a corresponding Subscription must be made; Subscriptions are effectively a form of key/secret and should be treated as such
- A Subscription requires a name and a scope; names should correspond to who the subscription is for (e.g. Department for Education), and the scope must correspond to a Product
- Remember: If an API is set up to not require a subscription key, then users will be able to bypass these needs!

---


## Our implementation

We centralise controls at the **API level** so they apply to **all operations** on the SuiteCRM façade. This concentrates inbound JWT authentication, backend token acquisition/caching, correlation, and rate limiting.

### Configuration (Named Values)
- **{{OpenIDConfigUrl}} — OpenID discovery endpoint for inbound JWT validation**
- **{{TokenIssuer}} — expected token issuer**
- **{{TokenAUD}} — expected audience**
- **{{SuiteCRMBaseUrl}} — SuiteCRM base URL**
- **{{SuiteCRMClientID}} / {{SuiteCRMClientSecret}} — client credentials (use Key Vault references)**

### Our policies (at a glance)

- **Rate limiting (per IP):** `120 requests/minute` using `rate-limit-by-key` keyed to `context.Request.IpAddress`
- **Client authentication:** Enforce `Authorization: Bearer <JWT>` using `validate-jwt` against our OpenID configuration, issuer, and audience
- **Backend authentication:** Acquire SuiteCRM **client‑credentials** token and **cache for ~59 minutes** in APIM
- **Header standardisation:** Inject backend `Authorization`, set `X-UserContext: PrivUser`
- **Correlation:** Ensure `X‑Correlation‑ID` exists, propagate to backend, and echo to clients
- **Routing:** Forward to `{{SuiteCRMBaseUrl}}/legacy/Api/V8`
- **Error handling:** Default pass‑through (`<base />`) in `on-error`



### Policy details

#### 1) Rate limiting (per client IP)

- **What it does:** Caps each caller IP at **120 requests per minute** to protect SuiteCRM from bursts and cost spikes.
- **XML:**
  ```xml
  <rate-limit-by-key calls="120"
                     renewal-period="60"
                     counter-key="@(context.Request.IpAddress)"
                     remaining-calls-variable-name="remainingCallsPerIP" />


#### 2) Client authentication (JWT validation)

- **What it does:** Requires Authorization: Bearer <JWT> and validates against our OpenID configuration, issuer, and audience.
- **XML:**
  ```xml
  <validate-jwt header-name="Authorization" failed-validation-httpcode="401" require-scheme="Bearer">
  <openid-config url="{{OpenIDConfigUrl}}" />
  <audiences>
    <audience>{{TokenAUD}}</audience>
  </audiences>
  <issuers>
    <issuer>{{TokenIssuer}}</issuer>
  </issuers>
</validate-jwt>

- **Why:** Ensures only trusted callers can access the façade.
- **Notes:** We explicitly require the Bearer scheme and return 401 on invalid/missing tokens. Values are supplied via APIM Named Values (use Key Vault references).

#### 3) Backend authentication (SuiteCRM token acquisition & caching)

- **What it does:** Uses client credentials to obtain a SuiteCRM access_token and caches it for 3540s (~59m) in APIM so we don’t call the token endpoint for every request.
- **XML:**
  ```xml
  
  <!-- Lookup service token in APIM cache -->
  <cache-lookup-value key="suitecrm-access-token" variable-name="accessToken" />

  <!-- If missing, acquire a new token and store it -->
  <choose>
    <when condition='@(!context.Variables.ContainsKey("accessToken"))'>
      <send-request mode="new" response-variable-name="tokenResponse" timeout="20" ignore-error="false">
        <set-url>{{SuiteCRMBaseUrl}}/legacy/Api/access_token</set-url>
        <set-method>POST</set-method>
        <set-header name="Content-Type" exists-action="override">
          <value>application/json</value>
        </set-header>
        <set-body>@{
          return new JObject(
            new JProperty("client_id", "{{SuiteCRMClientID}}"),
            new JProperty("client_secret", "{{SuiteCRMClientSecret}}"),
            new JProperty("grant_type", "client_credentials")
          ).ToString();
        }</set-body>
      </send-request>

      <!-- Extract access token -->
      <set-variable name="accessToken" value="@{
        var response = ((IResponse)context.Variables["tokenResponse"]).Body.As<JObject>();
        return response["access_token"].ToString();
      }" />

      <!-- Store token for ~59 minutes -->
      <cache-store-value key="suitecrm-access-token"
                        value="@((string)context.Variables["accessToken"])"
                        duration="3540" />
    </when>
  </choose>

- **Why:** Reduces latency and load on SuiteCRM auth; consistent service identity to the backend.
- **Caveats:** 
  - The cache key suitecrm-access-token is global for this API (appropriate for a service token; not for per‑user tokens).
  - On expiry, multiple concurrent requests may attempt refresh (APIM has no cache‑miss lock); typically acceptable at this cadence.

#### 4) Header standardisation (to backend)

- **What it does:** Sets the headers SuiteCRM expects on every call.
- **XML:**
  ```xml
  
  <!-- Bearer token for SuiteCRM backend -->
  <set-header name="Authorization" exists-action="override">
    <value>@("Bearer " + (string)context.Variables["accessToken"])</value>
  </set-header>

  <!-- Custom auth context for SuiteCRM -->
  <set-header name="X-UserContext" exists-action="override">
    <value>PrivUser</value>
  </set-header>


- **Why:** Ensures SuiteCRM receives a valid service identity and required context.

#### 5) Correlation (end‑to‑end)

- **What it does:** Guarantees the presence of a correlation ID and flows it to the backend and caller.
- **XML:**
  ```xml
  
  <!-- Accept incoming correlation ID or create one -->
  <set-variable name="correlationId"
                value="@(context.Request.Headers.GetValueOrDefault("X-Correlation-ID", Guid.NewGuid().ToString()))" />

  <!-- Forward to backend -->
  <set-header name="X-Correlation-ID" exists-action="override">
    <value>@((string)context.Variables["correlationId"])</value>
  </set-header>

- **Why:** Enables consistent tracing across APIM, backend, and clients.
- **Notes:** The outbound echo back to the caller is shown in point 7.

#### 6) Routing (SuiteCRM V8 base)

- **What it does:** Routes all operations to the SuiteCRM V8 base URL.
- **XML:**
  ```xml
    <set-backend-service base-url="{{SuiteCRMBaseUrl}}/legacy/Api/V8" />
 
- **Why:** Keeps the façade stable; backend version is explicit and easy to update when SuiteCRM changes.

#### 7) Outbound echo of correlation

- **What it does:** Echoes the correlation ID back to the caller on the response.
- **XML (within < outbound>):**
  ```xml
    
  <set-header name="-Correlation-ID" exists-action="override">
    <value>@((string)context.Variables["correlationId"])</value>
  </set-header>
 
- **Why:** Ensures clients see and can log the same ID we forwarded to the backend.

#### 8) Error handling (current)

- **What it does:** Uses default pass‑through behaviour; we do not currently reshape errors.
- **XML:**
  ```xml  
  <on-error>
    <base />
  </on-error>
 
- **Why:** Keeps backend error payloads intact.
- **Option (future):** Add a standard error envelope (and ensure X‑Correlation‑ID is always present) if consumers need consistent error shapes.

---

## Operation‑level policy:

#### GET /custom/oqmodule/{module}

- **Scope:** This policy applies only to the GET /custom/oqmodule/{module} operation. It inherits the API‑level policy via < base />, so JWT validation, rate limiting, correlation, and SuiteCRM token handling still apply.

#### What it does
- **Response shaping (outbound):** On HTTP 200 only, parses the JSON body and removes the relationships property from every object inside the top‑level data array, then returns the modified JSON.

- **XML:**
  ```xml  
  <!--
      - Policies are applied in the order they appear.
      - Position <base/> inside a section to inherit policies from the outer scope.
      - Comments within policies are not preserved.
  -->
  <!-- Add policies as children to the <inbound>, <outbound>, <backend>, and <on-error> elements -->
  <policies>
      <!-- Throttle, authorize, validate, cache, or transform the requests -->
      <inbound>
          <base />
          <set-backend-service base-url="{{SuiteCRMBaseUrl}}/legacy/Api/V8" />
      </inbound>

      <!-- Control if and how the requests are forwarded to services  -->
      <backend>
          <base />
      </backend>

      <!-- Customize the responses -->
      <outbound>
          <base />
          <choose>
              <when condition="@(context.Response.StatusCode == 200)">
                  <set-body>@{
                  var body = context.Response.Body.As<JObject>(preserveContent: true);

                  if (body["data"] != null)
                  {
                      var dataArray = body["data"] as JArray;
                      if (dataArray != null)
                      {
                          foreach (var item in dataArray)
                          {
                              var obj = item as JObject;
                              if (obj != null && obj["relationships"] != null)
                              {
                                  obj.Remove("relationships");
                              }
                          }
                      }
                  }

                  return body.ToString();
              }</set-body>
              </when>
          </choose>
      </outbound>

      <!-- Handle exceptions and customize error responses  -->
      <on-error>
          <base />
      </on-error>
  </policies>

#### Why we do this
- **Strip relationships:** Downstream consumers of this endpoint don’t use relationships from the SuiteCRM JSON:API response; removing it shrinks payloads and simplifies the contract. 

#### Caveats & notes

- **Success‑only transforms:** Downstream consumers of this endpoint don’t use relationships from the SuiteCRM JSON:API response; removing it shrinks payloads and simplifies the contract. 

- **Assumes data is an array:** The code only removes relationships from elements in a data array. If the backend sometimes returns data as a single object (not an array), extend the logic to also handle JObject.

- **Content type:** set-body returns a string. APIM will infer JSON if the string is JSON and the original Content-Type was application/json. If needed, explicitly set the response header Content-Type: application/json; charset=utf-8.

