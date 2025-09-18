---
homepage: true
layout: product
title: Principles, Standards and Patterns
description: Build better solutions by working to agreed Ofqual principles, standards and patterns
startButton:
  href: "/about/"
  text: Find out more about what we are doing
# hide duplicate title in page title
options:
  header:
    productName: ''
  titleSuffix: Ofqual
---
<div class="govuk-grid-row">
{% for item in homepageLinks %}
  <section class="govuk-grid-column-one-third-from-desktop govuk-!-margin-bottom-8">
    <h2 class="govuk-heading-m govuk-!-font-size-27">{{ item.data.title }}</h2>
    <p class="govuk-body">{{ item.data.description | markdown("inline") }}</p>
    <p class="govuk-body">
      <a class="govuk-link govuk-!-font-weight-bold" href="{{ item.url }}">
        Read our {{ item.data.title | lower }}
      </a>
    </p>
  </section>
{% endfor %}
</div>
