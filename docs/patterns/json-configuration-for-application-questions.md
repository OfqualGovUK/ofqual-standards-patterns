---
layout: pattern
order: 3
title: JSON Configuration for Application Questions
date: 2025-10-10 # this should be the date that the content was most recently amended or formally reviewed
# use `tags: []` for no tags 
# Note: tags must use sentence case capitalisation
tags:
  - Data
  - Digital
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related standards
      items:
        - text: Data-Driven Architecture
          href: /standards/data-driven-architecture/ # Note: use an absolute link from the site home page
---

## Introduction

The recognition citizen-facing web page prompts users to complete a series of questions to submit an application for recognition by Ofqual. These questions are configured via a JSON record stored in a database table. This document outlines the required JSON structure to surface a question.

This pattern is likely suitable for use in task-list type scenarios, where users are asked to complete a series of tasks containing sets of questions.

---

## Structure Overview
The JSON consists of three primary objects:

- `body` [array] – Configures question text and description.
- `sidebar` [object] – Adds contextual sidebar content.
- `formGroup` [object] – Controls answer input type and validation.

---

## Body
The `body` array defines the main layout and text for each question. It can contain multiple objects with the following structure:

### Common Field
- `type` [string] – Type of content. Valid values:
  - `Button` – Clickable button with action
  - `heading` – Section heading
  - `list` – Bullet point list
  - `paragraph` – Paragraph text (each in its own object)

### Type-Specific Fields

#### `type: Button`
- `buttonContent` [object]
  - `formAction` [string] – Action to perform on click
  - `name` [string] – Button name
  - `text` [string] – Button display text

#### `type: heading`
- `headingContent` [object]
  - `text` [string] – Heading text
  - `size` [string] – Text size

#### `type: list`
- `listContent` [object]
  - `items` [array]
  - `size` [string] – Text size
  - `style` [string] – Only `"bulleted"` is accepted

#### `type: paragraph`
- `paragraphContent` [object]
  - `text` [string] – Paragraph text
  - `size` [string] – Text size

---

## Sidebar
The `sidebar` object provides additional context such as definitions or links.

### Structure
- `help` [object]
  - `links` [array]
    - `text` [string] – Link text
    - `url` [string] – Link URL
  - `content` [array]
    - `type` [string] – Valid values: `heading`, `paragraph`
    - `headingContent` [object] (if `type: heading`)
      - `text` [string]
      - `size` [string]
    - `paragraphContent` [object] (if `type: paragraph`)
      - `text` [string]
      - `size` [string]

---

## FormGroup
Controls how users input answers. Each input type has a specific structure.

### CheckBox
- `CheckboxGroup` [object]
  - `heading` [object]
    - `text` [string]
    - `size` [string]
  - `validation` [object]
    - `required` [boolean]
  - `options` [array]
    - `label` [string]
    - `value` [string]
    - `conditionalInputs` [array]
      - `label` [string]
      - `name` [string]
      - `inputType` [string] – Valid: `text`
      - `disabled` [boolean]
      - `validation` [object]

### Radio Button
- `RadioButtonGroup` [object]
  - `heading` [object]
    - `text` [string]
    - `size` [string]
  - `hint` [string]
  - `name` [string]
  - `options` [array]
    - `label` [string]
    - `validation` [object]

### Text Input
- `TextInputGroup` [object]
  - `sectionName` [string]
  - `fields` [array]
    - `disabled` [boolean]
    - `hint` [string]
    - `label` [string]
    - `name` [string]
    - `validation` [object]

### Text Area
- `Textarea` [object]
  - `hint` [string]
  - `label` [object]
    - `text` [string]
    - `size` [string]
  - `name` [string]
  - `rows` [number]
  - `spellCheck` [boolean]
  - `validation` [object]

### File Upload
- `fileUpload` [object]
  - `allowMultiple` [boolean]
  - `label` [object]
    - `size` [string]
    - `text` [string]
  - `name` [string]
  - `validation` [object]

---

## Validation
If validation is required, the following fields may be included:

- `validation` [object]
  - `required` [boolean] - Is question mandatory
  - `maxLength` [number] - Maximum number of accepted words
  - `minLength` [number] - Minimum number of accepted word
  - `inLength` [number]
  - `pattern` [string] – Matches specified pattern
  - `validationLabel` [string] - Custom text to appear in validation not met
  - `unique` [boolean] - Check if another application has previously submitted this value
  - `countWords` [boolean] - Display word counter

---

## Size
Valid values for text size:

- `s` – Small
- `m` – Medium
- `l` – Large
- `xl` – Extra Large
