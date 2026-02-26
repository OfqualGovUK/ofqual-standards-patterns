---
layout: standard
order: 1
title: defining-a-process-in-ofqual
date: 2026-02-26 # date the content was most recently amended or formally reviewed
id: OFQ-00018 # Set unique ID for standard
# use `tags: []` for no tags
# Note: tags must use sentence case capitalisation
tags:
  - Process
  - Governance
  - UCD
  - Service
related: # remove this section if you do not need related links on your page
sections:
    - title: Related Principles
      items:
        - text: We design and continuously develop services that are durable and resilient
          href: https://digital-framework.ofqual.gov.uk/principles/We-design-and-continuously-develop-services/ # Note: use an absolute link from the site home page
---

<!-- Standard description -->

This standard defines what we mean by a “process” in the business context and sets clear expectations for how processes must be described so they can be governed, measured and improved consistently across the organisation. It applies to all processes. 

It establishes a shared definition, sets proportionate documentation expectations based on criticality, clarifies minimum information to record, and aligns measurement and governance with service ownership. It also explains how teams evidence compliance and manage change control, and signals forthcoming decisions on modelling notation and worked examples.

<!-- 

# Notes on line breaks

Please see https://x-govuk.github.io/govuk-eleventy-plugin/markdown/#line-breaks for notes on usage of line breaks.

# Notes on linking to headings within a page

Heading tags are automatically assigned an id, converting spaces to `kebab-case` and applying URL encoding. If you want to link to a specific heading, you can obtain the URL encoded link by running the site locally, inspecting the appropriate <h3> element in the browser's developer tools and copying the value from the 'id' attribute.
-->

---

## Requirement(s)

<!-- Populate list for each requirement -->

- [Define what a process is](#define-what-a-process-is)
- [Apply this standard to all processes](#apply-this-standard-to-all-processes)
- [Use BPMN 2.0 for process mapping](#use-bpmn-20-for-process-mapping)
- [Provide required artefacts based on criticality](#provide-required-artefacts-based-on-criticality)
- [Provide minimum information for each process](#provide-minimum-information-for-each-process)
- [Set measurement and governance expectations](#set-measurement-and-governance-expectations)
- [Evidence compliance and manage change control](#evidence-compliance-and-manage-change-control)


### Define what a process is

**Context**  
A shared definition removes ambiguity and ensures that all documented processes can be validated, governed and improved in a consistent way. Clarity about what is and is not a process enables better prioritisation, ownership and control across products and services.

**Requirement**  
A process is a set of interrelated, defined, repetitive and measurable activities that add value by transforming inputs into outputs to create value and support the business strategy.

**Supporting information**  
- *Interrelated* means activities have logical dependencies and handoffs.  
- *Defined* means steps, roles, rules and controls are explicitly documented and repeatable.  
- *Repetitive* means the process occurs whenever its trigger condition is met, rather than being a one‑off project task.  
- *Measurable* means performance can be assessed, for example timeliness, quality, cost or compliance.  
- *Transforming inputs into outputs* means identifiable artefacts, data or states change from a start condition to an end condition.  
- *Supporting the business strategy* means the process contributes to agreed outcomes or strategic objectives.

### Apply this standard to all processes

**Context**  
Consistency across the organisation depends on universal application. Exceptions make process management harder to govern and audit.

**Requirement**  
This standard applies to all processes across the organisation.

**Supporting information**  
If a process is retired or merged, record its final state and disposition so that the process inventory remains accurate.

### Use BPMN 2.0 for process mapping

**Context**  
A common modelling approach improves comprehension and reuse. The organisation has standardised on BPMN 2.0

**Requirement**  
BPMN 2.0 should be used for all process maps and models. Where an alternative view is produced for a specific audience, a BPMN 2.0 source model must be maintained as the canonical version.

**Supporting information**  
[BPMN 2.0 specification 
](https://www.omg.org/spec/BPMN)


### Provide required artefacts based on criticality

**Context**  
Not all processes require the same depth of documentation. Process mapping is good practice, but documentation must be proportionate to the criticality of the service the process supports.

**Requirement**  
A process map is good practice for all processes. A process map is essential for all mission‑critical and business‑critical processes that support mission‑critical or business‑critical services.

**Supporting information**  
- *Mission‑critical* and *business‑critical* should align to the organisation’s service criticality classification.  
- For lower‑criticality processes, retain at least the minimum information set defined in this standard.  
- Where a map is essential, store it in the approved repository and link it from the process record.

### Provide minimum information for each process

**Context**  
A baseline set of information enables governance, traceability and improvement, even when a full map is not required.

**Requirement**  
All in‑scope processes must include, at a minimum: triggers, end states, roles, controls, exceptions, service level agreements, version and owners.

**Supporting information**  
- Roles should identify accountable and responsible parties for each activity.  
- Controls may include preventive, detective and corrective controls.  
- Exceptions should describe non‑standard paths and how they are handled.  
- Version and owners should include change history and effective dates.

### Set measurement and governance expectations

**Context**  
Measurement should be meaningful and manageable. KPIs are managed at the service level rather than mandated at the process level.

**Requirement**  
There are no mandated process‑level KPIs. Each service owner defines the review cadence for the processes that support their service.

**Supporting information**  
- Where teams choose to set process measures, align them to service outcomes.  
- Service owners should ensure that process reviews occur at the cadence they define and are recorded.

### Evidence compliance and manage change control

**Context**  
Compliance must be demonstrable through normal artefacts. Change control should fit existing service governance rather than duplicating it.

**Requirement**  
Teams evidence compliance with this standard through the artefacts they maintain. The change control process for updating process definitions is defined at the service‑owner level.

**Supporting information**  
Evidence may include the process record, the process map where required, change history and links to controls or service documentation.

