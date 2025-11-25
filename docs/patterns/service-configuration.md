---
layout: pattern
order: 1
title: Configuration of services
date: 2025-11-21 
tags:
  - Digital
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related links
      items:
        - text: 
          href: 
---

This pattern covers off the patterns involved with the configuration of services. It's useful for...
- Those making new services from scratch
- Those looking to add in a piece of configuration to a service, such as API Authentication

- If you add in a new "section" of configuration, such as the config required to do API Authentication, you should also add the format and definitions to the "Specific Sections" area of this document
- Configuration should be appropriately grouped together so that it's easy to identify related or standardised pieces of config, using the `<Group>__<Name>` convention in the deployed service, and should always be documented
- A configuration file with empty or placeholder values should be provided
- **NEVER CHECK IN SENSITIVE CONFIGURATION VALUES.**. These include connection strings containing auth information and secret keys
- Only provide the bare minimum amount of configuration required. Do not simply copy and paste entire config files from other APIs to make new ones - it might not be appropriate!

---

## Solution


---

## Considerations (optional)


---

## Examples (optional)

### API Authentication
Used by APIs to support authenticating communication with other APIs. This uses App Registrations to create an Identity for the API to use in such communication, along with API keys that must be put
into the configuration. The App Registration should be of an appropriate name for the service (e.g. ofq-prod-api-soc -> Portal-API-SOC)

#### Definitions
- `ApiAuthentication__AadInstance`: The AAD Instance used for authentication. Is always `https://login.microsoftonline.com/`
- `ApiAuthentication__ClientId`: The ID of the App Registration to be used. The registration should have an appropriate name, and is typically unique to the API
- `ApiAuthentication__ClientSecret`: This is the **secret** key for the App Registration and should never be checked in. The key used should be unique to its environment, and should always have an expiration date 18 months into the future
- `ApiAuthentication__Tenant`: This is the tenant the registration is on. This should always be `8e336469-1c6b-4b0b-a06c-748a7c586f7c`
- `ApiAuthentication__ValidIssuer`: The issuer of the token; is always `https://login.microsoftonline.com/8e336469-1c6b-4b0b-a06c-748a7c586f7c/v2.0`
- `ApiAuthentication__AppIdUri`: The URI equivalent of the AppId; is always `api://` + `ApiAuthentication__ClientId`

#### Example
```json
  "ApiAuthentication": {
    "AadInstance": "https://login.microsoftonline.com/",
    "ClientId": "07f21a82-9941-431a-b322-974a1c16a7ae",
    "ClientSecret": "<SECRET>",
    "Tenant": "8e336469-1c6b-4b0b-a06c-748a7c586f7c",
    "ValidIssuer": "https://login.microsoftonline.com/8e336469-1c6b-4b0b-a06c-748a7c586f7c/v2.0",
    "AppIdUri": "api://07f21a82-9941-431a-b322-974a1c16a7ae"
  },
```

### Dev Authentication
**To be set up in local and dev services only. This should never be found in preproduction or production.**
This is used to authenticate against a list of dummy persona accounts for local and dev development for ease of use during testing.

#### Definitions
- `DevAuthentication__ClientSecret`: The **secret** key used to authenticate with basic auth

#### Example
```json
  "DevAuthentication": {
    "ClientSecret": "<SECRET>",
  },
```

### Magic Link Authentication
This is used whenever Magic Links are required as functionality **within the Portal**, and are related to the share portal system.

#### Definitions
- `MagicLinkAuthentication__ClientSecret`: The symmetric **secret** key used to authenticate the magic links that get generated. This key must line up with the key that is found in the Communications API to work
- `MagicLinkAuthentication__ExpirationHours`: How long the generated token lasts for. **This is only needed if you're generating tokens, which currently happens in the Communications API**

#### Example
```json
  "MagicLinkAuthentication": {
    "ClientSecret": "SECRET",
    "ExpirationHours": 1
  },
```

### Logz.IO Configuration
This is used to set up external logging for debugging across multiple API systems. It should always be set up in deployed environments

#### Definitions
- `LogzIo__Environment`: The environment deployed to; this is used to differentiate services deployed on different environments. Has a value of `DEV`, `PREPROD` or `PROD`
- `LogzIo__Uri`: The connection string (contains a **secret**) used to talk to the logging capture server. Is always in the format of `https://listener-eu.logz.io:8071/?token=<SECRET>&type=app`

#### Example
```json
  "LogzIo": {
    "Environment": "DEV",
    "Uri": "https://listener-eu.logz.io:8071/?token=<SECRET>&type=app"
  },
```

### Notification Api Configuration
This configuration is used to directly talk to the Notifications API. This should be used over the Notify configuration for most scenarios (particularly for internal Portal systems)

#### Definitions
- `NotificationApiConfiguration__BaseUrl`: The URL for the Notification API
- `NotificationApiConfiguration__Scope`: The scope from the Notifications API App Registration

#### Example
```json
  "NotificationApiConfiguration": {
    "BaseUrl": "https://ofq-preprd-common-notifications.azurewebsites.net",
    "Scope": "api://84c3598d-ac00-40a6-b2b4-af2a9838432d/.default"
  }
```

### Notify Configuration
This is used wherever the GOV.UK Notify service is **directly** called. Most of the time, NotificationApiConfiguration should be used instead, but this configuration may be appropriate for systems that contact Citizens directly.

Please note: The official Notify Client we use automatically configures the appropriate URL structure for us, which is why there is no environmental config for going to the correct Notify URL. This does mean that if this URL changes in the future,
all clients will need to be updated to the latest package to continue functioning

#### Definitions
- `Notify__ApiKey`: The **secret** used to authorize contact with the Notify service
- `Notify__Templates__<NAME>TemplateId`: A template ID; these are used to reference the specific template to be used when sending a Notify notification. These IDs are found in the main GOV.UK Notify management portal itself and are not secret.
- `Notify__Urls__<NAME>`: A URL that is referenced within a given template, e.g. a base link to the Portal

#### Example
```json
  "Notify": {
    "ApiKey": "<SECRET>",
    "Templates": {
      "CreateAccountTemplateId": "4ec5b0c3-bf0f-4cd9-937a-7373d7318d8d"
    },
    "Urls": {
      "PortalUrl": "https://theportal.ofqual.gov.uk"
    }
  }
```

---
