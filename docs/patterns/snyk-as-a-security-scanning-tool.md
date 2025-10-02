---
layout: pattern
order: 1
title: Snyk as a Security Scanning Tool
date: 2025-07-23 # this should be the date that the content was most recently amended or formally reviewed
# use `tags: []` for no tags 
# Note: tags must use sentence case capitalisation
tags:
  - Security
  - Digital
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related Standards
      items:
        - text: Security In First Party Software
          href: /standards/security-in-first-party-software/ # Note: use an absolute link from the site home page
---

<!-- Pattern description -->

<!-- 

# Notes on line breaks

Please see https://x-govuk.github.io/govuk-eleventy-plugin/markdown/#line-breaks for notes on usage of line breaks.

# Notes on linking to headings within a page

Heading tags are automatically assigned an id, converting spaces to `kebab-case` and applying URL encoding. If you want to link to a specific heading, you can obtain the URL encoded link by running the site locally, inspecting the appropriate <h3> element in the browser's developer tools and copying the value from the 'id' attribute.
-->

---

## Introduction

-	Snyk is a tool that is used as an all-encompassing software package used to identify vulnerabilities in first party software
-	It also helps non-technical people get an understanding of security issues across an entire enterprise estate of developed software

## Processes

### Development

#### Snyk Extensions

-	Snyk provides extensions for developers to scan their code before committing
-	It is expected that developers have these extensions installed for the IDEs they use, and that they actively use the extension on a regular basis
-	The focus of using these extensions should be for First Party Code, but can also be used to help identify issues with Third Party Dependencies early on in development

#### Snyk Scan and Pipelines

-	A Snyk Scan should be added to pipelines for the purpose of monitoring security
-	It is recommended that the scanner is “gated” to block builds when new issues are identified
    -	The conditions for this block, if beyond that of the standard, should be determined by the Security Team
Auditing
-	Snyk provides a way of prioritizing issues through a proprietary scoring system called “Snyk Score”
-	This generally indicates how severe an issue is on a practical level, as well as how fixable the issue is. The higher the score, the more severe and potentially fixable the problem is
-	This can be used to help with triaging issues and assisting the Product Team in prioritizing what security problems should be fixed first

#### Training

-	Developers should regularly use the Snyk Learn platform to understand how to resolve issues, particularly when issues are raised by Snyk
-	Developers should also review the following Snyk University modules as part of their learning and development:
    -	Security for Developers
    -	OWASP Top 10
    -	OWASP Top 10 risks for open-source software
    -	OWASP API Security Top 10

---
