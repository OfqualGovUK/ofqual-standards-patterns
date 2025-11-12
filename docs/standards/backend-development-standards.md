---
layout: standard
order: 1
title: Backend development standard
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
        - text: Frontend development standard
          href: /standards/
---

<!-- Standard description -->
Backend Code Standards
This document serves as our base for standards across all the backends we maintain, and serves the following areas:
- General standards (applicable to all languages/technologies)
- Specific language and technology standards

---

## Requirement(s)

<!-- Populate list for each requirement (there can be more than 2) -->

<!--

# Notes on anchor links

Use HTML URL encoding as in the 'Notes on links' above, to ensure that links to headers with punctuation works as expected. For example:

[Product documentation MUST include build, release and deployment processes](#product-documentation-must-include-build%2C-release-and-deployment-processes)

-->
General Standard Requirements
- [Set Up (General)](#Set-Up)
- [Requirement 2](#requirement-2)
- [Requirement 3](#requirement-3)
- [Requirement 4](#requirement-4)

### Set Up (General)
All repositories MUST have:
- A Dockerfile for running the system with
- Configured Integration and Unit Tests
- A LICENSE.md (which should be an MIT License)
- A README.md defining the project and how to run it on a local device
- A SECURITY.md file defining how to disclose vulnerabilities to Ofqual
- A .gitignore
- An azure-pipelines.yml for defining the build pipelines
- An Architectural and Technical Design
- Use Configuration over Hardcoding
For example, if you have a page format that could be reused (say a multiple choice question page), make that reusable and configurable

### Exceptions and Logging
- Exceptions MUST be caught and logged out as low as possible. 
For example, if an error occurs in a repository's function, it should be caught and logged in that function instead of relying on a catch at a higher level.
- Exception messages MUST follow the format of: Exception raised when <description of what was happening>, in <class name>::<function name>. Exception message: <exception message>
This enables us to identify easily in the logs where the issue manifested.


### Requirement 3
Specific Technology Guidance - C Sharp / ASP.NET  Core
Setting up a new system
In addition to the setup standard should include:
- A landing page for development purposes. This should only be available when ASPNETCORE_ENVIRONMENT is set to DEVELOPMENT
- Unit and Integration tests
- An appropriate Dockerfile for the project
- Separate Infrastructure and Core projects
The main project is used for storing the Program.cs, appsettings, and Controllers in their own folder
Core is used for Models, Interfaces for structures and Enums
Infrastructure is used for Services, Repositories and other supporting items such as Mappers
Serilog for appropriate logging control

### Organisation and Naming conventions
The models folder MUST be structured with
- a folder for each database table or item represented (e.g. User)
- A DTO for a table can go in the same folder as its corresponding model (e.g. User and UserDto)
- Models which join tables together can be named in a similar way to how link tables would be named. For instance, if a model represented a join between a "Task" and a "Question", that model could be called "TaskQuestion"
Only do this if both items are in the same "level"; if for instance in the above example, the Question table was mapped to a List<Question>, then just name the model "Task"

### Requirement 4
Object Orientated
DTO objects MUST be used when transferring more complex data from a client to other services/domains.
The use of Interfaces and code built around using interfaces generically allows concrete classes to be replaced in the future:
- Repositories and Clients always need an interface
- Shared attributes and functionality between models MUST always have an interface that is then implemented across all models that can use it
- Prioritise using the interface over the concrete class in any function / attribute definitions unless you specifically require a concrete implementation

---
