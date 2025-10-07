---
layout: standard
order: 4
title: Developer Testing
date: 2025-10-07 # this should be the date that the content was most recently amended or formally reviewed
id: OFQ-00008 # Set unique ID for standard
# use `tags: []` for no tags
# Note: tags must use sentence case capitalisation
tags:
  - Digital

related: # remove this section if you do not need related links on your page
  sections:
    - title: Related Principles
      items:
        - text: We use the right tools and have the right rules
          href: /principles/we-use-the-right-tools-and-have-the-right-rules/ # Note: use an absolute link from the site home page
        - text: We needs-driven and design and deliver proportionate evidence-based solutions
          href: /principles/We-are-needs-driven/ # Note: use an absolute link from the site home page
        - text: Security is everyone's responsibility
          href: /principles/security-is-everyones-responsibility/
    - title: Related Patterns
      items:
        - text: Snyk as a Security Scanning Tool
          href: /patterns/we-use-the-right-tools-and-have-the-right-rules/ # Note: use an absolute link from the site home page


---

<!-- Standard description -->

<!-- 

# Notes on line breaks

Please see https://x-govuk.github.io/govuk-eleventy-plugin/markdown/#line-breaks for notes on usage of line breaks.

# Notes on linking to headings within a page

Heading tags are automatically assigned an id, converting spaces to `kebab-case` and applying URL encoding. If you want to link to a specific heading, you can obtain the URL encoded link by running the site locally, inspecting the appropriate <h3> element in the browser's developer tools and copying the value from the 'id' attribute.
-->

The Role of Testing in Development

Testing is a fundamental aspect of software development, integral to ensuring code reliability and stability.
Validating changes through tests is essential to confirm that deployments won’t compromise production environments or disrupt service functionality.
Robust testing practices help safeguard against regressions and unexpected behavior.



Tests as Documentation

Every test should clearly convey its purpose, serving as a living form of documentation that complements the broader solution.
Well-named and purposeful tests make clear the intent behind the code.


Qualities of Effective Tests

Tests should be straightforward, readable, and focused—ideally covering a single scenario or behaviour.
A reliable test passes consistently without requiring changes to the underlying implementation.
Test clarity and simplicity are key to maintainability and team understanding.


Measuring Test Effectiveness

Effectiveness should be gauged through metrics like code coverage, although coverage alone doesn’t equate to code quality.
Comprehensive test coverage contributes to overall application robustness, but should be balanced with context-specific quality indicators.


Types of Testing

Testing can take many forms—unit, integration, API layer, property-based—but all should meet this core quality standard.
Regardless of type, tests should be purposeful, maintainable, and aligned with the team’s development practices.


Benefits of Strong Developer Testing Practices

Facilitates quick identification and resolution of bugs before further Quality Assurance activities.
Enhances security and confidence in continuous integration.
Improves code comprehension by making functionality and intent more transparent.
Encourages shared ownership, with tests maintained by the same team responsible for the codebase.

---
## Requirement(s)

<!-- Populate list for each requirement (there can be more than 2) -->

<!--

# Notes on anchor links

Use HTML URL encoding as in the 'Notes on links' above, to ensure that links to headers with punctuation works as expected. For example:

[Product documentation MUST include build, release and deployment processes](#product-documentation-must-include-build%2C-release-and-deployment-processes)

-->
- [Developer tests MUST be clear, purposeful, and maintainable](#developer-tests-must-be-clear-purposeful-and-maintainable)
- [Developer tests MUST be run automatically as part of the CI/CD pipeline](#developer-tests-must-be-run-automatically-as-part-of-the-cicd-pipeline)
- [Developer tests MUST be written to cover new features and bug fixes](#developer-tests-must-be-written-to-cover-new-features-and-bug-fixes)
- [Developer tests MUST be documented and communicated effectively](#developer-tests-must-be-documented-and-communicated-effectively)
- [Developer tests MUST be designed to minimize maintenance overhead](#developer-tests-must-be-designed-to-minimize-maintenance-overhead)
- [Developer tests MUST have a way of measuring their effectiveness](#developer-tests-must-have-a-way-of-measuring-their-effectiveness)
- [Developers MUST think about the edge cases when writing tests](#developers-must-think-about-the-edge-cases-when-writing-tests)


### Developer tests MUST be clear, purposeful, and maintainable
Tests should be easy to read and understand, with clear names that describe their purpose.
They should focus on a single scenario or behavior, avoiding unnecessary complexity.
Tests should be written in a way that makes them easy to maintain, with minimal duplication and clear organization.
Tests should be reviewed regularly to ensure they remain relevant and effective.

### Developer tests MUST be run automatically as part of the CI/CD pipeline
Tests should be integrated into the continuous integration and continuous deployment (CI/CD) pipeline.
This ensures that tests are run consistently and reliably, and that any issues are identified early in the development process.
Tests should be run on every commit or pull request, and results should be reported back to the development team.

### Developer tests MUST be written to cover new features and bug fixes
Tests should be written to cover new features and bug fixes, ensuring that they are thoroughly tested before being deployed to production.
This helps to prevent regressions and ensures that new functionality works as intended.
Tests should be written in a way that makes them easy to update as new features are added or bugs are fixed.

### Developer tests MUST be documented and communicated effectively
Tests should be documented in a way that makes them easy to understand and use.
This includes clear naming conventions, comments, and documentation that explains the purpose and behavior of each test.
Test results should be communicated effectively to the development team, with clear reporting and feedback mechanisms.

### Developer tests MUST be designed to minimize maintenance overhead
Tests should be designed to minimize maintenance overhead, with a focus on simplicity and clarity.
This includes avoiding unnecessary complexity, minimizing duplication, and using clear organization and naming conventions.
Tests should be reviewed regularly to ensure they remain relevant and effective, and any unnecessary tests should be removed.

### Developer tests MUST have a way of measuring their effectiveness
Developer tests should have a way of measuring their effectiveness, such as code coverage or other metrics.
This helps to ensure that tests are comprehensive and effective, and that any issues are identified early in the development process.
Metrics should be reviewed regularly to ensure that tests remain relevant and effective, and any necessary changes should be made.

### Developers MUST think about the edge cases when writing tests
When writing tests, developers should consider edge cases and potential failure scenarios.
This helps to ensure that tests are comprehensive and effective, and that any issues are identified early in the development process.

---
