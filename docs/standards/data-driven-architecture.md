---
layout: standard
order: 1
title: Data Driven Architecture
date: 2025-10-07 # this should be the date that the content was most recently amended or formally reviewed
id: OFQ-00008 # Set unique ID for standard
# use `tags: []` for no tags
# Note: tags must use sentence case capitalisation
tags:
  - Digital
  - Data
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related principles
      items:
        - text: We design and continuously develop services
          href: /standards/we-design-and-continuously-develop-services/ # Note: use an absolute link from the site home page
---

<!-- Standard description -->

<!-- 

# Notes on line breaks

Please see https://x-govuk.github.io/govuk-eleventy-plugin/markdown/#line-breaks for notes on usage of line breaks.

# Notes on linking to headings within a page

Heading tags are automatically assigned an id, converting spaces to `kebab-case` and applying URL encoding. If you want to link to a specific heading, you can obtain the URL encoded link by running the site locally, inspecting the appropriate <h3> element in the browser's developer tools and copying the value from the 'id' attribute.
-->

This standard outlines our main approach to how we create first party software within Ofqual using data driven principles, instead of through hard-coding of values and pages

---

## Requirement(s)

<!-- Populate list for each requirement (there can be more than 2) -->

<!--

# Notes on anchor links

Use HTML URL encoding as in the 'Notes on links' above, to ensure that links to headers with punctuation works as expected. For example:

[Product documentation MUST include build, release and deployment processes](#product-documentation-must-include-build%2C-release-and-deployment-processes)

-->

- [Developers MUST start design with data modelling where appropriate and involve data engineers](#developers-must-start-design-with-data-modelling-where-appropriate-and-involve-data-engineers)
- [Developers MUST prioritise creating systems that leverage databases](#developers-must-prioritise-creating-systems-that-leverage-databases)
- [Developers MUST leverage alternate data-driven solutions where databases are not suitable](#developers-must-leverage-alternate-data-driven-solutions-where-databases-are-not-suitable)

### Developers MUST start design with data modelling where appropriate and involve data engineers

<!-- Requirement description text -->

The fundamental building blocks of all systems come from the data, and if the data being sent or received is not appropriate or handled in an appropriate way, then this can cause issues later down the line architecturally. For example:

- Data could be handled in an inefficient way, making it harder for data engineers to interpret or report on
- Security problems could occur if data design results in unintended access to systems
- It could be hard to make changes to how the system functions because of a lack of prior thought to future considerations
- It may mean some changes require significant code adjustments instead of simpler data updates

As a result, we require all engineers to start their designs with data management as a first consideration. This includes:

- Proposals for how database tables could be configured
- Proposals for what models and enums are required and their data types

A data engineer must always be consulted for database changes; database tickets must be handled as separate tickets that a data enginner owns

### Developers MUST prioritise creating systems that leverage databases

Database changes are significantly easier to implement, particularly with the amount of data engineering resource we have. It is much more cost effective to make a change to a database than it is to rewrite code, so efforts should be taken to shift design to be more database-centric

Examples of how this can be handled include:

- Creating templates in front-end web pages instead of specific web pages, and deriving how to set up those pages from a database and API
- Making use of reference data tables for commonly held values (such as countries or qualification types) instead of purely relying on enumeration
- The storage of validation rules at the database layer

### Developers MUST leverage alternate data-driven solutions where databases are not suitable

Whilst database-usage should be the first port of call for most designs, there are exceptions where a database may not be suitable. For example:

- Some systems may need to avoid dependencies; for instance, a shutter page needs to be able to operate on its own without any dependencies for total reliability
- Some systems may need values before they can make a connection to a database, such as at build time or on initial load, such as with some feature flags
- Some values are not suitable for storage in databases, such as secret information

In these situations, there are alternative ways to drive systems through data that can be leveraged, such as:

- Existing APIs; this is particularly the case with reference data
- Environment variables
- JSON/CSV files that are then loaded into the system

Secret infomation should **never** be stored in a database; developers should follow the [Security In First Party Software](/standards/security-in-first-party-software)

---