---
layout: pattern
order: 1
title: API Management (APIM)
date: 2025-08-01 # this should be the date that the content was most recently amended or formally reviewed
# use `tags: []` for no tags 
# Check https://ho-cto.github.io/engineering-guidance-and-standards/tags/ for existing tags
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
