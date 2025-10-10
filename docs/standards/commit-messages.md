---
layout: standard
order: 9
title: Commit Messages
date: 2025-10-10 # this should be the date that the content was most recently amended or formally reviewed
id: OFQ-00009 # Set unique ID for standard
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
        - text: A learning article that describes best practices, coventions and usages of commit messages
          href: https://www.gitkraken.com/learn/git/best-practices/git-commit-message 
---

<!-- Standard description -->

<!-- 

# Notes on line breaks

Please see https://x-govuk.github.io/govuk-eleventy-plugin/markdown/#line-breaks for notes on usage of line breaks.

# Notes on linking to headings within a page

Heading tags are automatically assigned an id, converting spaces to `kebab-case` and applying URL encoding. If you want to link to a specific heading, you can obtain the URL encoded link by running the site locally, inspecting the appropriate <h3> element in the browser's developer tools and copying the value from the 'id' attribute.
-->

From June 2025, Ofqual now implements standardised commit messages to provide several key benefits:

- Best practices & reputation, adopting a structured approach aligns with industry standards and enhances credibility in the open-source community.
- Improved searchability which gives a consistent history that makes finding specific changes simpler.
- Efficient bebugging to allow for problematic commits to be quickly identified for rollbacks.
- Clarity & readability which makes changes are easier to understand at a glance.

---

## Requirement(s)

<!-- Populate list for each requirement (there can be more than 2) -->

<!--

# Notes on anchor links

Use HTML URL encoding as in the 'Notes on links' above, to ensure that links to headers with punctuation works as expected. For example:

[Product documentation MUST include build, release and deployment processes](#product-documentation-must-include-build%2C-release-and-deployment-processes)

-->

- [Commit Message Format](#commit-message-format-must-follow-this-structure)
- [Components](#components-you-must-use-in-commits)
- [Examples](#examples)

### Commit message format MUST follow this structure

`[TICKET_NUMBER] PREFIX: Description`

### Components you MUST use in commits

1. Ticket Number – Enclosed in square brackets (e.g. ```[49102]```) 
**OR**
Hotfix - Enclosed in square brackets (e.g. ```[HOTFIX]```)
 
2. Prefix – A standardised keyword indicating the type of change:
 
    - ```ADD``` – For new features, libraries, or functionality.
 
    - ```REMOVE``` – For deletions of unnecessary code or dependencies.
 
    - ```MODIFY``` – For updates, fixes, or modifications to existing code.

    - ```WIP``` - For incomplete work that is incomplete or non-functional.

    - ```FWIP``` - For incomplete work that is incomplete, but is functional (Able to build/run/potentially test).
 
3. Description – A concise summary of what the commit does.

### Examples

```[10393] REMOVE: Deprecated function cleanup```
```[53094] ADD: Integrated Replit library```
```[30258] MODIFY: Updated index function to return full page data```
```[44958] WIP: Initial implementation of authentication```
```[78394] FWIP: Refactored API endpoint for efficiency```

---
