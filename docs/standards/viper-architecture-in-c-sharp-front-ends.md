---
layout: standard
order: 6
title: VIPER-Style Architecture in C# Front-Ends
date: 2025-08-28 # this should be the date that the content was most recently amended or formally reviewed
id: OFQ-00006 # Set unique ID for standard
# use `tags: []` for no tags
# Note: tags must use sentence case capitalisation
tags:
  - Digital
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related principles
      items:
        - text: We keep things neat and tidy
          href: /principles/we-keep-things-neat-and-tidy/ # Note: use an absolute link from the site home page
    - title: External documentation
      items:
        - text: A video on various different architectural structures, including VIPER
          href: https://www.youtube.com/watch?v=I5c7fBgvkNY

          
---

<!-- Standard description -->

<!-- 

# Notes on line breaks

Please see https://x-govuk.github.io/govuk-eleventy-plugin/markdown/#line-breaks for notes on usage of line breaks.

# Notes on linking to headings within a page

Heading tags are automatically assigned an id, converting spaces to `kebab-case` and applying URL encoding. If you want to link to a specific heading, you can obtain the URL encoded link by running the site locally, inspecting the appropriate <h3> element in the browser's developer tools and copying the value from the 'id' attribute.
-->

From August 2025, Ofqual now implements a flavour of 'VIPER' Architecture for C# Front-ends. This comprises of:

- Views, which is the presentational component
- Interactors, which manipulate raw data and data from the view and serve as the business logic layer. In Ofqual, these comprise of Services, Mappers and Repositories
- Presenters, which bridge the View and Interactor components. In Ofqual, we name these as ViewModels, as they effectively serve as the model used within the View
- Entities, which contain raw data from data sources; In Ofqual, we name these as Models
- Routers, which control navigation on the site. In Ofqual, we name these as Controllers

The adjustments in conventions are to smooth onboarding on to this kind of architecture, as it is generally more modern (and thus less familiar) to developers; most legacy applications use a simpler MVC architecture. Legacy applications should *not* be ported over to VIPER architecture unless a full rewrite is permitted.

The benefits of this architecture include:

- Clear separation of concerns; typically data coming in from an API needs to be manipulated to be ideal for presenting to a user/view. This architecture means we can do this without muddying data models with presentational items too much, and vice versa
- The architecture aligns much with how we prefer to architect C# APIs, as these also have a separation between raw data and data sent out to the client, as well as similar patterns such as Controllers, Services and Clients. This is why some of the naming conventions for VIPER have been changed, to ensure there is a level of familiarity maintained when switching between Front and Back-end, as we work as full-stack teams


---

## Requirement(s)

<!-- Populate list for each requirement (there can be more than 2) -->

<!--

# Notes on anchor links

Use HTML URL encoding as in the 'Notes on links' above, to ensure that links to headers with punctuation works as expected. For example:

[Product documentation MUST include build, release and deployment processes](#product-documentation-must-include-build%2C-release-and-deployment-processes)

-->

- [C Sharp Front-ends MUST use Views](#c-sharp-front-ends-must-use-views)
- [C Sharp Front-ends MUST use Interactors (Services, Mappers and Clients)](#c-sharp-front-ends-must-use-interactors-%28Services%2C-mappers-and-clients%29)
- [C Sharp Front-ends MUST use Presenters (ViewModels)](#c-sharp-front-ends-must-use-presenters-%28viewmodels%29)
- [C Sharp Front-ends MUST use Entities (Models)](#c-sharp-front-ends-must-use-entities-%28models%29)
- [C Sharp Front-ends MUST use Routers (Controllers)](#c-sharp-front-ends-must-use-routers-%28controllers%29)

### C Sharp Front-ends MUST use Views

Views are part of the presentational layer of the front-end and work much in the same way as MVC Views. Important aspects are:

- Views are served by Routers (Controllers), typically as a return from a Router function
- Views that require data should have a Presenter (ViewModel) passed in
- Views should be stored in the Web project of the solution in a Views folder
- Views are .cshtml files; these get added in Program.cs using "AddControllersWithViews", instead of using Razor Pages
- Partial Views, which represent fragments that can then be imported into another view, should have a leading underscore in their name to indicate that they are a partial


### C Sharp Front-ends MUST use Interactors (Services, Mappers and Clients)

Interactors are the heart of the system and control the interaction between the data layer and the presentational layer. Unlike in standard VIPER, which uses singular Interactors, we split this out into three core components.

- Clients, which are used to directly communicate with a data persistence source, such as another API. This is the closest thing to the I/O layer of the application, and should be specified to communicate with a specific API. To reduce boilerplate, we mainly use HttpClientFactory for API Clients and have a singular function, GetClientAsync, to configure the HttpClient appropriately for a given API
- Mappers, which are *static* classes that Map Entities (Models) to Presenters (ViewModels) and vice versa. The only logic in these should be from converting items to other items, and should only contain atomic functions that do not mutate other objects outside the function.
- Services, which are *not static* classes, are mainly used to process business logic and co-ordinate the usage of Clients and Mappers. For instance, a service may be used to obtain some data via a client, and then use a mapper to convert that data from an Entity (Model) to a Presenter (ViewModel)

All interactors should obey the single-responsibility principle; do not write monolithic interactors that try to handle all tasks for that type of interactor (e.g. a Mapper class that handled mapping all of a singular front-ends mapping needs).

Both Clients and Services may be held in the Infrastructure project; Mappers should be held in the Web project as for scoping reasons, as Presenters (ViewModels) are held in this project too (putting the Mapper in the Infrastructure project usually results in circular dependency problems)

### C Sharp Front-ends MUST use Presenters (ViewModels)

Presenters are used to hold the presentational data for a given view and are typically translations of raw Entity (Model) data; as a result, Ofqual names these as ViewModels, as they are literally models of the View to be presented. ViewModels should:

- Do *not* have to be named after the View they are used in if appropriate, but nearly always map on to either a View or a Partial View
- Be broken down into submodels if needed; this is particularly relevant when JSON Data is being used to dynamically drive the content for the View
- Be held in the Web project of the solution in a ViewModels folder

### C Sharp Front-ends MUST use Entities (Models)

Entities named Models in Ofqual, as they are effectively synonymous. These Models are for storing and sending out the raw data to and from data persistence stores and are likely to be formatted differently to a Presenter (ViewModel) as a result. For instance, a Model may store JSON Data for defining some content, which then gets mapped out to various different ViewModels. Models should:

- Be held within the Core project of the solution
- Avoid binding themselves to infrastructure implementation; aim to be as close to a POCO class as possible. This allows for flexibility of data persistence implementation in the future

### C Sharp Front-ends MUST use Routers (Controllers)

Routers, named as Controllers in Ofqual, handle the navigation of the system. These should:

- With few exceptions (mainly around handling authentication depending upon authentication implementation), return a View, Redirect or appropriate Error result for each Route specified
- Aim to contain as little business logic as possible, instead forwarding such tasks on to Interactors. A Router may handle some basic co-ordination of Interactors, but anything beyond this likely should be delegated to a Service

You should have a plan for how to appropriately handle errors to be propogated out to a user in a usable manner; for instance, if a NotFound result is raised, then this should display a Not Found type page (typically done using a StatusCodePages middleware that redirects to an Error Controller, that _then_ displays a View)

---
