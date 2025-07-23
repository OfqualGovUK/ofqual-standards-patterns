---
layout: standard
order: 3
title: Security In First Party Software
date: 2025-07-14 # this should be the date that the content was most recently amended or formally reviewed
id: OFQ-00003 # Set unique ID for standard
# use `tags: []` for no tags
# Note: tags must use sentence case capitalisation
tags:
  - Security
  - Digital
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related Principles
      items:
        - text: Security Is Everyone's Responsibility
          href: /principles/security-is-everyones-responsibility/ # Note: use an absolute link from the site home page
    - title: Related Patterns
      items:
        - text: Snyk as a Security Scanning Tool
          href: /patterns/snyk-as-a-security-scanning-tool/ # Note: use an absolute link from the site home page
---

<!-- Standard description -->

<!-- 

# Notes on line breaks

Please see https://x-govuk.github.io/govuk-eleventy-plugin/markdown/#line-breaks for notes on usage of line breaks.

# Notes on linking to headings within a page

Heading tags are automatically assigned an id, converting spaces to `kebab-case` and applying URL encoding. If you want to link to a specific heading, you can obtain the URL encoded link by running the site locally, inspecting the appropriate <h3> element in the browser's developer tools and copying the value from the 'id' attribute.
-->

This standard defines how developers must ensure that code they produce is secure and suitable for use on our technology estate.

This standard specifically covers "First-Party" development, where internal or contract developers create bespoke software for use in Ofqual, rather than "Third-Party" solutions that are bought off-the-shelf

---

## Requirement(s)

<!-- Populate list for each requirement (there can be more than 2) -->

<!--

# Notes on anchor links

Use HTML URL encoding as in the 'Notes on links' above, to ensure that links to headers with punctuation works as expected. For example:

[Product documentation MUST include build, release and deployment processes](#product-documentation-must-include-build%2C-release-and-deployment-processes)

-->

- [Developers MUST scan their code using security scanning tools before merging code](#developers-must-scan-their-code-using-security-scanning-tools-before-merging-code)
- [Developers MUST attempt to fix security issues at first sight](#developers-must-attempt-to-fix-security-issues-at-first-sight)
- [Vulnerabilities MUST be reviewed on a monthly basis by the Security Team](#vulnerabilities-must-be-reviewed-on-a-monthly-basis-by-the-security-team)
- [Developers MUST undertake security training on a regular basis](#developers-must-undertake-security-training-on-a-regular-basis)


### Developers MUST scan their code using security scanning tools before merging code

Developers must use an approved security tool to check for vulnerabilities before merge.

All build pipelines MUST have at least one Security Scanning Tool in place to satisfy this standard; spot checks should be taken by the Lead Developer to ensure that actively developed projects have this in place. Where possible, builds should block whenever a Critical vulnerability is identified

Developers may run code scans before commit using an approved extension, such as Snyk Code, where available.

### Developers MUST attempt to fix security issues at first sight

In the event of a first party issue, then this MUST be resolved immediately regardless of the time required to do so. Code reviews MUST NOT be passed when such an issue is identified. Exceptions to this can only be approved by a Lead Developer or above, and the Security Team

Issues related to Third Party Dependencies MUST be reported to a Lead Developer or above, and Security Team when they are of a Critical rating. Developers should attempt to resolve issues that have a fix available regardless of severity as indicated by Security Scanning Tools, but should timebox such fixes and testing to 1 day’s development time and should only do so if the fix does not result in breaking changes (previous functionality MUST be maintained)

Developers may only mark issue as ignorable in Security Scanning Tools if given permission by the Lead Developer or a Security Team member to do so Training

### Vulnerabilities MUST be reviewed on a monthly basis by the Security Team

An estate-wide report of current vulnerabilities MUST be reviewed on a monthly basis by the Security Team

Issues raised by Developers and/or Security Scanning Tools with a severity of Critical should be triaged and prioritized. If a fix is likely available, such issues must be passed on to the Product Team and brought in to the next available sprint regardless of other priorities

Non-critical issues should also be triaged where possible and passed on to the Product Team, which should then be fitted around current work and resourcing Enforcement

### Developers MUST undertake security training on a regular basis

Training should cover core aspects of development security, such as the OWASP Top 10.

Developers may achieve this requirement either through resources made available specifically to us, or through other alternate means such as research on the wider internet

---
