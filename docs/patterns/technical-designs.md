---
layout: pattern
order: 3
title: Technical Designs
date: 2025-10-21 # this should be the date that the content was most recently amended or formally reviewed
# use `tags: []` for no tags 
# Note: tags must use sentence case capitalisation
tags:
  - Digital
  - Data
  - Infrastructure
  - QA
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related principles
      items:
        - text: We keep things neat and tidy
          href: /principles/we-keep-things-neat-and-tidy/ # Note: use an absolute link from the site home page
---

<!-- Pattern description -->

<!-- 

# Notes on line breaks

Please see https://x-govuk.github.io/govuk-eleventy-plugin/markdown/#line-breaks for notes on usage of line breaks.

# Notes on linking to headings within a page

Heading tags are automatically assigned an id, converting spaces to `kebab-case` and applying URL encoding. If you want to link to a specific heading, you can obtain the URL encoded link by running the site locally, inspecting the appropriate <h3> element in the browser's developer tools and copying the value from the 'id' attribute.
-->

Technical design work is an important aspect of the software development life cycle, and it's important to make sure that technical designs are easy to read and be understood by all technical team members. This pattern outlines methods for ensuring that team members can do this on a consistent basis

---

## Formatting

- It's generally advisable to make good use of markdown; use things like headings to delineate between different sections of the design
    - A simple way of splitting up sections of a design is to have each repository affected be its own subheading
- Bullet pointed designs can often be more accessible for people over prose
- If you need to reference code, make sure to use markdown code blocks to delineate where code lines or variable names start and stop

---

## Clarity

- Consider including diagrams alongside text, particularly for communicating challenging concepts like database designs
- Small code snippets can be useful where a developer _must_ execute something in a specific way, or where a technical concept may be difficult to explain.
    - These snippets don't have to be in actual code; you could use pseudocode to explain the concept instead
- Try to break down larger designs into smaller, bite-size chunks that are easier to digest
- It can be useful to interpret a design like cooking recipe instructions, providing imperatives on each line on what to broadly do next
- Where possible, choose to reference standards and patterns, or external documentation to provide a richer context to designs

---

## Audience

- Assume that you are _not_ the person who is going to be implementing the design
- If there are unusual edge cases or potential pitfalls, these must be highlighted, as they may not be apparent to other developers; documenting what not to do is as important as documenting what you should do
- Consider the previous experience of the current developers; if this is a brand new method of doing things, you likely need to include more detail in your design.
    - Equally, routine tasks can be less documented to save time!
- The more unusual the design to the audience, the more effort needs to be put in to communicating that design to the audience; try to keep it simple and standard instead!
- It's also helpful to predict questions that developers may have and answer these within the design itself to allay any risk-based concerns team members may have

---

## Common Considerations

- Are there any dependencies, such as other tickets being completed or other specialisms/teams needing to be involved?
- How is this work going to be tested?
- Are there any security or performance concerns that need to be addressed?
- How do we plan to deploy this work into production?
- What are the potential edge cases, pitfalls or blockers that could be found during the course of implementation?
- Why was this design selected over alternative designs?
- Is this design 'feature-complete' (does it describe achieving a full end goal) or is it a component of a wider goal?
- Are there any other risks involved with this work?