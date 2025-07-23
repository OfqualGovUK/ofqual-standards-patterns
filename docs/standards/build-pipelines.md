---
layout: standard
order: 4
title: Build Pipelines
date: 2025-07-23 # this should be the date that the content was most recently amended or formally reviewed
id: OFQ-00004 # Set unique ID for standard
# use `tags: []` for no tags
# Note: tags must use sentence case capitalisation
tags:
  - Digital
  - Infrastructure
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related Principles
      items:
        - text: We use the right tools and have the right rules
          href: /principles/we-use-the-right-tools-and-have-the-right-rules/ # Note: use an absolute link from the site home page
        - text: We keep things neat and tidy
          href: /principles/we-keep-things-neat-and-tidy/ # Note: use an absolute link from the site home page
        - text: Security is everyone's responsibility
          href: /principles/security-is-everyones-responsibility/
    - title: Related Patterns
      items:
        - text: Snyk as a Security Scanning Tool
          href: /principles/we-use-the-right-tools-and-have-the-right-rules/ # Note: use an absolute link from the site home page
        - text: We keep things neat and tidy
          href: /principles/we-keep-things-neat-and-tidy/ # Note: use an absolute link from the site home page
        - text: Security is everyone's responsibility
          href: /principles/security-is-everyones-responsibility/


---

<!-- Standard description -->

<!-- 

# Notes on line breaks

Please see https://x-govuk.github.io/govuk-eleventy-plugin/markdown/#line-breaks for notes on usage of line breaks.

# Notes on linking to headings within a page

Heading tags are automatically assigned an id, converting spaces to `kebab-case` and applying URL encoding. If you want to link to a specific heading, you can obtain the URL encoded link by running the site locally, inspecting the appropriate <h3> element in the browser's developer tools and copying the value from the 'id' attribute.
-->

This standard covers our requirements for how Build Pipelines should be configured within Ofqual-developed services.

---

## Requirement(s)

<!-- Populate list for each requirement (there can be more than 2) -->

<!--

# Notes on anchor links

Use HTML URL encoding as in the 'Notes on links' above, to ensure that links to headers with punctuation works as expected. For example:

[Product documentation MUST include build, release and deployment processes](#product-documentation-must-include-build%2C-release-and-deployment-processes)

-->

- [Build pipelines MUST run SAST Analysis before building artifacts](#build-pipelines-must-run-sast-analysis-before-building-artifacts)
- [Build pipelines MUST run automated tests before building artifacts](#build-pipelines-must-run-automated-tests-before-building-artifacts)
- [Build pipelines MUST build and publish an appropriate artifact](#build-pipelines-must-build-and-publish-an-appropriate-artifact)

### Build pipelines MUST run SAST Analysis before building artifacts

The first stage should always be to set up static analysis. This is set up to run one job:

- Snyk, a SAST Analysis tool that checks code for vulnerabilities

Snyk is currently the standard scanning tool we use to satisfy the [Security in First Party Software](/standards/security-in-first-party-software) standard.

Some pipelines may choose to implement additional tooling, such as Sonarqube and internal build tool scanning (e.g. `dotnet list package --vulnerable`). These are optional and are not covered in this standard document. You should only implement such additional tooling with the approval of the Lead Developer and Security Team.

#### Configuring the YAML

As good practice we should save the endpoint needed for authentication and the token(api key) as pipeline variables:

- `$(SNYK_ENDPOINT)` = `https://app.eu.snyk.io/api`
- `$(SNYK_TOKEN)` = this can be retrieved this from a pipeline that already has Snyk implemented

**WARNING**

- Use a separate stage for this. There should be one job configured:
  - A job for running Snyk
- See the snippets below for example implementations
- Only include the `Build Docker Image` & `container` tasks if there is a working Dockerfile included in the repo

##### Front-End Example (React)

_NB: Don't just copy and paste this! This is an example from 29/04/2025 - it may be out of date (e.g. Node version spec)_

```yaml

- stage: StaticAnalysis
  displayName: "Run Static Analysis"
  condition: always()
  jobs:
  - job: Snyk
      displayName: 'Build and Snyk Analysis'
      pool:
        vmImage: ubuntu-latest
      steps:
        - task: NodeTool@0
          inputs:
            versionSpec: "22.x"
          displayName: "Install Node.js"
        - task: Npm@1
          displayName: "npm install"
          inputs:
            command: 'install'
            customRegistry: 'useFeed'
            customFeed: 'b8db0229-c220-4583-b1d9-1111e482a1ce'
        - task: Npm@1
          displayName: 'npm build dist'
          inputs:
            command: custom
            verbose: false
            customCommand: "run dist"

        # Install and authenticate Snyk
        - script: |
            npm install -g snyk
            snyk config set endpoint=$(SNYK_ENDPOINT)
            snyk auth $(SNYK_TOKEN)
            set +e
          displayName: 'Snyk Install & Auth'

        - task: SnykSecurityScan@1
          displayName: 'Synk code scan'
          inputs:
            testType: 'code'
            serviceConnectionEndpoint: 'snyk-integration-eu'
            codeSeverityThreshold: 'high'
            failOnIssues: true

        - task: SnykSecurityScan@1
          displayName: 'Synk app scan'
          inputs:
            testType: 'app'
            serviceConnectionEndpoint: 'snyk-integration-eu'
            monitorWhen: 'always'
            severityThreshold: 'high'
            failOnIssues: true
            additionalArguments: '--all-projects'

```

##### Back-End Example (C#)

_NB: Don't just copy and paste this! This is an example from 29/04/2025 - it may be out of date (e.g. Node version spec)_

```yaml

- stage: StaticAnalysis
  displayName: "Run Static Analysis"
  jobs:
  - job: SonarQube
    displayName: 'Build and SonarQube Analysis'
    pool:
      vmImage: ubuntu-latest
    steps:
      - task: UseDotNet@2
        displayName: 'Install .NET Core SDK'
        inputs:
          version: 8.x
          performMultiLevelLookup: true
          includePreviewVersions: true

      - task: DotNetCoreCLI@2
        displayName: "Restore task"
        inputs:
          command: 'restore'
          projects: '**/*.csproj'
          feedsToUse: 'select'
          vstsFeed: 'b8db0229-c220-4583-b1d9-1111e482a1ce'
      - task: DotNetCoreCLI@2
        displayName: "Build task"
        inputs:
          command: "build"
          projects: "**/*.csproj"
          arguments: "--configuration $(BuildConfiguration)"

      # Install and authenticate Snyk
        - script: |
            npm install -g snyk
            snyk config set endpoint=$(SNYK_ENDPOINT)
            snyk auth $(SNYK_TOKEN)
            set +e
          displayName: 'Snyk Install & Auth'

        - task: SnykSecurityScan@1
          displayName: 'Synk code scan'
          inputs:
            serviceConnectionEndpoint: 'snyk-integration-eu'
            testType: 'code'
            codeSeverityThreshold: 'high'
            failOnIssues: true

        - task: SnykSecurityScan@1
          displayName: 'Synk app scan'
          inputs:
            serviceConnectionEndpoint: 'snyk-integration-eu'
            testType: 'app'
            monitorWhen: 'always'
            severityThreshold: 'high'
            failOnIssues: true
            additionalArguments: '--all-projects'

        - task: Docker@2
          displayName: Build Docker Image
          inputs:
            command: build
            repository: 'register-frontend'
            dockerfile: '$(dockerfilePath)'
            tags: 'latest'

        - task: SnykSecurityScan@1
          displayName: 'Synk container scan'
          inputs:
            serviceConnectionEndpoint: 'snyk-integration-eu'
            testType: 'container'
            dockerImageName: 'register-frontend:latest'
            dockerfilePath: '$(dockerfilePath)'
            monitorWhen: 'always'
            severityThreshold: 'high'
            failOnIssues: true

```

### Build pipelines MUST run automated tests before building artifacts

A 'Run Tests' stage should always be present, and execute appropriate test suites based on the repository. Generally speaking, this can be:

- Some form of E2E testing (on new systems, Playwright)
- Some form of unit and/or integration testing

If tests fail, they should always block the pipeline from passing. Tests should always be ran regardless of Static Analysis results.

Exceptions to this requirement should only be approved by the Lead Developer and will generally only be approved on legacy equipment that cannot be maintained; no exceptions will be approved for newly-written software

#### Example Snippets

_NB: Don't just copy and paste this! This is an example from 26/02/2024 - it may be out of date (e.g. Node version spec) and in most cases should just be used as a reference_

##### Playwright (React)

```yaml

- job: Playwright
    condition: always()
    dependsOn: []
    displayName: "Playwright"
    steps:
    - task: NodeTool@0
      inputs:
        versionSpec: "18.x"
      displayName: "Install Node.js"
    - task: Npm@1
      displayName: "npm install"
      inputs:
        command: "install"
        customRegistry: "useFeed"
        customFeed: "b8db0229-c220-4583-b1d9-1111e482a1ce"
    - script: |
        npx playwright install --with-deps
      displayName: "install playwright"
    - script: |
        npx playwright test
      env:
        TEST_DB_CONN: $(DB_CONN)
      displayName: "Run playwright"
    - publish: $(System.DefaultWorkingDirectory)/playwright-report
      artifact: playwright-report
      # always create the artifact, this is useful for debugging failed tests
      condition: always()
      displayName: "Publish playwright report"
    - task: PublishTestResults@2
      displayName : "Publish playwright results"
      inputs:
        testResultsFormat: 'JUnit'
        testResultsFiles: '**/results.xml'
        failTaskOnFailedTests: true
        testRunTitle: 'playwright-results-$(Build.BuildId)'

```

##### Unit Tests (Front End, React)

```yaml
- job: UnitTests
  condition: always()
  dependsOn: []
  displayName: "Unit tests"
  steps:
    - task: NodeTool@0
      inputs:
        versionSpec: "18.x"
      displayName: "Install Node.js"
    - task: Npm@1
      displayName: "npm install"
      inputs:
        command: "install"
        customRegistry: "useFeed"
        customFeed: "b8db0229-c220-4583-b1d9-1111e482a1ce"
    - task: Npm@1
      displayName: "npm run test"
      inputs:
        command: "custom"
        customCommand: "run test:ci"
    - task: PublishTestResults@2
      displayName: "Publish unit test results"
      inputs:
        testResultsFormat: "JUnit"
        testResultsFiles: "**/junit.xml"
        failTaskOnFailedTests: true
        testRunTitle: "unit-test-results-$(Build.BuildId)"
```

##### Unit Tests (Back-End / C#)

```yaml

- job: UnitTests
    condition: always()
    dependsOn: []
    displayName: "Unit tests"
    steps:
    - task: UseDotNet@2
        inputs:
        packageType: "sdk"
        version: "3.1.x"

    - task: DotNetCoreCLI@2
        displayName: "Restore task"
        inputs:
        command: "restore"
        projects: "**/*.csproj"
        feedsToUse: "config"
        nugetConfigPath: "nuget.config"

    - task: DotNetCoreCLI@2
        displayName: "Build task"
        inputs:
        command: "build"
        projects: "**/*.csproj"
        arguments: "--configuration $(BuildConfiguration)"

    - task: DotNetCoreCLI@2
        env:
        OdsContainer__Endpoint: $(OdsContainer__Endpoint)
        OdsContainer__Username: $(OdsContainer__Username)
        OdsContainer__Password: $(OdsContainer__Password)
        OdsContainer__SqlPassword: $(OdsContainer__SqlPassword)
        displayName: "Run unit tests"
        inputs:
        command: 'test'
        projects: '**/*Tests.csproj'
        arguments: '--filter "(Category=Unit)|(Category=Integration)"'
        testRunTitle: 'Ofqual.Communications_$(Build.BuildNumber)'
```

### Build pipelines MUST build and publish an appropriate artifact

The last stage should finally build and publish out a build.

- Front-End releases should only do this on tagged builds
- Back-End releases should only do this on main and release branch builds
    - You may need to reconfigure the corresponding release pipeline to achieve this

The type of artifact required will depend upon the deployed infrastructure:

- New systems should always be built using Docker Images instead of pure build artifacts
- Function Apps require specific YAML stages to be deployed
- Legacy systems typically require a specific build artifact that is then published to the artifact registry

#### Docker Images

##### Introduction

Docker is currently our standard way of creating new services

Key notes for this YAML:

- You _must_ publish to separate registries; the release pipelines and services can only see registries on their same subscription which necessitates multiple registries
- The name of the image should be the same across both registries for configuration consistency
- Do not run a build and publish at all for pull requests (unless we can figure out a way of building without a publish). We could consider a registry or naming convention dedicated to PRs if QA or Devs find it useful to build and store images for them
- Do not build and publish to the prod registry unless on a release branch; this prevents accidental pushes of main to prod
- Always publish both to latest _and_ an appropriate tag for historical and rollback purposes

##### Example Snippets

_NB: Don't just copy and paste this! These are examples from 23/07/2025 - it may be out of date (e.g. Node version spec) and in most cases should just be used as a reference_

###### Environment Variables for this YAML:

- `dockerRegistryServiceConnectionDev`: `CROFQAPPdev1-Federated`
- `dockerRegistryServiceConnectionProd`: `CROFQPORTAL-Federated`
- `imageRepository`: `ofqual/{product name}-{type}` where `{product-name}` is the name of the product (e.g. RefData, SOC, PFS), and {type} is either API or Frontend

```yaml
- stage: Build
  displayName: Build and push stage
  jobs:
    - job: BuildDev
      condition: and(succeeded(), not(startsWith(variables['build.sourceBranch'], 'refs/pull')))
      displayName: Build for Dev
      pool:
        vmImage: $(vmImageName)
      steps:
        - task: Docker@2
          displayName: Build and push an image to dev container registry
          inputs:
            command: buildAndPush
            repository: $(imageRepository)
            containerRegistry: $(dockerRegistryServiceConnectionDev)
            dockerfile: $(dockerfilePath)
            tags: |
              latest
              $(tag)
    - job: BuildProd
      condition: and(succeeded(), startsWith(variables['build.sourceBranch'], 'refs/heads/releases'))
      displayName: Build for Production
      pool:
        vmImage: $(vmImageName)
      steps:
        - task: Docker@2
          displayName: Build and push an image to production container registry
          inputs:
            command: buildAndPush
            repository: $(imageRepository)
            containerRegistry: $(dockerRegistryServiceConnectionProd)
            dockerfile: $(dockerfilePath)
            tags: |
              latest
              $(tag)
```

##### Function Apps

###### Introduction

- Sometimes it is more suitable to use a function app over a Docker Image, such as when capacity is forecast to need to rapidly increase and decrease over time (thus requiring flexible scaling up and down to optimise costs)
- This is generally done by exception and should be approved by the Lead Developer before being user.

###### Example Snippets

_NB: Don't just copy and paste this! These are examples from 23/07/2025 - it may be out of date (e.g. Node version spec) and in most cases should just be used as a reference_

```yaml
- stage: Deploy
  displayName: Deploy stage
  dependsOn: BuildAndPackage
  condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))

  jobs:
    # Deploy job: This job deploys the build artifact to the Azure Function App.
    - deployment: Deploy
      displayName: Deploy
      environment: 'development'
      pool:
        vmImage: $(vmImageName)
      strategy:
        runOnce:
          deploy:
            steps:
              # Deploy to Azure Function App
              - task: AzureFunctionApp@2
                inputs:
                  connectedServiceNameARM: $(ConnectedServiceName)
                  appType: 'functionApp'
                  appName: $(FunctionAppName)
                  package: '$(Pipeline.Workspace)/drop/$(Build.BuildId).zip'
                  deploymentMethod: 'auto'
```

##### Legacy Systems using App Services (DEPRECATED)

*Note: This section of the standard is deprecated. This should only be used on legacy systems that cannot be moved to Docker; do not use this for new systems*

###### Example Snippets

_NB: Don't just copy and paste this! These are examples from 26/02/2024 - it may be out of date (e.g. Node version spec) and in most cases should just be used as a reference_

###### Back-End (C#)

```yaml
- stage: BuildAndPackage
  dependsOn: RunTests
  displayName: "Build and package"
  jobs:
  - job: PublishArtifact
    displayName: "Publish Artifact"
    steps:
    - task: UseDotNet@2
        displayName: 'Install .NET Core SDK'
        inputs:
        version: 6.x
        performMultiLevelLookup: true
        includePreviewVersions: true # Required for preview versions

    - task: DotNetCoreCLI@2
        displayName: "Restore task"
        inputs:
        command: "restore"
        projects: "**/*.csproj"
        feedsToUse: "select"
        vstsFeed: "b8db0229-c220-4583-b1d9-1111e482a1ce"

    - task: DotNetCoreCLI@2
        displayName: "Build task"
        inputs:
        command: "build"
        projects: "**/*.csproj"
        arguments: "--configuration $(BuildConfiguration)"

    - task: DotNetCoreCLI@2
        displayName: "Publish task"
        inputs:
        command: publish
        publishWebProjects: True
        arguments: '--configuration $(BuildConfiguration) --output "$(build.artifactstagingdirectory)"'
        zipAfterPublish: True

    - task: PublishBuildArtifacts@1
        displayName: "Publish Artifact"
        inputs:
        PathtoPublish: "$(build.artifactstagingdirectory)"
```

###### Front End (React)

```yaml
- stage: BuildAndPackage
  dependsOn: RunTests
  condition: and(succeeded(), startsWith(variables['build.sourceBranch'], 'refs/tags/v'))
  displayName: "Build and package"
  jobs:
    - job: PublishPackage
      displayName: "Publish Package"
      steps:
        - task: NodeTool@0
          inputs:
            versionSpec: "18.x"
          displayName: "Install Node.js"
        - task: Npm@1
          displayName: "npm install"
          inputs:
            command: "install"
            customRegistry: "useFeed"
            customFeed: "b8db0229-c220-4583-b1d9-1111e482a1ce"
        - task: Npm@1
          displayName: "npm build dist"
          inputs:
            command: custom
            verbose: false
            customCommand: "run dist"
        - task: Npm@1
          displayName: "npm pack"
          inputs:
            command: custom
            verbose: false
            customCommand: pack
        - task: Npm@1
          displayName: "npm publish"
          inputs:
            command: publish
            verbose: false
            publishRegistry: useFeed
            publishFeed: "b8db0229-c220-4583-b1d9-1111e482a1ce"
```

---
