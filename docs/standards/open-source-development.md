---
layout: standard
order: 1
title: Open Source Development Security
date: 2025-11-20 
id: OFQ-00000 # Set unique ID for standard
tags:
  - Digital
  - Security
  - Data
---

When contributing to or managing open-source projects, it's crucial to follow security best practices to protect both the project and its users.

---

## Requirement(s)

- [Use Strong Authentication and Controls](#)
- [Keep Dependencies Updated](#)
- [Conduct Code Reviews and Protect Pull Requests](#)
- [Follow Secure Coding Practices](#)
- [Ensure License Compliance](#)
- [Conduct Regular Security Audits](#)


### Use Strong Authentication and Controls
- Multi-factor authentication (MFA) MUST be used for anyone who is a member of the Ofqual Github organisation
- Use SSH for repository access instead of HTTPS
- Only Infrastructure engineers may have admin permissions for the Ofqual Github
- Members who are no longer involved with Ofqual development MUST be removed

### Keep Dependencies Updated
- Regularly update dependencies to their latest versions. If you see an out of date dependency during a ticket, update the dependency.
- Use tools like Dependabot or Snyk to automate dependency updates and vulnerability checks.
- Enable Private vulnerability reporting, and alerts for vulnerabilities that affect dependencies

### Conduct Code Reviews and Protect Pull Requests
- Code reviews are required for all changes.
- Branch protection MUST be active for all repositories

### Follow Secure Coding Practices
- Use static code analysis tools to identify potential security issues.
- A gitignore MUST be set up so that sensitive files cannot be checked in
- Do not publish details of our exact testing or production environment. For example, in appsettings files, do not include URLs for test environments
- Secret scanning and secret push protection MUST be enabled, where available 

### Ensure License Compliance
- All code and dependencies MUST comply with open-source licenses.
- Use tools like FOSSA or Black Duck to manage license compliance.
- An appropriate license file (by default, MIT) MUST be held within the repository

### Conduct Regular Security Audits
- Conduct regular security audits of your codebase and infrastructure.
- Engage with security experts to perform thorough assessments.

---
