---
layout: pattern
order: 13
title: PHP Static Analysis and Code Quality with PHPStan and PHPCS
date: 2026-02-23
tags:
  - Code quality
  - Security
  - Development
  - PHP
related:
  sections:
    - title: Related Standards
      items:
        - text: Code Quality
          href: /standards/code-quality/
---

<!-- Pattern description -->

<!-- 

# Notes on line breaks

Please see https://x-govuk.github.io/govuk-eleventy-plugin/markdown/#line-breaks for notes on usage of line breaks.

# Notes on linking to headings within a page

Heading tags are automatically assigned an id, converting spaces to `kebab-case` and applying URL encoding. If you want to link to a specific heading, you can obtain the URL encoded link by running the site locally, inspecting the appropriate <h3> element in the browser's developer tools and copying the value from the 'id' attribute.
-->

---

## Introduction

- PHPStan is a static analysis tool that finds bugs in PHP code before execution, focusing on type safety and logical errors
- PHP CodeSniffer (PHPCS) is a static analysis tool that detects coding standard violations, ensuring consistent code style and adherence to best practices
- Together, PHPStan and PHPCS provide comprehensive coverage of code quality, helping identify issues early in the development lifecycle
- Both tools can be integrated into development workflows and CI/CD pipelines to maintain quality standards across the codebase

---

## Solution

### Development

#### Local Setup

- Developers should install PHPStan and PHPCS as development dependencies in their projects using Composer:
  - `composer require --dev phpstan/phpstan`
  - `composer require --dev squizlabs/php_codesniffer`
- Developers should run both tools regularly during development, ideally before committing code

#### PHPStan Configuration

- A `phpstan.neon` or `phpstan.neon.dist` configuration file should be created at the project root
- Key configuration considerations:
  - Set the appropriate `level` (0-9) based on project requirements; higher levels enforce stricter type checking
  - Define `paths` to specify which directories PHPStan should analyze
  - Configure `excludePaths` to ignore vendor directories and generated files
  - Consider using base configuration files for common rule sets
- The configuration should be version controlled so all developers use the same standards

#### PHPCS Configuration

- A `.phpcs.xml` or `phpcs.xml` configuration file should be created at the project root
- Key configuration considerations:
  - Select an appropriate standard (PSR-12, PSR-2, or custom)
  - Define `<file>` or `<exclude>` patterns to specify directories to check
  - Configure rule severity levels and exclude specific sniffs as needed
  - Enable autoloader if checking bootstrap files
- The configuration should be version controlled for consistency

#### Running Tools Locally

- Pre-commit hooks should be considered to run both tools before committing:
  - Use tools like `husky` or `git-hooks` to automatically run analysis
  - Blocks commits if PHPStan or PHPCS violations are detected
- Developers should fix issues locally before pushing code
- Commands for manual execution:
  - PHPStan: `vendor/bin/phpstan analyse`
  - PHPCS: `vendor/bin/phpcs`
  - PHPCS with auto-fix: `vendor/bin/phpcbf` (PHP Code Beautifier and Fixer)

### Pipeline Integration

#### Gating Builds

- Both PHPStan and PHPCS checks should be added to CI/CD pipelines
- It is recommended that these checks are "gated" to block builds when violations are detected
  - PHPStan should block builds on any errors (level-specific findings)
  - PHPCS should block builds on errors; warnings may be optional based on team preference
- The conditions and severity levels for blocking should be documented and agreed upon by the development team

#### Reporting

- Pipeline configurations should generate reports for analysis:
  - Checkstyle XML format for PHPCS (`--report=checkstyle`)
  - JSON format for PHPStan (`--format json`)
- Reports should be published to pipeline results for visibility
- Trends should be tracked over time to monitor code quality improvements

#### Performance

- Cache analysis results where possible to improve pipeline performance
- Run PHPStan and PHPCS in parallel with other quality checks if the pipeline supports it
- Consider running quick checks (PHPCS) before deeper analysis (PHPStan) to fail fast

---

## Considerations

### Version Management

- PHPStan and PHPCS versions should be pinned in `composer.json` to ensure consistency across environments
- Major version upgrades may require configuration adjustments and should be tested before deployment
- Regular updates should be scheduled to receive security patches and new features

### Rule Customization

- Default configurations may be too strict or too lenient for specific projects
- Teams should customize rules based on their coding standards and project requirements
- Custom sniffs can be created for PHPCS to enforce project-specific patterns
- Community-contributed PHPStan extensions (e.g., `phpstan/phpstan-symfony`) can enhance analysis for specific frameworks

### Type Declarations

- PHPStan works best when the codebase uses type declarations
- Incremental adoption of strict types is recommended when retrofitting PHPStan to existing projects
- Start with a lower PHPStan level and gradually increase strictness as the codebase improves

### False Positives

- Both tools may occasionally report false positives
- Use inline comments (`// @phpstan-ignore-line`, `// phpcs:ignore`) judiciously to suppress specific warnings
- Document why suppressions are necessary to avoid hiding real issues

---

## Examples

### Sample phpstan.neon Configuration

```neon
includes:
  - phar://phpstan.phar/conf/bleedingEdge.neon

parameters:
  level: 6
  paths:
    - src
    - tests
  excludePaths:
    - vendor
    - var
  ignoreErrors:
    - '#Call to an undefined method#'
```

### Sample phpcs.xml Configuration

```xml
<?xml version="1.0" encoding="UTF-8"?>
<ruleset name="Project Standard">
    <description>PSR-12 with custom rules</description>

    <file>src</file>
    <file>tests</file>

    <exclude-pattern>vendor/</exclude-pattern>

    <rule ref="PSR12"/>

    <rule ref="Generic.Strings.UnnecessaryStringConcat"/>
    <rule ref="Generic.CodeAnalysis.UnusedFunctionParameter"/>
</ruleset>
```

### Pipeline Integration Example (YAML)

```yaml
- name: Run PHPStan
  run: vendor/bin/phpstan analyse --format json > phpstan-report.json

- name: Run PHPCS
  run: vendor/bin/phpcs --report=checkstyle --report-file=phpcs-report.xml

- name: Publish Reports
  if: always()
  uses: publish-quality-reports@v1
  with:
    phpstan-report: phpstan-report.json
    phpcs-report: phpcs-report.xml
```

---
