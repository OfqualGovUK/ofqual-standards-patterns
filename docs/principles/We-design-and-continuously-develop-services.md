---
layout: principle
order: 5
title: 5.	We design and continuously develop services that are durable and resilient
date: 2025-06-18
tags:
  - Ways of working
related:
  sections:
    - title: Related links
      items:
        - text: GOV.UK Service Standard - Iterate and improve frequently
          href: https://www.gov.uk/service-manual/service-standard/point-8-iterate-and-improve-frequently
---

Cresting great services isn't just about the initial delivery - it's about continuously maintaining and evolving them. Regularly update codebases, dependencies, pipelines, infrastructure, and processes to ensure they remain secure, performant, and aligned with current standards. Avoid allowing systems to stagnate by scheduling maintenance and improvements as a regular part of the delivery lifecycle.

---

## Rationale

Outdated systems are harder to support and integrate with modern components, leading to increased technical debt over time. Regular updates are essential to reduce exposure to known vulnerabilities, enhancing the security of the system. Keeping tools and libraries up to date also sustains efficiency by leveraging improved performance and new features. Neglecting regular maintenance often results in costly big bang upgrades, making continuous updates a more cost-effective approach.

---

## Applications and Implications

- Schedule time dedicated to updating dependencies, refactoring code, and maintaining pipelines. This proactive approach ensures that systems remain current and reduces the risk of accumulating technical debt
- Continuously observe and assess updates in the technology ecosystem, such as new library versions or framework releases. Staying informed enables timely adoption of improvements and ensures compatibility with external systems
- Automatically detect outdated dependencies and facilitate testing processes. Automation streamlines maintenance tasks, minimises human error, and accelerates the integration of necessary updates
- Incorporate planned and measurable maintenance activities into team roadmaps. By formally recognising maintenance as a critical component of the development lifecycle, teams can allocate resources effectively and maintain system integrity over time
