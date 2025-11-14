---
layout: standard
order: 5
title: Release Pipelines in Digital Services
date: 2025-10-01 # this should be the date that the content was most recently amended or formally reviewed
id: OFQ-00005 # Set unique ID for standard
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
    - title: Related Standards
      items:
        - text: Build Pipelines for Digital Infrastructure
          href: /standards/build-pipelines
---

<!-- Standard description -->

<!-- 

# Notes on line breaks

Please see https://x-govuk.github.io/govuk-eleventy-plugin/markdown/#line-breaks for notes on usage of line breaks.

# Notes on linking to headings within a page

Heading tags are automatically assigned an id, converting spaces to `kebab-case` and applying URL encoding. If you want to link to a specific heading, you can obtain the URL encoded link by running the site locally, inspecting the appropriate <h3> element in the browser's developer tools and copying the value from the 'id' attribute.
-->

This standard defines how developers and infrastructure engineers must set up release pipelines in digital services; release pipelines are used in all deployed services except for static apps, which are controlled via the [Build Pipelines](/standards/build-pipelines#static-applications)

---

## Requirement(s)

<!-- Populate list for each requirement (there can be more than 2) -->

<!--

# Notes on anchor links

Use HTML URL encoding as in the 'Notes on links' above, to ensure that links to headers with punctuation works as expected. For example:

[Product documentation MUST include build, release and deployment processes](#product-documentation-must-include-build%2C-release-and-deployment-processes)

-->

- [Release pipelines MUST have a Dev stage that deploys automatically](#release-pipelines-must-have-a-dev-stage-that-deploys-automatically)
- [Release pipelines MUST have a Preprod stage that deploys manually](#release-pipelines-must-have-a-preprod-stage-that-deploys-manually)
- [Release pipelines MUST have a Prod stage that requires managerial approval](#release-pipelines-must-have-a-prod-stage-that-requires-managerial-approval)

### Release pipelines MUST have a Dev stage that deploys automatically

#### General Steps

##### Create a new pipeline

1. Navigate to our Releases page on Dev Ops - Pipelines -> Releases
2. Click on `+ New` -> `New release pipeline`

##### Set up the Release Artifact

1. On the main pipeline sceen, click on `Add an artifact`.
2. Choose the Source type of `Build`. 
3. Select the relevant build pipeline. 
4. Click `Add`.

#### Set up the IaC Artifacts for Container Apps
This needs setting up for each environment 

##### Dev:  
1 On the main pipeline screen, click on `Add an artifact`.
2 Choose the source type of `Azure Repo`.
3 Select Project `Ofqual.IM`.
4 Select Source(repo) `Ofqual.Infrastructure`.
5 Select branch `feature/deploy_dev_infra`.
6 Set the alias `_Ofqual.InfrastructureDev`. 

##### Pre Prod:  
1 On the main pipeline screen, click on `Add an artifact`.
2 Choose the source type of `Azure Repo`.
3 Select Project `Ofqual.IM`.
4 Select Source(repo) `Ofqual.Infrastructure`.
5 Select branch `feature/deploy_pprd_infra`.
6 Set the alias `_Ofqual.InfrastructurePprd`. 

##### Prod:  
1 On the main pipeline screen, click on `Add an artifact`.
2 Choose the source type of `Azure Repo`.
3 Select Project `Ofqual.IM`.
4 Select Source(repo) `Ofqual.Infrastructure`.
5 Select branch `feature/deploy_prd_infra`.
6 Set the alias `_Ofqual.InfrastructurePrd`. 


#### Container App

##### Set up first stage:

You will be prompted to select a template for the initial stage, this can be skipped and completed later. 

1. On the main pipeline screen in the Stages section select `+ Add` -> `New stage`.
2. Select to start with an empty job. 
3. Give the stage a name of `Dev`.

##### Configure the task:

1. On the Stages section on your `Dev` stage click on `1 job, 0 task` to view in more detail.
2. On the Agent job tab click the `+` button to add a new task. Do a search for `cli` and add the task `Azure Cli`.
3. Fill in the empty fields 
    1. Give a Display name of `Install container app extension`.
    2. Select the relevant Azure Subscription, for this stage it should be `Enterprise Dev/test 2024`.
    3. Script Type - `PowerShell`.
    4. Script Location - `Inline script`.
    5. Inline Script for dev - 
    ```powershell
        az deployment group create `
        --resource-group "$(ResourceGroupName)" `
        --template-file ` "$(System.DefaultWorkingDirectory)/_Ofqual.InfrastructureDev/bicep/contApps/main_containerApp.bicep" `
        --parameters ` "@$(System.DefaultWorkingDirectory)/{repo-name}/drop/Bicep/{name-of-config-file}" `
        --parameters "imageTag=$(Build.BuildId)"     
    ``` 


##### Set up Pipeline Variables 

The scope for the following variables should all be `Dev` to match the name of the Dev Stage.

1. On the tabs at the top of the main pipeline screen click on `Variables`.
2. Under `Pipeline variables` add in the following:
    1. Name: `AcrUri` Value: input the relevant container registry uri e.g `ofqdevportal.azurecr.io`.
    2. Name: `AppName` Value: input the relevant app name e.g `ofq-dev..`.
    3. Name: `ImageUri` Value: input the relevant uri e.g `ofqdevportal.azurecr.io/ofq-dev-expertsapply`.
    4. Name: `ResourceGroupName` Value: input the relevant resource group e.g `RG-DEV-Experts`.

#### Function App

##### Set up first stage:

You will be prompted to select a template for the initial stage, this can be skipped and completed later. 

1. Select from the list (you may need to search for it) `Deploy a function app to Azure Functions` and click Apply.
2. Give the Stage a name of `Dev`. 
3. The stage will be created, this will be set up with a default Pre-deployment condition - this will be a trigger that will start the deployment to the Dev stage after a release (i.e. after an artifact has been published from the build pipeline and dropped into the release pipeline).

##### Configure the task:

1. On the Stages section on your `Dev` stage click on `1 job, 1 task` to view the task in more detail.
2. Fill in the empty fields 
    1. Select the relevant Azure Subscription, for this stage it should be `Enterprise Dev/test 2024`.
    2. App type `Function App on Linux`.
    3. App service name - select the relevant App service. e.g `ofq-dev..`.
3. If you click on to the `Deploy Azure Function App` task you should see the fields have been auto filled based on the fields you completed above.

#### App Service (DEPRECATED)

This is only to be used on legacy systems; new systems should deploy to container apps or function apps instead

##### Set up first stage:

You will be prompted to select a template for the initial stage, this can be skipped and completed later. 

1. Select from the list (you may need to search) `Azure App Service deployment` and click Apply.
2. Give the Stage a name of `Dev`. 
3. The stage will be created, this will be set up with a default Pre-deployment condition - this will be a trigger that will start the deployment to the Dev stage after a release (i.e. after an artifact has been published from the build pipeline and dropped into the release pipeline).

##### Configure the task:

1. On the Stages section on your `Dev` stage click on `1 job, 1 task` to view the task in more detail.
2. Fill in the empty fields 
    1. Select the relevant Azure Subscription, for this stage it should be `Enterprise Dev/test 2024`.
    2. App type `Web App on Linux`.
    3. App service name - select the relevant App service. e.g `ofq-dev..`.
3. If you click on to the `Deploy Azure App Service` task you should see the fields have been auto filled based on the fields you completed above. 


### Release pipelines MUST have a Preprod stage that deploys manually

#### Container App

##### Set up stage:

1. On the main pipeline screen in the Stages section select `+ Add` -> `New stage`.
2. Select to start with an empty job. 
3. Give the stage a name of `Preprod`.

##### Configure the first task:

1. On the Stages section on your `Preprod` stage click on `1 job, 0 task` to view in more detail.
2. On the Agent job tab click the `+` button to add a new task. Do a search for `cli` and add the task `Azure Cli`.
3. Fill in the empty fields 
    1. Give a Display name of `Install container app extension`.
    2. Select the relevant Azure Subscription, for this stage it should be `Enterprise Dev/test 2024`.
    3. Script Type - `PowerShell`.
    4. Script Location - `Inline script`.
    5. Inline Script - 
    az deployment group create `
    --resource-group "$(ResourceGroupName)" `
    --template-file ` "$(System.DefaultWorkingDirectory)/_Ofqual.InfrastructurePprd/bicep/contApps/main_containerApp.bicep" `
    --parameters ` "@$(System.DefaultWorkingDirectory)/{repo-name}/drop/Bicep/{name-of-config-file}" `
    --parameters "imageTag=$(Build.BuildId)" 
    ```


##### Set up Pipeline Variables 

The scope for the following variables should all be `Preprod` to match the name of the Preprod Stage.

1. On the tabs at the top of the main pipeline screen click on `Variables`.
2. Under `Pipeline variables` add in the following:
    1. Name: `AcrUri` Value: input the relevant container registry uri.
    2. Name: `AppName` Value: input the relevant app name e.g `ofq-preprod..`.
    3. Name: `ImageUri` Value: input the relevant uri.
    4. Name: `ResourceGroupName` Value: input the relevant resource group.

#### Function App

##### Set up stage:

1. On the main pipeline screen in the Stages section select `+ Add` -> `New stage`.
2. Select from the list (you may need to search for it) `Deploy a function app to Azure Functions` and click Apply. 
3. Give the stage a name of `Preprod`.

##### Configure the Pre-deployment trigger:

1. On this new stage click on the lighting bolt icon to see the Pre-deployment triggers. 
    1. Change the trigger from `After release` to `Manual only`.

##### Configure the task:

1. Click on `1 job, 1 task` to view the task in more detail.
2. Fill in the empty fields. 
    1. Select the relevant Azure Subscription, for this stage it should be `Enterprise Dev/test 2024`.
    2. App type `Function App on Linux`.
    3. App service name - select the relevant App service. e.g `ofq-preprod..`
3. If you click on to the `Deploy Azure Function App` task you should see the fields have been auto filled based on the fields you completed above. 

#### App Service (DEPRECATED)

This is only to be used on legacy systems; new systems should deploy to container apps or function apps instead

##### Set up stage:

1. On the main pipeline screen in the Stages section select `+ Add` -> `New stage`.
2. Select the task `Azure App Service deployment`. 
3. Give the stage a name of `Preprod`.

##### Configure the Pre-deployment trigger:

1. On this new stage click on the lighting bolt icon to see the Pre-deployment triggers. 
    1. Change the trigger from `After release` to `Manual only`.

##### Configure the task:

1. Click on `1 job, 1 task` to view the task in more detail.
2. Fill in the empty fields. 
    1. Select the relevant Azure Subscription, for this stage it should be `Enterprise Dev/test 2024`.
    2. App type `Web App on Linux`.
    3. App service name - select the relevant App service. e.g `ofq-preprod..`
3. If you click on to the `Deploy Azure App Service` task you should see the fields have been auto filled based on the fields you completed above. 

### Release pipelines MUST have a Prod stage that requires managerial approval

#### General Steps

##### Set up Manager Approval stage

This Stage will have no task applied to it. 

###### Set up stage:

1. On the main pipeline screen in the Stages section select `+ Add` -> `New stage`.
2. Select to start with an empty job. 
3. Give the stage a name of `Production - Manager Approval`.

###### Configure the Pre-deployment trigger:

1. On this new stage click on the lighting bolt icon to see the Pre-deployment triggers. 
    1. Change the trigger from `After release` to `Manual only`.
    2. Enable `Pre-deployment approvals` and select the relevant group as Approvers.
    3. Set the Approval order to be `Any one user`.

#### Set up Production - Deploy stage

##### Container App

###### Set up stage:

1. On the main pipeline screen in the Stages section select `+ Add` -> `New stage`.
2. Select to start with an empty job. 
3. Give the stage a name of `Production - Deploy`.

###### Configure the first task:

1. On the Stages section on your `Production - Deploy` stage click on `1 job, 0 task` to view in more detail.
2. On the Agent job tab click the `+` button to add a new task. Do a search for `cli` and add the task `Azure Cli`.
3. Fill in the empty fields 
    1. Give a Display name of `Install container app extension`.
    2. Select the relevant Azure Subscription, for this stage it should be `Microsoft Azure Enterprise 2025`.
    3. Script Type - `PowerShell`.
    4. Script Location - `Inline script`.
    5. Inline Script - 
    ```powershell
    az deployment group create `
    --resource-group "$(ResourceGroupName)" `
    --template-file ` "$(System.DefaultWorkingDirectory)/_Ofqual.InfrastructurePrd/bicep/contApps/main_containerApp.bicep" `
    --parameters ` "@$(System.DefaultWorkingDirectory)/{repo-name}/drop/Bicep/{name-of-config-file}" `
    --parameters "imageTag=$(Build.BuildId)" 
    ```

###### Set up Pipeline Variables 

The scope for the following variables should all be `Production - Deploy` to match the name of the Production - Deploy Stage.

1. On the tabs at the top of the main pipeline screen click on `Variables`.
2. Under `Pipeline variables` add in the following:
    1. Name: `AcrUri` Value: input the relevant container registry uri.
    2. Name: `AppName` Value: input the relevant app name e.g `ofq-prod..`.
    3. Name: `ImageUri` Value: input the relevant uri.
    4. Name: `ResourceGroupName` Value: input the relevant resource group.

##### App Service (DEPRECATED)

This is only to be used on legacy systems; new systems should deploy to container apps or function apps instead

###### Set up stage:

1. On the main pipeline screen in the Stages section select `+ Add` -> `New stage`.
2. Select the task `Azure App Service deployment`. 
3. Give the stage a name of `Production - Deploy`.

###### Configure the Pre-deployment trigger:

1. On this new stage click on the lighting bolt icon to see the Pre-deployment triggers. 
    1. Change the trigger from `After release` to `After stage`.
    2. From the dropdown list select the stage `Production - Manager Approval`.
    3. Enable `Pre-deployment approvals` and select the relevant group as Approvers.
    4. Set the Approval order to be `Any one user`.

###### Configure the task:

1. Click on `1 job, 1 task` to view the task in more detail.
2. Fill in the empty fields. 
    1. Select the relevant Azure Subscription, for this stage it should be `Microsoft Azure Enterprise 2024`.
    2. App type `Web App on Linux`.
    3. App service name - select the relevant App service. e.g `ofq-prod..`
3. If you click on to the `Deploy Azure App Service` task you should see the fields have been auto filled based on the fields you completed above. 

---
