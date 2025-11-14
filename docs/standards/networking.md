---
layout: standard
order: 11
title: Networking
date: 2025-11-12
id: OFQ-00011
tags:
  - Digital
  - Infrastructure
related:
  sections:
    - title: Related links
      items:
        - text: Writing a standard
          href: /standards/writing-a-standard/

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

Networking is a principle component of digitally developed service, and paramount to the security and practices of development environments.

Good networking setups must ensure that services not fit for public consumption are contained separately to a production environment, and access to which is only granted through controlled means. This is important in ensuring that untested features or prototypes are not publicly available until it has been established that they are fit for purpose.  

## Requirement(s)

- [Access to all environments must be restricted](#access-to-all-environments-must-be-restricted)
- [Preprod must aim to mirror production](#preprod-must-aim-to-mirror-production)
- [Cloud First](#cloud-first)

### Access to all environments must be restricted

To protect the integrity and security of our environments, access to directly interface with all areas must be restricted using technical controls.

Acceptable technical controls include, but are not limited to, utilisation of Priviledged Identity Management (PIM) and principle of least priviledge, to ensure that only legitimate user accounts can access sensitive environments.

Access to production environments specifically must be more restrictive than other environments to protect our public facing services. Access to production must be justified and audited to prevent.

### Preprod must aim to mirror production

The use of a preprod environment is to replicate a production environment as closely as possible, and every effort must be undertaken to ensure these two environments match as closely as possible. 

It is possible for testing to be conducted in both development and preprod environments. However, the core difference is that development environment are expected to be less indicative of our current production environment, whilst preprod must aim to mirror production within reason. Some differences between preprod and production are acceptable, such as preperation for new deployments.

### Cloud First

Ofqual is a cloud-first organisation, and any new networking solution must be investigated with this in mind. Cloud-based networking options are essential to our resiliance and recovery, and as such it is imperitive that solutions or improvements to our networking are investigated utilising cloud-based options.

---
