---
layout: standard
order: 11
title: IaC Build Configuration Standard
date: 2025-11-30
id: OFQ-00011
tags:
  - Guide
  - Meta
  - IaC
---

This standard defines how developers are to implement IaC bicep configuration files in digital services; Every repo implementing an IaC containerized deployment policy must implement this.

---

## Requirement(s)

- [To be compatible with our IaC standard a folder called 'Bicep' must be added to the repositories root folder](#an-ioc-must-have-a-bicep-folder)
- [To be compatible with our IaC standard there must be a config file per environment](#the-bicep-folder-must-contain-a-config-file-per-environment)
- [To be compatible with our IaC standard the name of the configuration file will be in the form {env}-{service}_parameters.json](#the-configuration-file-name-follows-a-standard)

---

Every repo implementing an IaC containerized deployment policy must implement this.
1. A folder must be added to the Repo folder root called Bicep.
2. Inside this folder the developer will add bicep configuration files, one for each environment (see example below)
3. The name of the configuration file will be in the form {env}-{service}_parameters.json  eg for experts apply api in dev it would be called dev-expert-apply-api_parameters.json


### IaC Bicep Configuration File Template

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

### Bicep Configuration Tags
This define tags for use elsewhere in the system.

1. environment; for dev or pre prod set this to "Dev/Test" for production set to "Prd".
2. service; this is common for all environments and should reflect the service, so for example "service": "ExpertApply API",
3. team; this is common for all environments and should be set to "RS Team"

example 
```yaml
    "tags": {
      "value": {
        "environment": "Dev/Test",
        "service": "ExpertApply API",
        "team": "RS Team"
      }
    }
```

### Bicep Configuration EnvVars
This section defines the environment variables to be used by the service.  Environment variable either map to a secret in a key vault or in the case of a non secret to a direct value.

1. name; this defines the name of the environment variable, the name defines the group and the field in the group and have this format {group}__{fieldName}
2. secretRef; if the environment variable data is a secret this is a reference to where the secret is stored (see secrets below).
3. value; if the environment variable is not a secret or a common value then it can be set directly

example 
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

1. name; this is the reference to be used above in envVars, the name should be meaningful and cannot contain any special characters apart from '-'
2. keyVaultUrl; this is the location of the secret in our Azure workspace.  To access these the dev will have to PIM themselves up for secret access.
example
```yaml
  "secrets": 
  { "value": 
    [
       { "name": "api-auth-aad-instance", "keyVaultUrl": "https://..." },
    ]
}
```
### Bicep Configuration containerAppCpu
This defines the number of cpu's and should always be set to 1 unless an infrastructure engineer defines otherwise.

### Bicep Configuration containerAppMem
This defines the memory to be made available to the container app and should always be set to 2.0Gi unless and infrastructure engineer defines otherwise.

### Bicep Configuration imageName
This is the container registry repository name.  This is defined in the build pipeline

### Bicep Configuration imageTag
This is the container image version to use and should be set to latest

### Bicep Configuration acaAppName
This defines part of the container app name and should relect the service eg "expert-apply-api"

### Bicep Configuration acaEnvName
This defines the environment there are there options;
1. dev - devAcaEnv
2. pre prod - pprdAcaEnv
3. prod - prdAcaEnv

### Bicep Configuration containerRegistry
This is the login server address for the container registry that the image is being stored in, this is defined in the build pipeline. 
1. Dev/Preprod - crofqappdev1.azurecr.io
2. Prod - crofqportal.azurecr.io


### Bicep Configuration uamIdName

Set this field accourding to the environment required

| Environment | UAM ID     |
|-------------|------------|
| Dev         | devUamId   |
| Pre Prod    | pprdUamId  |
| Prod        | prdUamId   |

---




