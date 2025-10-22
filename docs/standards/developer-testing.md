---
layout: standard
order: 4
title: Developer Testing
date: 2025-10-10
id: OFQ-00009
tags:
- Digital
- Quality Assurance
related:
  sections:
    - title: Related Principles
      items:
        - text: We use the right tools and have the right rules
          href: /principles/we-use-the-right-tools-and-have-the-right-rules/
        - text: We are needs-driven and design and deliver proportionate evidence-based solutions
          href: /principles/We-are-needs-driven/
        - text: Security is everyone's responsibility
          href: /principles/security-is-everyones-responsibility/
    - title: Related Patterns
      items:
        - text: Snyk as a Security Scanning Tool
          href: /patterns/we-use-the-right-tools-and-have-the-right-rules/
---

## Overview

Testing is a core part of writing and maintaining code. 
It provides confidence that changes can be safely deployed to production and that the service will continue to work as expected.

Tests must clearly show their purpose and act as documentation for the solution. 
They must be easy to read and include a way to measure how effective they are (for example, using coverage tools).

Good tests are clear in their intent, focus on one case, are readable, and pass consistently without needing changes to the code.

Developer testing can take different forms—such as unit, integration —but all must meet the requirements below to achieve the following benefits:

- Help fix broken code quickly
- Improve security and confidence when integrating code
- Make code easier to understand
- The team that builds the code is responsible for the tests


## Requirement(s)

- [Tests must be clear, purposeful, and maintainable](#tests-must-be-clear-purposeful-and-maintainable)
- [Tests must be run automatically in the CI/CD pipeline](#tests-must-be-run-automatically-in-the-cicd-pipeline)
- [Tests must cover new features and bug fixes](#tests-must-cover-new-features-and-bug-fixes)
- [Tests must be documented and reviewed in the PR](#tests-must-be-documented-and-reviewed-in-the-PR)
- [Tests must be designed to reduce maintenance effort](#tests-must-be-designed-to-reduce-maintenance-effort)
- [Tests must include effectiveness metrics](#tests-must-include-effectiveness-metrics)
- [Tests must consider edge cases](#tests-must-consider-edge-cases)

### Tests must be clear, purposeful, and maintainable

Tests must be easy to read and understand, with names that describe their purpose. 
Each new test must focus on a single scenario or behaviour. 
Each test must have a clear purpose and expected outcome.
Avoid unnecessary complexity and duplication. 
Organise tests clearly and review them each time that you are working in a code repository, to ensure the ongoing relevance of the tests.

### Tests must be run automatically in the CI/CD pipeline

All tests must be integrated into the CI/CD pipeline. 
They must run on every commit and pull request. 

### Tests must cover new features and bug fixes

Every new feature and bug fix must include corresponding tests. 
These tests must validate the intended behaviour and prevent regressions. 
Update tests as features evolve.

### Tests must be documented and reviewed in the PR

Tests must include documentation that explains their purpose and expected behaviour. 
Use clear naming conventions and comments where necessary. 

### Tests must be designed to reduce maintenance effort

Design tests to be simple and easy to maintain. 
Avoid duplication and complex dependencies. 
Remove outdated or redundant tests during regular reviews.

### Tests must include effectiveness metrics

Use metrics such as code and branch coverage to assess test effectiveness. 
Review these metrics when working in a repository and adjust tests to maintain relevance and coverage quality.
Setting a minimum threshold (such as 80%) can ensure that any new code is tested.

### Tests must consider edge cases

Developers must consider whether for a specific feature or bug fix, whether to include edge cases in your tests. 
This helps identify unexpected behaviour early in the development process.
