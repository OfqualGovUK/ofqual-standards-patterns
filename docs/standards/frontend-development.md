---
layout: standard
order: 1
title: Front end development standards
date: 2025-11-12 
id: OFQ-00000 
# use `tags: []` for no tags
# Note: tags must use sentence case capitalisation
tags:
  - Digital
  - Data
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related links
      items:
        - text: Backend Development standards
          href: /standards/
---
Frontend Code Standards
This is our base for standards across all the frontends we maintain, and serves the following areas:
- General Guidance, applicable to all languages/technologies
- Specific language and technology standards

---

## Requirement(s)

- [Requirement 1](#requirement-1)
- [Requirement 2](#requirement-2)

### Requirement 1
General Principles
Set Up
All repositories should have:
A Dockerfile for running the system with
Configured Accessibility, Acceptance, Integration and Unit Tests
A LICENSE.md (which should be an MIT License)
A README.md defining the project and how to run it on a local device
A SECURITY.md file defining how to disclose vulnerabilities to Ofqual
An azure-pipelines.yml for defining the build pipelines
Architectural and Technical Design
Configuration over Hardcoding
For example, if you have a page format that could be reused (say a multiple choice question page), make that reusable and configurable

### Requirement 2
Exceptions and Logging
By principle, exceptions should be caught and logged out as low as possible. For example, if an error occurs in a repository's function, it should be caught and logged in that function instead of relying on a catch at a higher level
Exception messages should be in the format of Exception raised when <description of what was happening>, in <class name>::<function name>. Exception message: <exception message> so that we can identify easily in the logs where the issue was identified


### Requirement 2
Specific Technology Guidance for C Sharp / ASP.NET  Core when setting up a new system
In addition to the general setup standards these MUST also be included:
- A landing page for development purposes. Only available when ASPNETCORE_ENVIRONMENT is set to DEVELOPMENT
- Use the GovUk.Frontend.AspNetCore package for installing the GOV.UK Frontend toolkit. Do not use minified JS.
- Most installs shouldn't require the use of npm or explicit package.jsons and should simply be a case of installing the nuget package and configuring it in the _Layout.cshtml and Program.cs
- You will need to use an explicit package.json combined with a gulpfile to appropriately move assets, if you need to use the MOJ Design System (or any other design toolkit)
- Configured Accessibility, Acceptance, Unit and Integration tests
- An appropriate Dockerfile for the project
- Separate out Infrastructure, Core and Web components
- Web components are used for Controllers, Pages and ViewModels
- Core is used for Domain Models, Configuration and Enums
- Infrastructure is used for Services, Repositories and Clients (things typically used for business logic and communication to other things)
- Serilog should be setup so that we can have appropriate logging control

### ViewModels
- To differentiate between Models and ViewModels (which could have the same name and overall structure), ViewModels MUST always have ViewModel as their suffix
- A ViewModel is purely presentational; these MUST only be referenced in the Web portion of the service.
- If you need to retrieve data from somewhere or send data out (e.g. the cache, a HTTP Client), then a Model MUST be used; the data should then be mapped to and from the ViewModel as appropriate

---

