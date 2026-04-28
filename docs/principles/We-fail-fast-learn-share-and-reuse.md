---
layout: principle
order: 4
title: 04.	We fail fast, learn, share and reuse
date: 2025-06-18
tags:
- Ways of working
related:
  sections:
    - title: Related links
      items:
---
We work in an environment where agility and continuous improvement are crucial for success. Adopting a proactive approach to innovation and problem-solving with an emphasis on rapid experimentation, learning from both successes and failures enables that overall success. Disseminating knowledge during this process helps to accelerate progress and where possible not spending time re-inventing something already in place maintains the pace of a small team.  

---

## Rationale

Deploying little and often reduces lead time from change request to release, for both new features and bug fixes. This enables users to see changes faster and provide feedback. It also reduces risk, enables teams to iterate and react faster, while maintaining product quality.

The cost of fixing potential issues is also smaller due to the fact that the little and often approach allows us to quickly adapt and release or rollback to a stable state. The smaller the change being pushed out the smaller the chance of merge conflicts.

Smaller, incremental deployments build confidence for stakeholders, creating less pressure around a release. Larger, infrequent releases that fail cause additional delays in new features and bug fixes, impacting the project team and users alike.

---

## Applications and Implications

- Build or leverage reusable components and patterns where appropriate
- Good quality tests which validate a release before it gets to production reinforce the confidence so that we can deploy often. Adding automated test coverage for example can greatly improve a team's likelihood of achieving this principle.
- CI/CD pipelines that are quick and efficient, automating repetitive tasks so that we can deploy little and often
- We must be aware of how frequent releases affect users, and consider whether it is applicable in each use case. For example, where a breaking change is introduced, or an in-progress operation would be affected
- Feature flags can be used to allow deployments to occur without releasing new functionality to all users at once.

---
