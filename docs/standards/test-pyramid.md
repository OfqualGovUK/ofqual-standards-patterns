---
layout: standard
order: 1
title: Test Pyramid
date: 2026-06-11 # this should be the date that the content was most recently amended or formally reviewed
id: OFQ-00022 # Set unique ID for standard
# use `tags: []` for no tags
# Note: tags must use sentence case capitalisation
tags:
  - QA
  - Strategy
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related Standards
      items:
        - text: Developer testing
          href: /standards/developer-testing/ # Note: use an absolute link from the site home page
        - text: 
---

<!-- Standard description -->

<!-- 

# Notes on line breaks

Please see https://x-govuk.github.io/govuk-eleventy-plugin/markdown/#line-breaks for notes on usage of line breaks.

# Notes on linking to headings within a page

Heading tags are automatically assigned an id, converting spaces to `kebab-case` and applying URL encoding. If you want to link to a specific heading, you can obtain the URL encoded link by running the site locally, inspecting the appropriate <h3> element in the browser's developer tools and copying the value from the 'id' attribute.
-->
![Test Pyramid](/assets/images/testpyramid.png)

The Software Engineering Test Pyramid is a strategic model used widely for software testing, that emphasises an optimised approach to testing across different levels. Each layer represents a different type of test, and the size of the layer indicates the recommended proportion of that test type. Use the structured approach outlined by the test pyramid as a guide for your testing. Prioritise a large volume of unit tests to validate individual components effectively. Implement a smaller set of integration tests to verify interactions between these components. Limit end-to-end (E2E) tests to critical user flows and high-risk areas, due to their complexity and maintenance costs.

While the test pyramid is a helpful guide - it should not be seen as a perfect fit in all situations. Complex systems, new development within legacy applications, rapid prototyping, off-the-shelf integrated solutions and resource limitations can all result in deviation from the standard Test Pyramid model. For complex integrations, more end-to-end tests might be needed. Short-lived applications and solutions with off-the-shelf tools may prioritise user testing over unit tests. 

Adapt the pyramid based on project needs, considering complexity, time, risk, and resources.

---

## Requirement(s)

<!-- Populate list for each requirement (there can be more than 2) -->

<!--

# Notes on anchor links

Use HTML URL encoding as in the 'Notes on links' above, to ensure that links to headers with punctuation works as expected. For example:

[Product documentation MUST include build, release and deployment processes](#product-documentation-must-include-build%2C-release-and-deployment-processes)

-->
- [You MUST take a risk based approach to testing](#you-must-take-a-risk-based-approach-to-testing)
- [You MUST implement a test early approach](#you-MUST-implement-a-test-early-approach)
- [You MUST automate where it is practical to do so](#you-MUST-automate-where-it-is-practical)
- [You MUST avoid large numbers of end-to-end tests](#you-MUST-avoid-large-numbers-of-end-to-end-tests)
- [You MUST capture metrics to provide evidence of the effeciency of your tests](#you-must-capture-metrics-to-provide-evidence-of-the-effeciency-of-your-tests)


### You MUST take a risk based approach to testing
As a tester you should understand the business and technical risks before deciding on the structure and implementation of the required testing for a development. A risk-based approach to testing ensures that time and effort are focused where failures would have the greatest impact on the business, users, and system stability. Instead of trying to test everything equally which is rarely practical, prioritise high risk areas such as critical functionality, complex integrations, and frequently changing components, to help the team uncover the most important defects earlier. This leads to better quality outcomes with fewer resources, faster release cycles and improved confidence that the most important risks have been mitigated.

To implement this standard the following risk information must be captured in User Stories to ensure that the testing is targeted correctly and that the right types and levels of testing (test pyramid coverage) are applied:
Business Risk Category - Product teams should consider whether there is a High, Medium or Low overall risk rating Tag to a User Story
Product teams should consider each of the following risk categories when assigning the risk rating:
- Compliance / Regulatory risk
What level of compliance/regulatory risk is associated with this change? 

- Customer Impact 
What level of risk to Awarding Organisations business, Ofqual business and/or customers from the general public impact is there from this development?

- Financial 
Is there any possible financial risk from this change?

- Operational 
What is the risk to the customer or Ofqual of being able to continue to operate 

- Reputational 
If this development went wrong, how visible would it be and how much would it damage user trust?

If Risk is High in any of the risk categories, then the overall risk rating tagged to the User Story is High.
If the highest Risk category rating is Medium in any category, then the overall risk rating tagged to the User Story is Medium.
If all Risk Categories are low, then the overall Risk Rating is Low.
The test process (i.e. the level and depth of the testing within the test pyramid) is then tailored according to the business risk, for this development.

Technical Risks
The Development teams should identify what the Technical risk of implementing the User Story are (during Technical Design)
Technical Risk Categories
Integration / APIs
- Are dependencies stable, versioned, and well-defined?
- What happens if an API contract changes or breaks?
- What systems/services doe this component depend on?
- How are failures handled?

Data Integrity
- How critical is the accuracy of the data being stored/transformed?
- Could data be lost, duplicated or corrupted?

Security
- What sensitive data is being handled?
- Are there vulnerabilities (authentication, authorisation, input validation)?
- What would be the impact of a breach?
- Are security controls (encryption, access control) sufficient/in place? 

Availability / Reliability
- Is there resilience (failover, redundancy)?
- How quickly can the system/component recover (from a failure)?

Are there other technical risk categories specific to this code area/user story?
For example:
- Are there Infrastructure or Deployment risks introduced?
- Are there system performance risks by this change? 

The test process should focus on mitigating through testing where there are the highest technical risks for any given development change.

<!-- Requirement description text -->
### You MUST implement a test early approach
Unit tests are low level tests that verify the smallest testable parts of an application (units or components) in isolation. These are the base of the pyramid where it is widest. See the developer testing related standard (link above in Related Standards). A strong base of early testing is essential for a robust, maintainable codebase. This form of testing should be prioritised by developers.


### You MUST automate where it is practical
Quality Assurance engineers should always look for opportunities to "shift left" testing and prioritise test automation as early as possible in the development lifecycle, to facilitate finding bugs early.
<!-- Requirement description text -->

### You MUST avoid large numbers of end-to-end tests
The top of the pyramid is the smallest, representing the End to End (E2E) tests. These tests validate the entire application flow, simlulating real-world user scenarios and verifying all components work together. E2E tests are the most complex and by nature are the most fragile. They are also the most time-consuming to write, execute and maintain. Automation should be strategic, for only critical user work flows and high risk areas, while limiting the scope to as small a number as possible, to reduce complexity and maintenance costs.
<!-- Requirement description text -->

### You MUST capture metrics to provide evidence of the effeciency of your tests
Capturing metrics is crucial for evaluating effectiveness of your tests. These metrics should be available for unit/component level tests, the middle integration layers and the E2E tests.

This is not an exhaustive list, but as a minimum across the pyramid you should capture and store for automated test runs:

- test execution time
- test results
- automation coverage
- percentage of unreliable/flakey/work in progress tests

<!-- Requirement description text -->




---
