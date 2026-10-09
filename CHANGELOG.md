# Change Log

All notable changes to this project will be documented in this file.

## Unreleased

### Changed

- CI caches the PowerShell modules it installs, so dependency installs skip the PowerShell Gallery on a cache hit.

## [0.1.0] - 2026-10-07

### Added

- Initial release of `IdentityCommand.UserPortal`, wrapping the CyberArk Access API.
- `Connect-UPTenant`: authenticate to the Access API, resolving the service url from a shared
  services subdomain via platform discovery, or from a url supplied directly. An existing
  `IdentityCommand` session is used as-is; supplying `-Credential` (optionally with
  `-PlatformToken`) or `-SAMLResponse` authenticates to CyberArk Identity first.
- `Get-UPAsset`: list the assets available to the authenticated user, with `-accessMethod`,
  `-favoritesOnly`, `-recentsOnly`, `-limit`, `-search` and `-sort`. A partial success reported by
  the service is surfaced as a warning.
- `Get-UPAssetSecret`: retrieve the secret of an asset, optionally recording a `-reason`. Asset
  identifiers pipe from `Get-UPAsset`.
- `Get-UPModuleData`: get the module version and session configuration data.

