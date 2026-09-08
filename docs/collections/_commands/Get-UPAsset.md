---
external help file: IdentityCommand.UserPortal-help.xml
Module Name: IdentityCommand.UserPortal
online version:
schema: 2.0.0
---

# Get-UPAsset

## SYNOPSIS
Lists the assets available to you in the Access space

## SYNTAX

```
Get-UPAsset [[-accessMethod] <String>] [-favoritesOnly] [-recentsOnly] [[-limit] <Int32>] [[-search] <String>]
 [[-sort] <String>] [<CommonParameters>]
```

## DESCRIPTION
Lists all assets available to the authenticated user across the sources the Access space aggregates - infrastructure targets and Identity applications.

When the service cannot reach every source it returns the assets it did find and reports a partial success, which this command surfaces as a warning so a short list is not mistaken for a complete one.

## EXAMPLES

### Example 1
```
Get-UPAsset
```

Lists all assets available to you

### Example 2
```
Get-UPAsset -favoritesOnly
```

Lists only the assets you have marked as favourites

### Example 3
```
Get-UPAsset -accessMethod zsp -search 'address contains 10.0.0'
```

Lists assets accessed with zero standing privileges whose address contains 10.0.0

### Example 4
```
Get-UPAsset -sort username.desc -limit 50
```

Lists up to 50 assets, sorted by username in descending order

## PARAMETERS

### -accessMethod
Return only infrastructure assets using the specified access method - `vaulted` for vaulted credentials, `zsp` for zero standing privileges.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: vaulted, zsp

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -favoritesOnly
Return only the assets marked as favourites.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -recentsOnly
Return only recently used assets.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -limit
The maximum number of assets to return, between 1 and 1000. The service returns 1000 when not specified.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -search
Search assets with the contains operator, against the `address`, `platformId` or `username` field, for example `address contains 1.2.3.4`.

The reserved field name `all` applies the search across every supported field, for example `all contains somevalue`.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -sort
Sort the results by `address`, `platformId` or `username`, ascending or descending, for example `address.asc` or `username.desc`. The service sorts ascending when no direction is given.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
