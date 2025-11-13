# How to contribute

This is the contribution guide for the Ofqual Principles, Standards and Patterns. This guide will cover the primary way we expect contributions to be made, which is adding new principles, standards and patterns.

# Getting Started

We will now look at the process we expect contributors to take when suggesting fixes, new content or a review of existing content.

## Make changes

To start the process of making changes, firstly you must be added to the Ofqual organisation as a member; if you are not, you will not be able to push branches to the repository

### Create a branch

Please create a branch using the default GitHub branch naming strategy which is based off the issue you are working on. Changes made to the main branch will be rejected

### Make changes in the UI

If you are updating a small piece of text, a typo or broken link, then you can edit the file directly from GitHub.  Click the make a contribution button which will open the file in the GitHub user interface. 

### Make changes locally

If the change is more substantial, then you may want to get the code and run it locally.  If you take a look at our [README](README.md), there are instruction on how to do this.

Make sure you pull your fork and switch to your new branch to do these changes.

### Commit your update

Don't forget to commit and push your changes to your forked repo ready for the contribution!

## Pull Requests

When you're finished with your changes you should create a pull request, commonly known as a PR.

### How to create a PR

Find some helpful information on how to create [GitHub Pull Requests](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request).

When creating a PR, use the appropriate template checklists for code and content changes.

### Who can merge your PR

Any other member of the Ofqual organisation can review your PR; once they have done so, you have permission to then merge in your PR yourself, so long as the pipeline checks also pass. If they do not, seek the assistance of another developer to investigate.

## Your PR is merged!

Congratulations, your contribution is now merged into the project and you have improved and added value to an on-going open source project.  Thank you!

# Additional Info for Maintainers

## New to open source

Please find some helpful links to guide you in starting your journey with open source.

- To get an overview of our project please see our [README](README.md).
- [Collaborating with pull requests](https://docs.github.com/en/github/collaborating-with-pull-requests)
- [See the benefits of Open Source](https://opensource.guide/)

## Testing

### E2E Tests

Currently we are using Cypress to do end to end tests. As this is a static site, these are lightweight and check that any changes continue to build front page links correctly.

Please add to these where you feel necessary.

### Integration Tests

There are no integration tests currently being used in this repo.  As the site is built using the Cross Government Eleventy plugin and mark down files, there is limit scope to do this.  

However, if you feel that some changes are becoming more complex, then you may want to consider adding these in.

## Build, release, deploy

We are using [GitHub workflows](https://github.com/OfqualGovUK/ofqual-standards-patterns/tree/main/.github/workflows) for build and deploy and automated end to end testing.

The following actions are performed for each PR before merging:

- Automated end to end testing using Cypress

PRs must only be approved after they pass the above checks.

Once merged the site is deployed.

## Branching

### Branching strategy

We are using a trunk based strategy.

# Organisation of content

Patterns, principles and standards should be created in the correct subdirectory in `/docs`. We are also using a tagging and metadata approach to organise content across the site by topic and related knowledge domain.

All patterns, principles and standards content should be tagged in the frontmatter of the .md file

You can view a list of [all the topic domain tags currently in use across the site](https://mango-pebble-0e6614103.6.azurestaticapps.net/tags/). Your content may cross cut many of these areas, and that is ok, tag everything that you think is relevant.

## Look at the standard for the content

When creating content please take a look at the standard for that content. This helps to make sure we are all creating content correctly.

- [Writing a principle](https://mango-pebble-0e6614103.6.azurestaticapps.net/standards/writing-a-principle/)
- [Writing a standard](https://mango-pebble-0e6614103.6.azurestaticapps.net/standards/writing-a-standard/)

### Templates

You can use the following templates when creating content:
- [Principle template](https://github.com/OfqualGovUK/ofqual-standards-patterns/blob/main/docs/principles/principle.template.md)
- [Standard template](https://github.com/OfqualGovUK/ofqual-standards-patterns/blob/main/docs/standards/standard.template.md)
