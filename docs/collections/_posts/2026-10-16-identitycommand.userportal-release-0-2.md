---
title: "IdentityCommand.UserPortal Release 0.2"
date: 2026-10-16 00:00:00
version: 0.2.0
tags:
  - Release Notes
  - Get-UPAssetSecret
---

## [0.2.0]

### Added

- Commands find the Access API service url from the `IdentityCommand` session on first use, so no connection step is needed after `New-IDSession` or `New-IDPlatformToken`. Commands follow a later `New-IDSession` or `New-IDPlatformToken`, and fail after `Close-IDSession` until you authenticate again.

### Changed

- Requires `IdentityCommand` 1.0.1.
- A request refused with 401 because the session token has expired reports `Session expired at <time>:
  authenticate again with New-IDSession or New-IDPlatformToken`. Previously, it reported `Unauthorized. Unauthorized.`.
- CI caches the PowerShell modules it installs, so dependency installs skip the PowerShell Gallery on a cache hit.

### Fixed

- `401 Unauthorized` on every request: the service url resolves from the platform discovery `bootstrap` url.
- `Get-UPAssetSecret` writes an error when a piped asset requires a reason and `-reason` is not given.

### Removed

- `Connect-UPTenant`. Authenticate with `New-IDSession` or `New-IDPlatformToken` from `IdentityCommand` instead.
