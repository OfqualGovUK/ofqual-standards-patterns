---
layout: standard
order: 11
title: Shutter page content
date: 2025-10-21 # this should be the date that the content was most recently amended or formally reviewed
id: OFQ-00011 # Set unique ID for standard
# use `tags: []` for no tags
# Note: tags must use sentence case capitalisation
tags:
  - Infrastructure
  - Digital
  - UCD
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related Principles
      items:
        - text: We are collaborative and transparent
          href: /principles/we-are-collaborative/ # Note: use an absolute link from the site home page
        - text: We use the right tools and have the right rules
          href: /principles/we-use-the-right-tools-and-have-the-right-rules/ # Note: use an absolute link from the site home page
        - text: We keep things neat and tidy
          href: /principles/we-keep-things-neat-and-tidy/ # Note: use an absolute link from the site home page
---

<!-- Standard description -->

<!-- 

# Notes on line breaks

Please see https://x-govuk.github.io/govuk-eleventy-plugin/markdown/#line-breaks for notes on usage of line breaks.

# Notes on linking to headings within a page

Heading tags are automatically assigned an id, converting spaces to `kebab-case` and applying URL encoding. If you want to link to a specific heading, you can obtain the URL encoded link by running the site locally, inspecting the appropriate <h3> element in the browser's developer tools and copying the value from the 'id' attribute.
-->

This standard defines how the content for shutter pages (used to inform a user that a service is unavailable) should be written and presented.


---

## Requirements

<!-- Populate list for each requirement (there can be more than 2) -->

<!--

# Notes on anchor links

Use HTML URL encoding as in the 'Notes on links' above, to ensure that links to headers with punctuation works as expected. For example:

[Product documentation MUST include build, release and deployment processes](#product-documentation-must-include-build%2C-release-and-deployment-processes)

-->

- [You SHOULD follow the GOV.UK design system pattern](#you-should-follow-the-govuk-design-system-pattern)
- [You MUST be as specific as possible without being confusing](#you-must-be-as-specific-as-possible-without-being-confusing)
- [You MUST choose a content template based on which service is unavailable](#you-must-choose-a-content-template-based-on-which-service-is-unavailable)
- [You MUST choose content sections based on the facts to hand](#you-must-choose-content-sections-based-on-the-facts-to-hand)
- [You SHOULD update the page as the facts change](#you-should-update-the-page-as-the-facts-change)

### You SHOULD follow the GOV.UK design system pattern

The GOV.UK design system has a recommended [pattern for implementing shutter pages](https://design-system.service.gov.uk/patterns/service-unavailable-pages/) for GOV.UK services. Where possible, we should follow its best-practice recommendations.

### You MUST be as specific as possible without being confusing

A shutter page is most helpful when it can inform the user that the service is unavailable, when it will be available again and what, if anything, has happened to any data the user has in the system. Language should meet standards set out in the [GOV.UK style guide](https://www.gov.uk/guidance/style-guide) and be simple to understand. Where possible to do so, tell the user:

* the name of the service that is unavailable
* that the service is unavailable
* the day, date and time when the service will become available
* what has happened to their data, if they are in the middle of a process in the system
* contact information, if it is required to meet user needs
* links to alternative services that can help the user meet their need, if any exist

### You MUST choose a content template based on which service is unavailable

Where a single service is unavailable, base your shutter page content on the [appropriate template](#templates) below to match the service.

Where multiple services are unavailable, base your content on the [multiple services](#multiple-services) template.

### You MUST choose content sections based on the facts to hand

Each shutter page, according to the GOV.UK standard, has a number of [content sections](#content-sections) which can be used depending on the situation and the available information:

* timings - when the service will become available again, or if the service has permanently closed - must be present
* user data - what has happened to the user's data, especially relating to if the user was in the middle of a transaction - may be present
* contact information - if required to allow the user to meet a user need - may be present
* other services - links to alternative services that meet the user needs - may be present

### You SHOULD update the page as the facts change

If the facts change after the shutter page has been posted, you should update the page to match the new facts.

For example, if the service needs to remain unavailable for longer than anticipated, the shutter page should be updated with the new, confirmed time when it is expected to become available again.


## Content sections

### Timings

_This section must always be present._

* If you are unsure of the timings for when the service will become available again, you should use the phrase:  
>You will be able to use the service later.
* Where you have a target time for the service becoming available, make this known to the user, and be as specific as possible. If you know the exact time, then use it:  
>You will be able to use the service from 9am on Monday 6 October 2025.
* Otherwise, just give the day and date:  
>You will be able to use the service on Monday 6 October 2025.

### User data

_This section may optionally be present._

Use this section where the service allows users to input or modify data. It should reassure the user what has happened to any data they were in the middle of inputting, but also inform them if the data will only be stored for a limited time.

* Where the service cleans out data for incomplete user workflows, tell the user how long we keep the data for:  
>We have saved your answers. They will be available for 30 days.
* Where the service stores partial data indefinitely:  
>Your answers have been saved for when the service is available again.
* Where the service has not stored partial data:  
>We have not saved your answers. When the service is available, you will have to start again.

### Contact information

_This section may optionally be present._

**Do not direct users to contact Ofqual via phone or email without confirming with the service owner and the product lead that it is appropriate to do so.**

Where the process is business critical or time sensitive, it may be necessary to direct users to another method of contacting Ofqual. It is acceptable to either link to a page containing the contact information or to include it on the page.

If linking to a page, it is preferable to link to the [contact page on the main Ofqual website](https://www.gov.uk/guidance/contact-ofqual) unless otherwise agreed with the service owner and product lead.

* Linking through to contact information:  
>[Contact Ofqual](https://www.gov.uk/guidance/contact-ofqual) if you need to talk to someone about your application.
* Providing contact information on-page:  
>Contact us if you need to speak to someone about your case.
>
>Phone:  
**0300 303 3344**
>
>Email:  
**<public.enquiries@ofqual.gov.uk>**
>
>Opening times:  
**Monday to Friday: 9am to 5pm**

### Other services

_This section may optionally be present._

Where there is another public-sector service that fully or partially meets the user needs of the service that is unavailable we can link the user to it. Do not link to commercial services as it may be seen as a sign of endorsement.

* Link to a single service:
> You can [use the find a learning aim service](https://submit-learner-data.service.gov.uk/find-a-learning-aim/) to find information on available:
>
> * qualifications
> * standards
> * apprenticeships
> * T Levels

* Link to multiple services:
> You can [use the find a learning aim service](https://submit-learner-data.service.gov.uk/find-a-learning-aim/) to find information on available:
>
> * qualifications
> * standards
> * apprenticeships
> * T Levels
>
> You can [use the find a course service](https://nationalcareers.service.gov.uk/find-a-course) to find information on:
>
> * qualifications
> * courses
> * unregulated courses 
> * skills bootcamps

## Templates

### Multiple services

#### Title

```
<!-- HEAD - title -->
<title>Sorry, the service is unavailable - Ofqual - GOV.UK</title>
```

#### Body content

```
<!-- SECTION - heading -->
<h1 class="govuk-heading-l">Sorry, the service is unavailable</h1>

<!-- SECTION - timings -->
<p class="govuk-body">
  You will be able to use the service later.
</p>
```

### The Portal

#### Title

```
<!-- HEAD - title -->
<title>Sorry, the service is unavailable - The Portal - Ofqual - GOV.UK</title>
```

#### Body content

Customise the sections below as needed, following the details in [content sections](#content-sections).

```
<!-- SECTION - heading -->
<h1 class="govuk-heading-l">Sorry, the service is unavailable</h1>

<!-- SECTION - timings -->
<p class="govuk-body">
  You will be able to use the service later.
</p>

<!-- SECTION - user data -->
<p class="govuk-body">
  Your answers have been saved for when the service is available again.
</p>

<!-- SECTION - contact information -->
<p class="govuk-body">
  <a href="https://www.gov.uk/guidance/contact-ofqual" class="govuk-link">Contact Ofqual</a>
  if you urgently need to complete a task while the portal is unavailable.
</p>
```

### The Register

This covers the services `Find a regulated qualification` and `Find a regulated awarding organisation`.

#### Title

```
<!-- HEAD - title -->
<title>Sorry, the service is unavailable - Find a regulated qualification or awarding organisation - Ofqual - GOV.UK</title>
```

#### Body content

Customise the sections below as needed, following the details in [content sections](#content-sections).

```
<!-- SECTION - heading -->
<h1 class="govuk-heading-l">Sorry, the service is unavailable</h1>

<!-- SECTION - timings -->
<p class="govuk-body">
  You will be able to use the service later.
</p>

<!-- SECTION - other services -->
<p class="govuk-body">
  You can <a href="https://submit-learner-data.service.gov.uk/find-a-learning-aim/" class="govuk-link">use the find a learning aim service</a> to find information on available:
</p>
<ul class="govuk-list govuk-list--bullet">
  <li>qualifications</li>
  <li>standards</li>
  <li>apprenticeships</li>
  <li>T Levels</li>
</ul>
<p class="govuk-body">
  You can <a href="https://nationalcareers.service.gov.uk/find-a-course" class="govuk-link">use the find a course service</a>
  to find information on:
</p>
<ul class="govuk-list govuk-list--bullet">
  <li>qualifications</li>
  <li>courses</li>
  <li>unregulated courses</li>
  <li>skills bootcamps</li>
</ul>
```

### Subject matter specialists

#### Title

```
<!-- HEAD - title -->
<title>Sorry, the service is unavailable - Subject matter specialists - Ofqual - GOV.UK</title>
```

#### Body content

Customise the sections below as needed, following the details in [content sections](#content-sections).

```
<!-- SECTION - heading -->
<h1 class="govuk-heading-l">Sorry, the service is unavailable</h1>

<!-- SECTION - timings -->
<p class="govuk-body">
  You will be able to use the service later.
</p>

<!-- SECTION - user data -->
<p class="govuk-body">
  Your answers have been saved for when the service is available again.
</p>
```

### Contact Ofqual

#### Title

```
<!-- HEAD - title -->
<title>Sorry, the service is unavailable - Contact Ofqual - Ofqual - GOV.UK</title>
```

#### Body content

Customise the sections below as needed, following the details in [content sections](#content-sections).

```
<!-- SECTION - heading -->
<h1 class="govuk-heading-l">Sorry, the service is unavailable</h1>

<!-- SECTION - timings -->
<p class="govuk-body">
  You will be able to use the service later.
</p>

<!-- SECTION - user data -->
<p class="govuk-body">
  We have not saved your answers. When the service is available, you will have to start again.
</p>

<!-- SECTION - contact information -->
<p class="govuk-body">
  Contact us if you need to speak to someone about your case.
</p>
<p class="govuk-body">Phone:<br>
  <span class="govuk-!-font-weight-bold">
    0300 303 3344
  </span>
</p>
<p class="govuk-body">Email:<br>
  <a href="mailto:public.enquiries@ofqual.gov.uk" class="govuk-link govuk-!-font-weight-bold">public.enquiries@ofqual.gov.uk</a>
</p>  
<p class="govuk-body">Opening times:<br>
  <span class="govuk-!-font-weight-bold">
    Monday to Friday: 9am to 5pm
  </span>
</p>
```

### Recognition

#### Title

```
<!-- HEAD - title -->
<title>Sorry, the service is unavailable - Apply to have your qualifications regulated - Ofqual - GOV.UK</title>
```

#### Body content

Customise the sections below as needed, following the details in [content sections](#content-sections).

```
<!-- SECTION - heading -->
<h1 class="govuk-heading-l">Sorry, the service is unavailable</h1>

<!-- SECTION - timings -->
<p class="govuk-body">
  You will be able to use the service later.
</p>

<!-- SECTION - user data -->
<p class="govuk-body">
  Your answers have been saved for when the service is available again.
</p>

<!-- SECTION - contact information -->
<p class="govuk-body">
  <a href="https://www.gov.uk/guidance/contact-ofqual" class="govuk-link">Contact Ofqual</a>
  if you need to talk to someone about your application.
</p>
```
---
