---
layout: standard
order: 15
title: IaC Build Configuration Standard
date: 2025-11-10
id: OFQ-00015
tags:
  - Guide
  - Meta
  - IaC
  - Infrastructure
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related Standards
      items:
        - text: Secret Management
          href: /standards/secret-management/ # Note: use an absolute link from the site home page
    - title: Related Principles
      items:
        - text: How To Maintain Key Vaults
          href: /patterns/how-to-maintain-key-vaults-IaC/
---

This standard defines how developers are to implement IaC bicep configuration files in digital services; Every repo implementing an IaC containerized deployment policy must implement this.

---

## Requirement(s)

- [IaC must follow a standard folder structure](#infrastructure-as-code-folder-structure)
- [The name of the bicep configuration file must follow the defined format](#the-configuration-file-name-follows-a-standard)
- [The bicep configuration file must be in the form of our template](#bicep-configuration-file-template)
- [The bicep configuration file must define the tags](#bicep-configuration-tags)
- [The bicep configuration file must define the environment variables](#bicep-configuration-environment-variables)
- [The bicep configuration file must map the secrets being used](#bicep-configuration-secrets)
- [The bicep configuration file must define the docker container image to be deployed](#bicep-configuration-image-name)
- [the bicep configuration file must define the runtime machine](#bicep-configuration-processor)
- [the bicep configuration file must define the environment; dev/pprd/prd](#bicep-configuration-enviroment)

---

### Infrastructure As Code Folder Structure
There must be folder called 'Bicep' must be added to the repositories root folder

### Bicep Configuration Filename Format
The name of the configuration file will be in the form {env}-{service}_parameters.json  eg for experts apply api in dev it would be called dev-expert-apply-api_parameters.json

### Bicep Configuration Tags
This define tags for use elsewhere in the system.

- Tag "environment", for dev or pre prod set this to "Dev/Test" for production set to "Prd".
- Tag "service", this is common for all environments and should reflect the service, so for example "service": "ExpertApply API",
- Tag "team", this is common for all environments and should be set to "RS Team"

###eg
```yaml
    "tags": {
      "value": {
        "environment": "Dev/Test",
        "service": "ExpertApply API",
        "team": "RS Team"
      }
    }
```

### Bicep Configuration Environment Variables
This section defines the environment variables to be used by the service.  Environment variable either map to a secret in a key vault or in the case of a non secret to a direct value.

- Tag "name", this defines the name of the environment variable, the name defines the group and the field in the group and have this format {group}__{fieldName}.
- Tag "secretRef", if the environment variable data is a secret this is a reference to where the secret is stored (see secrets below).
- Tag "value", if the environment variable is not a secret or a common value then it can be set directly.

###eg
```yaml
"envVars": 
{ "value": 
    [
       { "name": "ApiAuth__AadInstance", "secretRef": "api-auth-aad-instance" },
       { "name": "AzureStorageFolder", "value": "ofq-citizen-dev" } 
    ]
  },
```

### Bicep Configuration Secrets
This section defines the secret references to be used by the environment variables to be used by the service. 

- Tag "name", this is the reference to be used above in envVars, the name should be meaningful and cannot contain any special characters apart from '-'
- Tag "keyVaultUrl", this is the location of the secret in our Azure workspace.  To access these the dev will have to PIM themselves up for secret access.

###eg
```yaml
  "secrets": 
  { "value": 
    [
       { "name": "api-auth-aad-instance", "keyVaultUrl": "https://..." },
    ]
}
```

### Bicep Configuration Image Name

- Tag "imageName", this is the container registry repository name.  This is defined in the build pipeline

### Bicep Configuration Image Tag

- Tag "imageTag", this is the container image version to use and should be set to latest

### Bicep Configuration Container Registry

- Tag "containerRegistry", this is the login server address for the container registry that the image is being stored in, this is defined in the build pipeline. 
1. Dev/Preprod - crofqappdev1.azurecr.io
2. Prod - crofqportal.azurecr.io

### Bicep Configuration Processor 

- Tag "containerAppCpu", this defines the number of cpu's and should always be set to 1 unless an infrastructure engineer defines otherwise.

### Bicep Configuration Memory

- Tag "containerAppMem", this defines the memory to be made available to the container app and should always be set to 2.0Gi unless and infrastructure engineer defines otherwise.

### Bicep Configuration Container App Name

Tag "acaAppName", this defines part of the container app name and should relect the service ###eg "expert-apply-api"

### Bicep Configuration Enviroment

There must be a config file per environment as this configuration files are processed as part of the release pipeline. The environment is specifed by "acaEnvName", this defines the environment these are the options;

- for dev environment - devAcaEnv
- for pre prod environment - pprdAcaEnv
- for prod environment - prdAcaEnv

### Bicep Configuration uamIdName

Set this field accourding to the environment required

- for dev environment - devUamId
- for pre prod environment - pprdUamId
- for prod environment - prdUamId

---


### Bicep Configuration File Template

This is the template for our IaC bicep configuration files.

``` yaml
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "tags": {
      "value": {
        "environment": "",
        "service": "",
        "team": ""
      }
    },
    "envVars": {
      "value": 
      [
      ]
    },
    "secrets": {
      "value": 
      [
      ]
    },
    "containerAppCpu": {
      "value": 1
    },
    "containerAppMem": {
      "value": "2.0Gi"
    },
    "imageName": {
      "value": ""
    },
    "imageTag": {
      "value": "latest"
    },
    "acaAppName": {
      "value": ""
    },
    "acaEnvName": {
      "value": ""
    },
    "containerRegistry": {
      "value": ""
    },
    "uamIdName": {
      "value": ""
    }
  }
}

```


