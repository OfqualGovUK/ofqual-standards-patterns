---
layout: standard
order: 8
title: Static Web Applications
date: 2025-10-01 # this should be the date that the content was most recently amended or formally reviewed
id: OFQ-00008 # Set unique ID for standard
# use `tags: []` for no tags
# Note: tags must use sentence case capitalisation
tags:
  - Digital
  - Infrastructure
  - Product
  - UX
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related standards
      items:
        - text: Build Pipelines
          href: /standards/build-pipelines/ # Note: use an absolute link from the site home page
        - text: Release Pipelines
          href: /standards/release-pipelines/ # Note: use an absolute link from the site home page
---

<!-- Standard description -->

<!-- 

# Notes on line breaks

Please see https://x-govuk.github.io/govuk-eleventy-plugin/markdown/#line-breaks for notes on usage of line breaks.

# Notes on linking to headings within a page

Heading tags are automatically assigned an id, converting spaces to `kebab-case` and applying URL encoding. If you want to link to a specific heading, you can obtain the URL encoded link by running the site locally, inspecting the appropriate <h3> element in the browser's developer tools and copying the value from the 'id' attribute.
-->

For some services, the use of a full-blown C# application or CRM system is not proportionate to the goals the service should achieve, and a lightweight solution is called for instead. This is particularly the case when we want non-developers to be able to contribute to sites in an effective manner, without overloading them with a technology knowledge burden. This is where a static web app comes in; this is where a prebuilt, distributable folder with HTML, CSS and JS is used to serve a basic website. Good use cases include documentation websites such as this one, and for simple sites such as the shutter pages.

Note that all relevant development standards are still relevant, including standards for [Build Pipelines](/standards/build-pipelines), [Secret Management](/standards/secret-management) and [Security](/standards/security-in-first-party-software)

---

## Requirement(s)

<!-- Populate list for each requirement (there can be more than 2) -->

<!--

# Notes on anchor links

Use HTML URL encoding as in the 'Notes on links' above, to ensure that links to headers with punctuation works as expected. For example:

[Product documentation MUST include build, release and deployment processes](#product-documentation-must-include-build%2C-release-and-deployment-processes)

-->

- [Static Apps MUST only be used for simple websites](#static-apps-must-only-be-used-for-simple-websites)
- [Static Apps MUST use Node with an approved build and deployment tools](#static-apps-must-use-node-with-an-approved-build-tool)


### Static Apps MUST only be used for simple websites

- Static Apps are intended to be truly lightweight applications, otherwise their value is lost. 
- We should only serve front-end websites that do not reach out to other APIs. The Static Web App deployment can facilitate the deployment of Azure Functions for a back-end, but you **must never** use this - particularly as there is not an available region for this functionality in the UK for unknown reasons.
- In most cases, sites that require data entry should not be made as a Static App, as these tend to involve more complexity and may introduce additonal security requires. Exceptions are for search bars tha are implemented by build tools, such as those used by our eleventy based documentation.
- Any form of site that requires authentication should not be a static site

### Static Apps MUST use Node with an approved build tool

- All static sites should use Node and one of the following tools to create the static site:
    - [Eleventy](https://www.11ty.dev/) for documentation sites, preferably with the use of the [GOV.UK Eleventy Plugin](https://github.com/x-govuk/govuk-eleventy-plugin)
    - [Vite](https://vite.dev/) for non-documentation sites, using the standard install path for the [GOV.UK Design System](https://frontend.design-system.service.gov.uk/installing-with-npm/)
- All static sites should be deployed onto an Azure Static Web App using the guidance found in the [Build Pipelines](/standards/build-pipelines).
- Automated testing is optional but encouraged

---
