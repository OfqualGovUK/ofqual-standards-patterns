---
layout: standard
order: 1
title: Front-end Development
date: 2025-11-12 
id: OFQ-00012 
tags:
  - Digital
  - Data
related: 
  sections:
    - title: Related links
      items:
        - text: Back-end Development
          href: /standards/back-end-development
        - text: Viper Architecture in C Sharp Front-Ends
          href: /standards/viper-architecture-in-c-sharp-front-ends
---

This is our base for standards across all the frontends we maintain, and serves the following areas:
- General Guidance, applicable to all languages/technologies
- Specific language and technology standards that don't require their own standalone standard

---

## Requirements
- [All repositories MUST be set up in a consistent manner](#all-repositories-must-be-set-up-in-a-consistent-manner)
- [All exceptions MUST be handled and logged](#all-exceptions-must-be-handled-and-logged)

### All repositories MUST be set up in a consistent manner

All repositories should have:

- A Dockerfile for running the system with
- Configured Accessibility, Acceptance, Integration and Unit Tests
- A LICENSE.md (which should be an MIT License)
- A README.md defining the project and how to run it on a local device
- A SECURITY.md file defining how to disclose vulnerabilities to Ofqual
- An azure-pipelines.yml for defining the build pipelines

#### C Sharp / ASP.NET Core Specific Guidance

- In addition to the General principle, setup should include:
  - A landing page for development purposes. This should only be available when `ASPNETCORE_ENVIRONMENT` is set to `DEVELOPMENT`
  - Use the `GovUk.Frontend.AspNetCore` package for installing the GOV.UK Frontend toolkit. Do **not** use minified JS.
    - Most installs shouldn't require the use of npm or explicit package.jsons and should simply be a case of installing the nuget package and configuring it in the _Layout.cshtml and Program.cs
    - You _will_ need to use an explicit package.json combined with a gulpfile to appropriately move assets, if you need to use the MOJ Design System (or any other design toolkit)
  - Configured Accessibility, Acceptance, Unit and Integration tests
  - An appropriate Dockerfile for the project
  - Separate out Infrastructure, Core and Web components
    - Web components are used for Controllers, Pages and ViewModels
    - Core is used for Domain Models, Configuration and Enums
    - Infrastructure is used for Services, Repositories and Clients (things typically used for business logic and communication to other things)
  - Serilog should be setup so that we can have appropriate logging control
  - To differentiate between Models and ViewModels (which could have the same name and overall structure), ViewModels should always have ViewModel as their suffix

### All exceptions MUST be handled and logged
- Exceptions MUST be caught and logged out as low as possible. 
For example, if an error occurs in a repository's function, it should be caught and logged in that function instead of relying on a catch at a higher level.
- Exception messages MUST follow the format of: `Exception raised when <description of what was happening>, in <class name>::<function name>. Exception message: <exception message>` as this enables us to identify easily in the logs where the issue manifested.


---
