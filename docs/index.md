---
title: IdentityCommand.UserPortal
subtitle: PowerShell for Idira Access
hide_hero: true
---

<div class="has-text-centered mb-6">
  <img src="{{ '/UserPortal/media/images/IdentityCommand.UserPortal.png' | relative_url }}" alt="IdentityCommand.UserPortal" width="471">
</div>

**IdentityCommand.UserPortal** is a PowerShell module that provides a set of easy-to-use commands, allowing you to interact with the **Idira Access API** from within the PowerShell environment.

It builds on [IdentityCommand]({{ '/' | relative_url }}) for authentication - see [Getting Started]({{ '/UserPortal/getting-started/' | relative_url }}) to install and connect, and the [command reference]({{ '/UserPortal/commands/' | relative_url }}) for every command.

## Assets

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

## Asset Secrets

`Get-UPAssetSecret` retrieves the secret of an asset, optionally recording a reason for the retrieval:

```powershell
Get-UPAssetSecret -assetId 12_34

Get-UPAssetSecret -assetId 12_34 -reason 'Investigating incident INC-1234'
```

Asset identifiers pipe from `Get-UPAsset`:

```powershell
Get-UPAsset -favoritesOnly | Get-UPAssetSecret -reason 'Scheduled configuration audit'
```
