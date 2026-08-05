
# Ofqual Principles, Standards and Patterns
 
This is the home of principles, standards and patterns for Ofqual Digital and Data. 

It is built using Markdown, GOV.UK templates, Ofqual styles, the [x-gov Eleventy Plugin](https://x-govuk.github.io/govuk-eleventy-plugin/) and GitHub Actions.

## Requirements

- [Node.js](https://nodejs.org)
- [Eleventy](https://www.11ty.dev)
- [x-gov Eleventy Plugin](https://x-govuk.github.io/govuk-eleventy-plugin/)
- [Nunjucks](https://mozilla.github.io/nunjucks/) for the templating language

## Installation

```
npm install
```

This will install the dependencies needed to run the site.

## Preview your changes locally

Eleventy has the ability to serve the site in a hot reload environment.  You can call this from the npm scripts:

```
npm run serve
```

This maps to Eleventy hot reload script 'serve'.

### Alternative method for previewing changes locally

Alternatively, to run the site locally you can build the static html files and then deploy the _site folder to a http server.

Firstly you can run

```
npm run build
```

Which creates the static html. Then you can use a good very light weight http server to host them.

```
npm install -g http-server
```

Installs the server globally and then navigate to a terminal/cmd prompt to the _site directory and run: 

```
http-server -p 8080
```

Now you can preview the site on `http://localhost:8080`

### Alternative method for previewing changes locally via Docker

Alternatively, you can run the site using the provided Dockerfile and a working and running Docker Desktop installation. To do this, run:

```
npm run docker:build
```

To generate an image named `ofqual-standards-patterns` with the tag `latest`

To then run this image, use:

```
npm run docker:run
```

To host the image at `http://localhost:8080`

If this port is not suitable, you may use:

```
docker run -p <PREFERRED_PORT>:80 ofqual-standards-patterns
```

To host the image at `http://localhost:<PREFERRED_PORT>`
