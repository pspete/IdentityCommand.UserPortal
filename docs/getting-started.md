---
title: Getting Started
subtitle: Install IdentityCommand.UserPortal and connect to Access
---

## Prerequisites

- Requires Powershell Core (recommended), or Windows PowerShell (version 5.1)
- An Idira Identity tenant with the Access space enabled
- An Account to Access Idira Identity
- The `IdentityCommand` module.

## Install Options

Install from the PowerShell Gallery:

```powershell
Install-Module -Name IdentityCommand.UserPortal -Scope CurrentUser
```

Or download the [latest release](https://github.com/pspete/IdentityCommand.UserPortal/releases), unblock and extract the archive, and copy the `IdentityCommand.UserPortal` folder into a path listed in `$env:PSModulePath`.

## Authentication

The module requires authentication to the Idira Identity platform using the `IdentityCommand` module.

The `IdentityCommand` module must be installed and available in order to use `IdentityCommand.UserPortal`.

The `Connect-UPTenant` command initialises the bearer token used for module operations against the Access API.

If an Identity session already exists (established with the `IdentityCommand` module's `New-IDSession` or `New-IDPlatformToken`), it is used as-is:

```powershell
# Resolve the Access API url automatically from the shared services subdomain
Connect-UPTenant -tenant_subdomain sometenant

# Or provide the Access API url directly
Connect-UPTenant -tenant_url https://sometenant.api.userportal.cyberark.cloud
```

Otherwise, provide a credential and `Connect-UPTenant` authenticates to Idira Identity for you - the Identity tenant url is discovered from the same subdomain / url:

```powershell
# Interactive user authentication (any MFA challenges are handled by IdentityCommand)
Connect-UPTenant -tenant_subdomain sometenant -Credential $Credential

# Non-interactive service user authentication via an OAuth platform token
Connect-UPTenant -tenant_subdomain sometenant -Credential $ServiceUserCredential -PlatformToken
```
