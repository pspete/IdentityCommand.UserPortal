# IdentityCommand.UserPortal

**IdentityCommand.UserPortal** is a PowerShell module that provides a set of easy-to-use commands, allowing you to interact with the **CyberArk Access API** from within the PowerShell environment.

| Main Branch              | CodeFactor                 | Coverage                     | PowerShell Gallery        | License                      |
| ------------------------ | -------------------------- | ---------------------------- | ------------------------- | ---------------------------- |
| [![build][]][build-site] | [![codefactor][]][cf-site] | [![codecov][]][codecov-link] | [![psgallery][]][ps-site] | [![license][]][license-link] |

[build]: https://github.com/pspete/IdentityCommand.UserPortal/actions/workflows/ci.yml/badge.svg?branch=main&event=push
[build-site]: https://github.com/pspete/IdentityCommand.UserPortal/actions/workflows/ci.yml?query=branch%3Amain
[psgallery]: https://img.shields.io/powershellgallery/v/IdentityCommand.UserPortal.svg
[ps-site]: https://www.powershellgallery.com/packages/IdentityCommand.UserPortal
[downloads]: https://img.shields.io/powershellgallery/dt/IdentityCommand.UserPortal.svg?color=blue
[cf-site]: https://www.codefactor.io/repository/github/pspete/IdentityCommand.UserPortal
[codefactor]: https://www.codefactor.io/repository/github/pspete/IdentityCommand.UserPortal/badge
[codecov]: https://codecov.io/gh/pspete/IdentityCommand.UserPortal/branch/main/graph/badge.svg
[codecov-link]: https://codecov.io/gh/pspete/IdentityCommand.UserPortal
[license]: https://img.shields.io/github/license/pspete/IdentityCommand.UserPortal.svg
[license-link]: https://github.com/pspete/IdentityCommand.UserPortal/blob/main/LICENSE

## Using the Module

The module requires authentication to the CyberArk Identity platform using the `IdentityCommand` module.

The `IdentityCommand` module must be installed and available in order to use `IdentityCommand.UserPortal`.

An overview of some of the features of the module are found in the below sections.

### Access API Authentication

The `Connect-UPTenant` command initialises the bearer token used for module operations against the Access API.

If an Identity session already exists (established with the `IdentityCommand` module's `New-IDSession` or `New-IDPlatformToken`), it is used as-is:

```powershell
# Resolve the Access API url automatically from the shared services subdomain
Connect-UPTenant -tenant_subdomain sometenant

# Or provide the Access API url directly
Connect-UPTenant -tenant_url https://sometenant.api.userportal.cyberark.cloud
```

Otherwise, provide a credential and `Connect-UPTenant` authenticates to CyberArk Identity for you - the Identity tenant url is discovered from the same subdomain / url:

```powershell
# Interactive user authentication (any MFA challenges are handled by IdentityCommand)
Connect-UPTenant -tenant_subdomain sometenant -Credential $Credential

# Non-interactive service user authentication via an OAuth platform token
Connect-UPTenant -tenant_subdomain sometenant -Credential $ServiceUserCredential -PlatformToken
```

### Assets

`Get-UPAsset` lists the assets available to the authenticated user, across the sources the Access space aggregates - infrastructure targets and Identity applications:

```powershell
# All available assets
Get-UPAsset

# Only the assets marked as favourites
Get-UPAsset -favoritesOnly

# Infrastructure assets accessed with zero standing privileges, matching a search
Get-UPAsset -accessMethod zsp -search 'address contains 10.0.0'

# The first 50 assets, sorted by username, descending
Get-UPAsset -sort username.desc -limit 50
```

The Access API queries several sources to answer each request. When it cannot reach them all it returns the assets it did find and reports a partial success; `Get-UPAsset` surfaces that as a warning, so a short list is not mistaken for a complete one.

### Asset Secrets

`Get-UPAssetSecret` retrieves the secret of an asset, optionally recording a reason for the retrieval:

```powershell
Get-UPAssetSecret -assetId 12_34

Get-UPAssetSecret -assetId 12_34 -reason 'Investigating incident INC-1234'
```

Asset identifiers pipe from `Get-UPAsset`:

```powershell
Get-UPAsset -favoritesOnly | Get-UPAssetSecret -reason 'Scheduled configuration audit'
```

## Module Commands

| Command             | Description                                        |
| ------------------- | -------------------------------------------------- |
| `Connect-UPTenant`  | Authenticate to the Access API                     |
| `Get-UPAsset`       | List the assets available to you                   |
| `Get-UPAssetSecret` | Retrieve the secret of an asset                    |
| `Get-UPModuleData`  | Get the module version & session configuration data |

## Installation

### Prerequisites

- Requires Powershell Core (recommended), or Windows PowerShell (version 5.1)
- A CyberArk Identity tenant with the Access space enabled
- An Account to Access CyberArk Identity

### Install Options

Users can install IdentityCommand.UserPortal from GitHub or the PowerShell Gallery.

Choose any of the following ways to download the module and install it:

#### Option 1: Install from PowerShell Gallery

This is the easiest and most popular way to install the module:

1. Open a PowerShell prompt

2. Run the following command:

```powershell
Install-Module -Name IdentityCommand.UserPortal -Scope CurrentUser
```

#### Option 2: Manual Install

The module files can be manually copied to one of your PowerShell module directories.

Use the following command to get the paths to your local PowerShell module folders:

```powershell

$env:PSModulePath.split(';')

```

The module files must be placed in one of the listed directories, in a folder called `IdentityCommand.UserPortal`.

More: [about_PSModulePath](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_psmodulepath)

The module files are available to download using a variety of methods:

##### PowerShell Gallery

- Download from the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/IdentityCommand.UserPortal/):
  - Run the PowerShell command `Save-Module -Name IdentityCommand.UserPortal -Path C:\temp`
  - Copy the `C:\temp\IdentityCommand.UserPortal` folder to your "Powershell Modules" directory of choice.

##### IdentityCommand.UserPortal Release

- [Download the latest GitHub release](https://github.com/pspete/IdentityCommand.UserPortal/releases/latest)
  - Unblock & Extract the archive
  - Rename the extracted `IdentityCommand.UserPortal-v#.#.#` folder to `IdentityCommand.UserPortal`
  - Copy the `IdentityCommand.UserPortal` folder to your "Powershell Modules" directory of choice.

##### IdentityCommand.UserPortal Branch

- [Download the `main` branch](https://github.com/pspete/IdentityCommand.UserPortal/archive/refs/heads/main.zip)
  - Unblock & Extract the archive
  - Copy the `IdentityCommand.UserPortal` (`\<Archive Root>\IdentityCommand.UserPortal-main\IdentityCommand.UserPortal`) folder to your "Powershell Modules" directory of choice.

#### Verification

Validate Install:

```powershell

Get-Module -ListAvailable IdentityCommand.UserPortal

```

Import the module:

```powershell

Import-Module IdentityCommand.UserPortal

```

List Module Commands:

```powershell

Get-Command -Module IdentityCommand.UserPortal

```

Get detailed information on specific commands:

```powershell

Get-Help Get-UPAsset -Full

```

## Sponsorship

Please support continued development; consider sponsoring <a href="https://github.com/sponsors/pspete"> @pspete on GitHub Sponsors</a>

## Changelog

All notable changes to this project will be documented in the [Changelog](CHANGELOG.md)

## Author

- **Pete Maan** - [pspete](https://github.com/pspete)

## License

This project is [licensed under the MIT License](LICENSE.md).

## Contributing

Any and all contributions to this project are appreciated.

See the [CONTRIBUTING.md](CONTRIBUTING.md) for a few more details.

## Support

_IdentityCommand.UserPortal_ is neither developed nor supported by CyberArk; any official support channels offered by the vendor are not appropriate for seeking help with the _IdentityCommand.UserPortal_ module.

Help and support should be sought by [opening an issue][new-issue].

[new-issue]: https://github.com/pspete/IdentityCommand.UserPortal/issues/new

Priority support could be considered for <a href="https://github.com/sponsors/pspete">sponsors of @pspete</a>, <a href="mailto:pspete@pspete.dev">contact us</a> to discuss options.
