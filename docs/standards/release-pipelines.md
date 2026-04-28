---
layout: standard
order: 5
title: Releasing Services to Live
date: 2026-04-07 # this should be the date that the content was most recently amended or formally reviewed
id: OFQ-00005 # Set unique ID for standard
# use `tags: []` for no tags
# Note: tags must use sentence case capitalisation
tags:
  - Digital
  - Infrastructure
  - Data
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related Principles
      items:
        - text: We use the right tools and have the right rules
          href: /principles/we-use-the-right-tools-and-have-the-right-rules/ # Note: use an absolute link from the site home page
        - text: We keep things neat and tidy
          href: /principles/we-keep-things-neat-and-tidy/ # Note: use an absolute link from the site home page
    - title: Related Standards
      items:
        - text: Build Pipelines for Digital Infrastructure
          href: /standards/build-pipelines
---

<!-- Standard description -->

<!-- 

# Notes on line breaks

Please see https://x-govuk.github.io/govuk-eleventy-plugin/markdown/#line-breaks for notes on usage of line breaks.

# Notes on linking to headings within a page

Heading tags are automatically assigned an id, converting spaces to `kebab-case` and applying URL encoding. If you want to link to a specific heading, you can obtain the URL encoded link by running the site locally, inspecting the appropriate <h3> element in the browser's developer tools and copying the value from the 'id' attribute.
-->

This standard defines how developers, data and infrastructure engineers, as well as any other team that makes changes to a live environment hosting a service, must set up and conduct their releases.

It is expected that release pipelines are used in all deployed services, the exception for static apps, which are controlled via the Build Pipelines. 

Third party systems and content updates should be controlled and audited centrally too, with the same rigour as the in-house developed platforms.

---

## Requirement(s)

<!-- Populate list for each requirement (there can be more than 2) -->

<!--

# Notes on anchor links

Use HTML URL encoding as in the 'Notes on links' above, to ensure that links to headers with punctuation works as expected. For example:

[Product documentation MUST include build, release and deployment processes](#product-documentation-must-include-build%2C-release-and-deployment-processes)

-->

- [All releases and changes to live must be repeatable](#all-releases-and-changes-to-live-must-be-repeatable)
- [Changes must be proven in at least one pre-production environment before going live](#changes-must-be-proven-in-at-least-one-pre-production-environment-before-going-live)
- [Changes must be delivered through automated release mechanisms](#changes-must-be-delivered-through-automated-release-mechanisms)
- [All releases and changes to live must be auditable and recorded](#all-releases-and-changes-to-live-must-be-auditable-and-recorded)
- [Live releases must have two-stage authorisation](#live-releases-must-have-two-stage-authorisation)
- [Release pipelines MUST have a Dev stage that deploys automatically](#release-pipelines-must-have-a-dev-stage-that-deploys-automatically)
- [Release pipelines MUST have a Preprod stage that deploys manually](#release-pipelines-must-have-a-preprod-stage-that-deploys-manually)
- [Release pipelines MUST have a Prod stage that requires managerial approval](#release-pipelines-must-have-a-prod-stage-that-requires-managerial-approval)

### All releases and changes to live must be repeatable

All releases and changes to live must be repeatable and follow the same steps in all pre-production environments and then into the live environment. This provides consistency, certainty and confidence that any release which has been proven in a previous environment will be robust in the next.

### Changes must be proven in at least one pre-production environment before going live

No change should be made to live unless it has been proven in at least one pre-production environment. Normally, releases and changes should be made in a Dev environment, then once satisfied that it passes the prescribed testing, manually released to Pre-prod for more live-like checks, and then on to live.

### Changes must be delivered through automated release mechanisms

No changes to live (or any other environment) should be made manually. Automation removes the ability for steps to be forgotten, missed, or not undertaken correctly. It also prevents changes from being overwritten by other changes.

### All releases and changes to live must be auditable and recorded

All releases and changes to live must be auditable and recorded in the central release log. This provides the ability to validate unexpected behaviour and identify unauthorised changes being made to live.

### Live releases must have two-stage authorisation

Only authorised senior members of the team can make changes to the live environment, and they must be signed off by another senior team member or manager before being allowed to go live. The pipelines should have this staged approval included within them.

### Release pipelines MUST have a Dev stage that deploys automatically

The Dev stage provides an automated deployment environment where new changes are continuously deployed. This allows developers to quickly validate their changes in a deployed environment and ensure the release pipeline itself functions correctly without manual intervention.

**Exception:** GovForms does not have a dedicated Dev environment. For GovForms releases, the QA environment fulfils the role of pre-production and aligns with the Preprod requirement, with Live as the production environment.

### Release pipelines MUST have a Preprod stage that deploys manually

The Preprod stage provides a manual deployment step to a pre-production environment that closely mirrors the live environment. This stage requires explicit approval before deployment, allowing teams to perform comprehensive testing and validation before any changes reach live. Manual deployment at this stage prevents accidental releases and ensures changes have been properly reviewed.

### Release pipelines MUST have a Prod stage that requires managerial approval

The Production stage is the final deployment step and must require approval from a senior team member or manager before changes are released to live. This two-stage authorisation ensures that only authorised personnel can approve production releases, maintaining control and accountability over live environment changes.
