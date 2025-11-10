---
layout: pattern
order: 4
title: How to maintain secrets with key vaults IaC
date: 2025-11-06 # this should be the date that the content was most recently amended or formally reviewed
# use `tags: []` for no tags 
# Note: tags must use sentence case capitalisation
tags:
  - Security
  - Digital
  - IaC
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related Standards
      items:
        - text: Secret Management
          href: /standards/secret-management/ # Note: use an absolute link from the site home page
        - text: IaC Bicep Configuration
          href: /standards/standard-iac-bicep-configuration/ 
---

<!-- Pattern description -->

<!-- 

# Notes on line breaks

Please see https://x-govuk.github.io/govuk-eleventy-plugin/markdown/#line-breaks for notes on usage of line breaks.

# Notes on linking to headings within a page

Heading tags are automatically assigned an id, converting spaces to `kebab-case` and applying URL encoding. If you want to link to a specific heading, you can obtain the URL encoded link by running the site locally, inspecting the appropriate <h3> element in the browser's developer tools and copying the value from the 'id' attribute.
-->

---

## Introduction

For local development, it is acceptable to use a developer environment file, such as appsettings.development.json, so long as it is appropriately gitignored and not checked into an repo or published source.  This how to guide seeks to identify how we as part of good security architecture, developers use key vaults to support our good secret management principles to protect our sensitive resources, such as database connections strings and tokens. This document outlines our approach for this across all Digital products.


### Use Of Common Key Vaults

Use the existing common key vault for secrets that are common across services (such as connection strings to a database that gets reused). This key vault is not controlled via Infrastructure as Code (Iac). Ensure all values are marked as secret. As developers it is our responsiblity to maintain this key vault. Always define what the key vault value is intended for. To maintain good house keeping any secrets no longer being used by our services should be removed. 

### Use of Local Key Vaults

- Local key vault creation, maintance and deployment is controlled by IaC and the infrastructure team.
- As developers it is our responsiblility to ensure that the data source for these key vaults is maintained.  For test purposes we can update a local key vault directly, however, when making a change to the key vault adding, removing or changing a secret we must update the data source.  For security reasons the data source we will use for our key vaults will be the Azure DevOps pipeline library variable group.
- When deploying an api/app that has impacted upon our key vaults then at each stage of deployment process dev/preprod/prod you must request infrastructure to deploy the affected key vault bicep.

### Azure DevOps pipeline library variable groups

- These are located under the pipeline menu in Azure devops.  
- There must be a variable group for each key vault.
- All values in a variable group must be marked as secret.
- The format of a variable group name is ofq-{env}-{service}-{service-type}-vg. service type is api/app/fcn.


## Environment Variable Configuration 

Each repo will have a Bicep folder, this folder will have for each environment (eg. dev/preprod/prod) a yaml file which gets processed by the bicep to create the deployed environment and sets up in part the environment variables. The environment variables are configured in 2 parts "secrets" where the secret is and "envVars" mapping the secret to an environment variable.  So the yaml environment part basically says create these environment variables and either get the value from one of the a secret key vault or in the case of a plain environment value it can be entered directly.

eg
```yaml
"envVars": 
{ "value": 
    [
       { "name": "ApiAuth__AadInstance", "secretRef": "api-auth-aad-instance" },
       { "name": "ApiAuth__AppIdUri", "secretRef": "api-auth-app-id-uri" },
       { "name": "ApiAuth__ClientId", "secretRef": "api-auth-client-id" },
       { "name": "ApiAuth__ClientSecret", "secretRef": "api-auth-client-secret" },
       { "name": "AzureStorageFolder", "value": "ofq-citizen-dev" } 
    ]
  },
  "secrets": 
  { "value": 
    [
       { "name": "api-auth-aad-instance", "keyVaultUrl": "https://..." },
       { "name": "api-auth-app-id-uri", "keyVaultUrl": "https://..." },
       { "name": "api-auth-client-id", "keyVaultUrl": "https://..." },
       { "name": "api-auth-client-secret", "keyVaultUrl": "https://..." }
    ]
},

```

The formatting of this is custom to us and needs explanation.
- "secrets" and "keyvaultUrl" this is the address of the variable in the local/common key vault. To access this you will need to PIM yourself up and via the Azure dashboard lookup the address of the variable.
- "secrets" and "name" can be anything meaningful however don't use special characters apart from '-'
- "envVars" and "name" defines the variable group and item. 
- "enVars" and "secretRef" tells the bicep to map the environment variable to a key vault entry.
- "enVars" and "value" tells the bicep to map the environment variable to a direct value, **do not use this for secrets!**  

example,

```yaml
{ "name": "ApiAuth__AadInstance", "secretRef": "api-auth-aad-instance" }
```
the variable group is ApiAuth the variable is AadInstance and its mapped to the secret ref. The __ tells the bicep that is a group


---
