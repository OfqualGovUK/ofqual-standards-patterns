---
layout: standard
order: 19
title: APIM usage
date: 2026-02-24 
id: OFQ-00019

tags:
  - Digital
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related Principles
      items:
      - text: We use the right tools and have the right rules
      - href: /principles/We-use-the-right-tools-and-have-the-right-rules/
      - text: We design and continuously develop services that are durable and resilient
      - href: /principles/We-design-and-continuously-develop-services/
      - text: We keep things neat and tidy
      - href: /principles/We-keep-things-neat-and-tidy/
      - text: We understand and manage the threats we face
      - href: //principles/We-understand-and-manage-the-threats-we-face/
     # - text: Writing a standard
       #  href: /standards/writing-a-standard/ # Note: use an absolute link from the site home page
---

Azure API Management (APIM) is used to provide an API management layer and API Gateway for Ofqual. 

By using Azure APIM Ofqual can 
- Simplify and secure access to APIs 
- Monitor performance and usage 
- Make backend services easier to update and maintain 

Azure APIM acts as an API Gateway, providing a single entry-point into Ofqual APIs. 
Each environment will contain an Azure APIM instance within its own subnet, leveraging network isolation and secure controlled access for internal and external API consumers. 


---

## Requirement(s)

- [Azure APIM MUST be used as an API Gateway to provide a single entry-point into Ofqual APIs.](#azure-apim-must-be-used-as-an-api-gateway-to-provide-a-single-entry-point-into-Ofqual-APIs)
- [Each environment MUST contain an Azure APIM instance within its own subnet - leveraging network isolation and secure controlled access for internal and external API consumers.](#each-environment-must-contain-an-azure-apim-instance-within-its-own-subnet-leveraging-network-isolation-and-secure-controlled-access-for-internal-and-external-api-consumers)

### Azure APIM MUST be used as an API Gateway to provide a single entry-point into Ofqual APIs. 

### Each environment MUST contain an Azure APIM instance within its own subnet - leveraging network isolation and secure controlled access for internal and external API consumers. 


---
