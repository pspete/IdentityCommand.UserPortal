# .ExternalHelp IdentityCommand.UserPortal-help.xml
function Get-UPAsset {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('vaulted', 'zsp')]
        [String]$accessMethod,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [switch]$favoritesOnly,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [switch]$recentsOnly,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateRange(1, 1000)]
        [int]$limit,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [String]$search,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [String]$sort
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/assets"

        $boundparameters = $PSBoundParameters | Get-Parameter

        #Switches must travel as the true/false the API expects, not as the switch object
        foreach ($Switch in 'favoritesOnly', 'recentsOnly') {
            if ($boundparameters.ContainsKey($Switch)) {
                $boundparameters[$Switch] = $PSBoundParameters[$Switch].IsPresent
            }
        }

        $URI = Add-QueryString -URI $URI -Parameter $boundparameters

        #Send Request
        $result = Invoke-IDRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {

            #The API reports partial_success when it could not reach every source, and returns the
            #assets it did find - surface that rather than quietly handing back a short list.
            if (($null -ne $result.diagnostics) -and ($result.diagnostics.status -ne 'success')) {

                Write-Warning "Asset retrieval reported status '$($result.diagnostics.status)': the list may be incomplete"

            }

            $result.assets

        }

    }#process

    end { }#end

}
