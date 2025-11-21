---
layout: pattern
order: 1
title: Containerised services
date: 2025-11-21 # this should be the date that the content was most recently amended or formally reviewed
# use `tags: []` for no tags 
# Note: tags must use sentence case capitalisation
tags:
  - Digital
related: # remove this section if you do not need related links on your page
  sections:
    - title: Related links
      items:
        - text: 
          href: 
---

This pattern outlines containerizing APIs hosted on the current tenant and migrating the registry keys from the old tenant to the current tenant. 
The process includes:
1.	Creating a Dockerfile in the repo of the API
2.	Adding Docker Push to Azure-pipelines.yaml 
3.	Create azure container for dockerised API
    a.	Basics
    b.	Container
        -	Environment variables manual entry
        -	Connection strings manual entry
    c.	Ingress
    d.	Tags
    e.	Review + Create
4.	Assign ACR pull
5.	Check API registry keys have been created. 



---

## Solution

<!-- Solution text -->

---

## Considerations (optional)

<!-- Considerations text -->

---

## Examples (optional)


## 1.	Creating a Dockerfile

Navigate to the azure repo of your API and select the create new file. 
(Please note that the naming conventions for this file should be: Dockerfile)
Once the Dockerfile has been created make the changes as needed, each API will have different Dockerfile parameters and endpoints so using one as an example would not work here. 
For more information on what is required for a Dockerfile, here is a good site to check out:  Writing a Dockerfile | Docker Docs

## 2.	Adding Docker Push to Azure-pipelines.yaml
Environment Variables for this YAML:
- dockerRegistryServiceConnectionDev: CROFQAPPdev1-Federated
- dockerRegistryServiceConnectionProd: CROFQPORTAL-Federated
- imageRepository: ofqual/{product name}-{type} where {product-name} is the name of the product (e.g. RefData, SOC, PFS), and {type} is either API or Frontend
 
## 3.	Create an Azure Container
In ADO, select container apps from the services menu, once you have navigated to the container apps main page you can create a new container app. 
- a.	Basics – This includes the following parameters :
    1.	Subscription - Defaulted to enterprise dev/test I,e current tenant
    2.	Resource group - Should be defaulted to RG-Portal-Dev1 but you can search if not. 
    3.	Container app name - The following naming convention  should always apply: “ofq-dev-api-name”
    4.	Deployment resource – Leave as is (Container Image)
    5.	Region – Is usually South West but please refer to infrastructure or the dev team for clarification. 
    6.	Container app environment – This is populated when the region is selected and changes depending on region. 

- b.	Container, this section is used to populate environment variables including connection strings as well as populate the docker image you pushed earlier in the pipelines as seen below:
    1.	Name – Name of you container
    2.	Image source – Leave is azure container
    3.	Subscription – Enterprise dev/test (Current tenant subscription name)
    4.	Registry – We are currently in the process of changing registries for the  APIs through the pipeline, as it stands at the time of writing this document, the registry will be defofquaapi.azurecr.io, if you select this, you will see you api in the drop-down list, once selected image will be populated in the text box below. 
    5.	Image – populated when the API is selected in the correct registry drop down. Once you have completed this section please move to Development stack and ignore anything in between. 
    6.	Development stack – Default is generic but preferred option Is .net
    7.	Workload profile – leave as is
    8.	CPU and Memory – Leave as is
    9.	Environment Variables – Navigate to App Services and search for the API you are currently creating a container app for, and search for the environment variables and connections strings, once located insert the name and value for each environment variable and connection string in the text boxes. 

- c.	Ingress includes information relating to ports and movement of traffic. 
    1.	Select ingress enabled check box
    2.	Accept traffic from anywhere
    3.	Target port is defaulted to 8080 but some APIs are 80, you’ll know if it is 80 when trying to start the container if you check the details. 
    4.	Leave all other boxes and text boxes as they are. 
 
- d.	Tags are used to so a user can find an API if needed in this instance we tag the APIs as App and Environment with the value AO Portal and DEV/TEST as seen below: 
 
- e.	Review + Create, if everything has been put through correctly including the environment variables and the connection strings, it willow you to create the container. 


## 4.	Assign ACR Pull
MSI ACR Pull enables deployments in a Kubernetes cluster to use any user assigned managed identity to pull images from Azure Container Registry. With this, each application can use its own identity to pull container images and being such Ofqual have decided to use managed identities for their dockerised APIs moving forward. 
    1.	In the left panel of the container app menu, navigate to identity and select on toggle and save, once this is done you’ll see an option at the bottom to add an azure role assignment
    2.	Add role assignment option at the top and from the drop down select acr pull as seen below, once you have done this just let it run in the background you can check the status usually in 5 minutes or so. 

## 5.	Check Registration keys have been created	
a.	On the left panel of the container app, select secrets
b.	The keys are now created and hosted on the new tenant

---
