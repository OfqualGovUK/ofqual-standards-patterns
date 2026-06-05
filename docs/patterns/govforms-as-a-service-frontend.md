---
layout: pattern
order: 1
title: GovForms as a service frontend
date: 2026-06-05 # this should be the date that the content was most recently amended or formally reviewed
# use `tags: []` for no tags 
# Note: tags must use sentence case capitalisation
tags:
  - Digital
  - Product
  - QA
  - Data
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related principles
      items:
        - text: We use the right tools and have the right rules
          href: /principles/We-use-the-right-tools-and-have-the-right-rules/
        - text: We are needs driven
          href: /principles/We-are-needs-driven/
        - text: We focus on use and business outcomes
          href: /principles/We-focus-on-use-and-business-outcomes/
---

<!-- Pattern description -->

[GovForms](https://govforms.uk) is used to provide the front-end of some of our services, including SMS Renew and Awarding Organisation Expansions. This pattern describes how to integrate GovForms with our services, covering API integration, authentication, environment variables, patterns and testing.

---

## GovForms overview

GovForms is a forms builder with strong adherence to GOV.UK Frontend and GOV.UK Design System patterns and components. We use it to create structured front-ends for Ofqual services that do not require complex business logic. It allows the polling of APIs to feed data into the form and for us to retrieve data at the end. It allows the use of the [Liquid templating language](https://shopify.github.io/liquid/) in many areas of the forms interface, allowing for complex data manipulation if desired.

Forms are arranged into different service libraries. The public availability of forms and the sign-on method in-use are defined at the library level rather than at the forms level.


## When to use GovForms

A decision to use GovForms as the frontend for a service must be by the mutual agreement of Digital, Data, Product and UCD teams. Below are some guidelines that might suggest whether GovForms is or isn't a good fit.

### GovForms might be a good fit

It might be a good fit if the service:

* should look like a GOV.UK service
* is either linear or branches based on the user's answers
* is purely to capture data from users and store in our systems
* pulls a limited amount of data from our systems in order to present that data in the course of the form
* is not complex but requires a user to be able to create and track a 'case'

### GovForms might not be a good fit

It might not be a good fit if the service needs to:

* display a lot of data on a page or if that data needs to be placed in specific parts of the page (eg in panels)
* transfer a lot of data to or from our APIs as the user progresses through the service
* make a lot of API calls throughout the service journey
* integrate with a lot of other, discrete systems
* provide an integrated messaging service with the user

## User authentication

The built-in options in GovForms are:

* unauthenticated
* magic-link email (passwordless)
* Open ID Connect (OAuth 2.0)
* AWS Cognito

The authentication settings are defined at the library level, but you can decide whether each form requires authentication or not. The consequence is that you can't have 2 forms with differing authentication settings, e.g. GOV.UK One Login and Entra ID, within the same library – they would have to be placed in separate libraries.

**Do not alter the authentication settings on existing libraries.**

Where possible it is preferred to use GovForms built-in authentication settings rather then authenticating outside the service – external authentication requires you to pass a token to the form to identify the user, however the method of doing this is unsupported and requires workarounds to ensure the token makes it all the way through the form.


## API integration

API integrations only work on forms that have been deployed to the QA and Production environments.

API hostnames must be whitelisted by GovForms admin before they can be used in the production environment.

The hostnames below are currently whitelisted:

* `https://ofq-prd-common-refdata-api.wittybay-a6b6e414.uksouth.azurecontainerapps.io`
* `https://ofq-prd-comm-users-api.wittybay-a6b6e414.uksouth.azurecontainerapps.io`
* `https://ofq-prd-expert-apply-api.wittybay-a6b6e414.uksouth.azurecontainerapps.io`
* `https://login.microsoftonline.com`

**Note: If APIs are under GOV.UK then you do not need to do anything as everything under there is already whitelisted by GovForms.**

APIs can be called from any standard question page and the results stored within the form session data. Consult Darcy (the in-built chatbot for details on how to interface with APIs and the resulting data).

### Environment variables to change APIs endpoints

It is often necessary to use different API endpoints in testing and production. You can set properties and secrets within the library settings and these can contain different values depending on whether the environment is QA or production. Use this feature to set the differing API endpoints for testing and production.

It is good practice to include a matching or representative API response as a mock response in the page action settings for testing in the prototyping environment. This can also provide a clear example of the expected response contract for an API that doesn't yet exist.

## Testing

Since APIs cannot be used in the GovForms prototyping environment, all pre-production testing must be done in the GovForms QA environment.

Where the form needs to interact with different Ofqual services in QA and production, e.g. for testing APIs vs production APIs, these endpoints and secrets should be defined as environment variables and secrets within the library settings. There are separate sections for QA and production so the system can automatically swap between them when the form is deployed to QA or production.

### Testing for services requiring authentication

There are currently two main forms of authentication in our GovForms services.

1. Built-in GovForms authentication, which can be configured at the library level.
1. External authentication, where the user authenticates outside of the form and then a token is passed to the form to identify the user, in this scenario the govform actually operates in anonymous mode.

The first method, built-in GovForms authentication, is preferred as it is supported by GovForms and ensures we have all the user info available within the form session data, whereas the second method is not supported and requires workarounds to ensure any user identification is saved to the form submission.

For testing with GovForms built-in authentication, you can create test users within the GovForms admin interface and use these to log in to the form in the QA environment. 

In the case of the `Ofqual 2` library (Expansions form), this uses Entra ID for authenticating awarding organisation (AO) users. You must create users in the Entra ID tenant that is used for the library and assign them to the appropriate permissions in GovForms to ensure they have access to the QA form. User creation can be done in the Portal UI to create a user for an AO and automatically add them to the Entra ID tenant. It's recommended to use a dedicated email address for test AO users. You will also need access to AO Portal GOV.UK Notify service to grab the temporary password email from the API Integration dashboard. It must be intercepted in the Notify UI - the email will not be sent to the actual email address. Once you have the temporary password, you can log in to the form with the Portal login address given, and set a new password for future use.

For SMS services, users use GOV.UK OneLogin to authenticate into the citizen app, but as part of the GovForms integration, we use a `OneShotToken` authentication method where the user is authenticated outside of the form and then a token is passed to the form to identify the user. This method is not supported by GovForms and requires workarounds to ensure the token makes it all the way through the form and that any necessary user information is saved to the form submission. For testing, you will need to generate a valid token for a test user and pass it in as a query parameter and also include the service journey query parameter in the URL.

## Patterns

Each library has a `patterns` section where tested and verified patterns have been placed for use in other services. To use these, you must create a new form based off the pattern.

Patterns in testing can be found in the libraries, with the name preceded by `pattern-`.