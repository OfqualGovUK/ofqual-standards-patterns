---
layout: standard
order: 18
title: Identity broker usage
date: 2026-02-24 
id: OFQ-00018 

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

A unified identity across the Ofqual estate will provide: 

- Standard protocol for authentication, authorisation and single sign-on (SSO)
- Maintain a separation of concerns by using distinct Identity Providers (IdPs) for internal and external users 
- Ensuring back-end services are authenticated from a centralised identity source


Currently used Identity Providers with the Ofqual estate: 
- Azure Entra: Internal Ofqual users and Approved Organisations (AOs) 
- Azure B2C: Prospective Approved Organisations (PAOs) 
- UK One Gov Login: Citizens, centrally managed by UK Gov  


---

## Requirement(s)

- [Use Keycloak as an identity broker for authentication and authorisation](#use-keycloak-as-an-identity-broker-for-authentication-and-authorisation)



### Use Keycloak as an identity broker for authentication and authorisation
Keycloak MUST be used to federate the multiple identity providers and provide a single authentication and authorisation point to back-end services. 



---
