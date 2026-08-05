---
layout: standard
order: 10
title: Versioning
date: 2025-10-29 # this should be the date that the content was most recently amended or formally reviewed
id: OFQ-00010 # Set unique ID for standard
# use `tags: []` for no tags
# Note: tags must use sentence case capitalisation
tags:
  - Digital
  - Data
  - Infrastructure
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related principles
      items:
        - text: We keep things neat and tidy
          href: /principles/we-keep-things-neat-and-tidy/ # Note: use an absolute link from the site home page
    - title: External documentation
      items:
        - text: A learning article that describes versioning techniques
          href: https://opensource.creativecommons.org/blog/entries/2022-11-11-calver-to-semver/
---

<!-- Standard description -->

<!-- 
# Notes on line breaks
Please see https://x-govuk.github.io/govuk-eleventy-plugin/markdown/#line-breaks for notes on usage of line breaks.
# Notes on linking to headings within a page
Heading tags are automatically assigned an id, converting spaces to `kebab-case` and applying URL encoding. If you want to link to a specific heading, you can obtain the URL encoded link by running the site locally, inspecting the appropriate <h3> element in the browser's developer tools and copying the value from the 'id' attribute.
-->

Standardised versioning provides several key benefits:
 
- **Clarity & Readability** – Changes are easier to understand at a glance.
- **Predictability** – Developers can anticipate the nature of changes based on version numbers at a glance.
- **Dependency Management** – Package managers rely on versioning to manage and resolve dependencies.
- **Best Practices & Reputation** – Adopting a structured approach aligns with industry standards and enhances credibility in the open-source community.
 
This guide outlines the expectations for commit messages in all public-facing repositories.

---

## Requirement(s)

<!-- Populate list for each requirement (there can be more than 2) -->

<!--
# Notes on anchor links
Use HTML URL encoding as in the 'Notes on links' above, to ensure that links to headers with punctuation works as expected. For example:
[Product documentation MUST include build, release and deployment processes](#product-documentation-must-include-build%2C-release-and-deployment-processes)
-->

- [Versioning format MUST follow this structure](#versioning-format-must-follow-this-structure)
- [Examples](#examples)

### Versioning format MUST follow this structure

#### SemVer
Each commit message should follow this structure:
```v[MAJOR].[MINOR].[PATCH]```
- ```MAJOR``` - Bump this when a large functionality has been added, alternatively we can bump this at every sprint?
- ```MINOR``` - Bump this when a medium functionality has been added, such as a story that is worth 5-8 points.
- ```PATCH``` - Bump this when a small functionality has been added, or a content change, such as a story that is worth 1-3 points.

#### CalVer
```v[YEAR].[MONTH].[DAY].[PATCH]```
- ```YEAR``` - The current year
- ```MONTH``` - The current month
- ```DAY``` - The current day
- ```PATCH``` - Increment by 1 for each new version

### Examples

#### SemVer
```v1.5.6``` - A release version that has 5 minor functionality changes and 6 patches
```v5.1.0``` - A release version that has 5 major functionality changes, 1 minor & no patches
```v0.4.7``` - A pre-release version that has 4 minor changes and 7 patches

#### CalVer
```v2025.10.29.1``` - A version that was produced as the first patch on 29/10/2025
```v2024.03.23.5``` - A version that was produced as the fifth patch on 23/03/2024
```v2025.08.15.3``` - A version that was produced as the third patch on 15/08/2025

---