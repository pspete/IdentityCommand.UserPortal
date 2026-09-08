---
external help file: IdentityCommand.UserPortal-help.xml
Module Name: IdentityCommand.UserPortal
online version:
schema: 2.0.0
---

# Get-UPAssetSecret

## SYNOPSIS
Retrieves the secret of an asset

## SYNTAX

```
Get-UPAssetSecret [-assetId] <String> [[-reason] <String>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves the secret of an asset, by asset identifier, optionally recording a reason for the retrieval.

Asset identifiers come from `Get-UPAsset`, and pipe into this command.

## EXAMPLES

### Example 1
```
Get-UPAssetSecret -assetId 12_34
```

Retrieves the secret of the specified asset

### Example 2
```
Get-UPAssetSecret -assetId 12_34 -reason 'Investigating incident INC-1234'
```

Retrieves the secret of the specified asset, recording the reason for the retrieval

### Example 3
```
Get-UPAsset -favoritesOnly | Get-UPAssetSecret -reason 'Scheduled configuration audit'
```

Retrieves the secret of every asset marked as a favourite

## PARAMETERS

### -assetId
The identifier of the asset whose secret to retrieve.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -reason
The reason for retrieving the secret.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
