---
layout: standard
order: 1
title: Use of AI Agents
date: 2026-01-15 
id: OFQ-00020 
tags: 
  - Infrastructure
  - Digital
  - Data
---

This standard is for the design, deployment, and management of AI Agents created using Microsoft Copilot Studio (the only approved AI Agent for use at Ofqual). 
A Copilot Agent, in this context, refers to a conversational or task-oriented AI assistant that leverages natural language understanding (NLU), integrations with enterprise systems, and Power Platform components to perform actions or deliver responses within a business workflow.

The rationale is to:
- Ensure consistent quality, security, and governance
- Reduce risks related to data exposure, regulatory compliance, and misuse
- Support maintainability and reuse of agents
- Enable scalable deployment through lifecycle and performance best practices

The standard will apply to agents developed in Microsoft Copilot Studio that are:
- Deployed in internal Ofqual environments
- Used for employee support, workflow automation, or knowledge access
- Integrated with internal systems via tools such as Power Automate, Dataverse, SharePoint, or custom APIs
- Designed for medium to high-trust business scenarios, such as data analysis
---

## Requirement(s)
- [Each Use Case Must Be Assessed Before Starting Work](#Each-Use-Case-Must-Be-Assessed-Before-Starting-Work)
- [AI Agents Must Only be Used on Internal Systems](#AI-Agents-Must-Only-be-Used-on-Internal-Systems)
- [AI Agents Must Use Compliant Data Sources and Connectors](#ai-agents-must-use-compliant-data-sources-and-connectors)

### Each Use Case Must Be Assessed Before Starting Work
Each proposed production use case should be submitted to a review board for approval, prior to development commencing.

### AI Agents Must Only be Used on Internal Systems
The use of AI Agents in not permitted on public-facing systems (e.g., embedded on public websites or customer apps) and Must only be developed for internal use applications.
As such, prototypes or experimental pilots, not intended for production use, should not be implemented/hosted on a Production environment. 

### AI Agents Must Use Compliant Data Sources and Connectors
Agents cannot be setup when they rely on non-compliant data sources or unapproved connectors for their use. They Must only use complaint data sources and connectors to maintain the validity of results.

---
