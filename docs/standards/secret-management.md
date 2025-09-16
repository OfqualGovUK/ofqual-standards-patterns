---
layout: standard
order: 7
title: Secret Management
date: 2025-089-16 # this should be the date that the content was most recently amended or formally reviewed
id: OFQ-00007 # Set unique ID for standard
# use `tags: []` for no tags
# Note: tags must use sentence case capitalisation
tags:
  - Digital
  - Infrastructure
  - Data
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related principles
      items:
        - text: We keep things neat and tidy
          href: /principles/we-keep-things-neat-and-tidy/ # Note: use an absolute link from the site home page
    - title: Related standards
      items:
        - text: Security in First Party Software
          href: /standards/security-in-first-party-software/ # Note: use an absolute link from the site home page

          
---

<!-- Standard description -->

<!-- 

# Notes on line breaks

Please see https://x-govuk.github.io/govuk-eleventy-plugin/markdown/#line-breaks for notes on usage of line breaks.

# Notes on linking to headings within a page

Heading tags are automatically assigned an id, converting spaces to `kebab-case` and applying URL encoding. If you want to link to a specific heading, you can obtain the URL encoded link by running the site locally, inspecting the appropriate <h3> element in the browser's developer tools and copying the value from the 'id' attribute.
-->

As part of good security architecture, developers must use good secret management principles to protect sensitive resources, such as databases and blob stores. This document outlines our approach for this across all Digital products


---

## Requirement(s)

<!-- Populate list for each requirement (there can be more than 2) -->

<!--

# Notes on anchor links

Use HTML URL encoding as in the 'Notes on links' above, to ensure that links to headers with punctuation works as expected. For example:

[Product documentation MUST include build, release and deployment processes](#product-documentation-must-include-build%2C-release-and-deployment-processes)

-->

- [Managed Identites MUST be used over secrets where possible](#managed-identities-must-be-used-over-secrets-where-possible)
- [Secret information MUST be stored in Key Vaults when Managed Identities is unavailable](#secret-information-must-be-stored-in-key-vaults-when-managed-identities-is-unavailable)
- [Secrets MUST be revoked when deemed compromised](#secrets-must-be-revoked-when-deemed-compromised)

### Managed Identites MUST be used over secrets where possible

- Managed Identities is a technology present in Azure that allows for secure communication between services, such as communication to a database or a blob store
- This technology completely eliminates the need to store any secrets whilst still maintaining secure communication, and must be prioritised as an option before relying on other options like connection strings
- In production and preproduction, services should only be configured to talk to other Azure services (preferably through system-assigned identities)
- In dev, systems may also be configured to accept specific Developer and QA users to facilitate local testing and development.
  - See [the MSFT documentation](https://learn.microsoft.com/en-us/dotnet/api/overview/azure/identity-readme?view=azure-dotnet#authenticate-with-defaultazurecredential) for methods of local user authentication for Managed Identities; note that the service you are connecting to must also be configured to accept you as an authorized user
- If a system has been converted to using Managed Identities, then old secrets should be revoked and removed at the earliest available opportunity

### Secret information MUST be stored in Key Vaults when Managed Identities is unavailable

- For situations where Managed Identities cannot be used (such as connection strings to non-Azure services), secrets should be stored in an Azure Key Vault (or equivalent should Azure Key Vault cease to exist).
- Azure Key Vaults should be configured on a per environment basis. A common key vault may be used for secrets that are common across services (such as connection strings to a database that gets reused); otherwise, a key vault should be made for each specific service if that service requires a secret that only it should use. This reduces the “blast radius” if a vault were to be breached and means secrets are not duplicated across multiple areas.
- All secrets stored in Azure should be protected using Privileged Identity Management so that only developers and infrastructure engineers have access to secrets.
- Key vaults should be configured to use “soft-delete” functionality to allow for recovery in the event of accidental deletion
- If a container application has not yet been converted to using an Azure Key Vault, it is acceptable to temporarily store secrets in the ‘Secrets’ section of the Container App until such a move to a key vault can take place. It is also acceptable for secrets to be stored in this section if automatically generated by the Container Apps for the purpose of pulling images from the Container Registration
- Key vaults should be named in the format of “kv-{env}-{product-name}” where the {product-name} is the product the key vault is related to (e.g. “Recognition”) and the {env} is the environment the key vault is used in (e.g. “dev”). The only exception is for common key vaults, which should be named “ofq-kv-{env}-common”

#### Secret Design

- Secrets should **never** be stored in code, and should be referenced as environment variables via a connected key vault
- As Key Vaults can be connected to Container Apps and pass secrets through as environment variables, it is not necessary to write code to do this
- For local development, it is acceptable to use a developer environment file, such as appsettings.development.json, so long as it is appropriately gitignored and not checked in
- Configuration files should not contain example values of secrets and should simply declare that the value is a secret. Documentation should be provided in code (whether in the configuration file or in the README document of the repository) defining what the value is used for. Common sets of secrets/configuration may also be documented as a pattern on this site
- Secrets should only be used for the purpose they were intended, and named accordingly, for ease of identification. Secrets should be named identically to the environment variable they correspond to for ease of tracking; if this is not possible (e.g. in the case of secrets used outside of deployed environments), they should be named according to their purpose.
- Where possible, an expiry date should be considered for cryptographic secrets to enforce regular key rotation. Currently, App Registrations expire keys after 18 months as this balances the resource required to maintain the secrets vs security risk. If automated key rotation is available, this should also be configured to reduce resource burden. Notifications should also be made whenever a key is about to expire, so that planned revocations and replacements can take place without causing service disruption (Key Vaults provide functionality for this)
- Any requirement for a new secret should be requested as part of the high level design work which is reviewed by a Senior / Lead developer; designs should be checked to ensure that a secret does not already exist that can be referenced instead

### Secrets MUST be revoked when deemed compromised

- Secrets must be revoked if they are deemed compromised by a member of the security team or developer team, or if the system using the secret is no longer in use.
- If secrets are to be revoked, then product owner and a developer should be involved in the decision before it is actioned. This will allow the impacts to be understood before it is revoked. The requesting ‘revoker’ is responsible for satisfying that the right people have been involved before revoking a secret.
- Azure Key Vault tracks when a secret has been revoked. If the secret was compromised key, it should be replaced as part of the revocation process. Key vaults connected to container apps will then automatically update their environment variables to use the new secret.

---
