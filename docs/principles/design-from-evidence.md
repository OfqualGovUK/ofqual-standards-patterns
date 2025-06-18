---
layout: principle
order: 2
title: 2.	We are needs-driven and design and deliver proportionate evidence-based solutions
date: 2025-06-18
tags:
- Ways of working
---

Evidence-based decisions improve our ability to meet user needs. Without evidence of why we do things and their impact, it is hard to know what problems there are, what features should be implemented and how best to maintain our services. Proactive and effective monitoring provides observable systems, using metrics and monitoring and acting on those insights to instigate improvements.

---

## Rationale

Successfully meeting user needs requires a proven understanding of user experience.  We must ensure that the evidence we base our decisions on is up to date, valid and transparent.  This allows us to iterate with short feedback loops and provide value back to our users more quickly.   This applies across the whole lifecycle of a product. Evidence can be drawn from user research and other non-functional elements, for example legal, security, performance and other compliance requirements.

Designing from evidence, and documenting that effectively, allows people to understand the intent behind design choices. This can help to reduce cost by only meeting valid requirements. This also aids in the future maintainability of products because it is clearer why things were done, and the potential for regression of functionality is reduced. Designing test approaches based on good evidence of the correct requirements gives assurance and greater confidence in the product.

Following the [GDS Service Manual guidance on how to measure and monitor](https://www.gov.uk/service-manual/technology/monitoring-the-status-of-your-service) and using telemetry to provide deep visibility into systems enables our teams to cut through complexity to identify and resolve issues, and improve performance. High observability has other benefits:

- More insightful incident reviews
- Faster problem solving and shorter Mean Time to Recovery (MTTR)
- Improves reliability by enabling [SRE approaches based on pillars of service-level objectives, service level indicators and error budgets](https://sre.google/sre-book/introduction/)
- Monitoring and alerting aligned with [FinOps practices](https://www.finops.org/introduction/what-is-finops/) helps to drive down infrastructure costs
---

## Applications and Implications

- Be product centric. Understand user needs and provide evidence for the successful delivery of functionality. User research is a great way to do this, especially as part of short, continuous, agile feedback loops
- All needs and requirements - whether functional or non-functional - should be documented, pointing back to the evidence base and rationale for the requirement
- Tests should be used to provide evidence that requirements have been met. This should be understandable to stakeholders so that they have confidence in the software
- Implement infrastructure monitoring to determine the health and performance of the containers, environments and managed services your applications run on
- Investigate the behaviour of your application at the service level with Application Performance Monitoring (APM)
- When you can, use Real User Monitoring (RUM) to understand the real experience of users by collecting data from browsers about how your site performs and looks. This helps to isolate issues between the frontend or backend
- Synthetic monitoring allows you to test and measure the experience of your web application by simulating traffic with set test variables
- Log capture, aggregation and viewer tools help you to monitor and, importantly, analyse the logs generated from your applications and infrastructure. This helps troubleshooting and remediation
- Use [DORA metrics](https://cloud.google.com/blog/products/devops-sre/announcing-dora-2021-accelerate-state-of-devops-report) to understand software delivery performance

---
