---
layout: standard
order: 10
title: Infrastructure as Code
date: 2025-11-06
id: OFQ-00010
tags:
  - Digital
  - Infrastructure
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related links
      items:
        - text: We keep things neat and tidy
          href: /principles/we-keep-things-neat-and-tidy/
        - text: We use the right tools and have the right rules
          href: /principles/we-use-the-right-tools-and-have-the-right-rules/
---

<!-- Standard description -->

<!-- 

# Notes on line breaks

Please see https://x-govuk.github.io/govuk-eleventy-plugin/markdown/#line-breaks for notes on usage of line breaks.

# Notes on linking to headings within a page

Heading tags are automatically assigned an id, converting spaces to `kebab-case` and applying URL encoding. If you want to link to a specific heading, you can obtain the URL encoded link by running the site locally, inspecting the appropriate <h3> element in the browser's developer tools and copying the value from the 'id' attribute.
-->

---

## Overview

Infrastructure as Code is an essential discipline when deploying and maintaining new and existing environments. 
IaC delivers a consistent baseline when deploying infrastructure, ensuring that there is no deviation in our deployments between services, providing assurance that infrastructure-based issues will be kept to a minimum. 

Good IaC must be modular, allowing for reusability throughout different environments, as well as secure through the use of other standards, such as Secret Management.

IaC must be clear and well formatted, clearly demonstrating it's purpose for deployment within the estate in a format which is easy to read for someone to follow with minimal pre-existing context.

## Requirement(s)

- [IaC must be written using Microsoft Bicep](#iac-must-be-written-using-microsoft-bicep)

- [IaC must be considered first](#iac-must-be-considered-first)

- [IaC must be modular](#iac-must-be-modular)

- [IaC must be hosted in Azure DevOps](#iac-must-be-hosted-in-azure-devops)

### IaC must be written using Microsoft Bicep

Infrastructure as Code must always be written using Microsoft Bicep. 
This framework is standard within the estate, and consistent usage achieves consistency and reliability throughout our deployments. 

### IaC must be considered first

When deploying new infrastructure resource, utilisiation of IaC must be considered before any other method for deployment. Certain edge-cases may lead to the utilisation of other deployment methods, such as time-sensitive deployments where no existing template exists. However, IaC must be considered before deciding on other deployment methods.

### IaC must be modular

Where there is a requirement for multiple resource deployment, IaC must be written in a modular format, housing each module in it's own Bicep file, which is then orchestrated by a main.bicep file.
IaC must also be written using a separate parameters file, so that changes to the parameters of the deployed infrastructure can be done without direct interaction into the Bicep files.

### IaC must be hosted in Azure DevOps

When new Bicep deployments have been created, they must be held under the "Ofqual.Infrastructure" or "Ofqual.Infrastructure.Future" repositories in Azure DevOps. 

Ofqual.Infrastructure.Future is for future-tech proof-of-concepts.
Ofqual.Infrastructure is the general-purpose repository for IaC. When developing new IaC, a new branch must be created in such a way that the branch can be used individually to deploy the infrastructure required.

---