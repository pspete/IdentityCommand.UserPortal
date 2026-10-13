# .ExternalHelp IdentityCommand.UserPortal-help.xml
function Get-UPAssetSecret {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [Alias('id')]
        [String]$assetId,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(1, 3699)]
        [String]$reason,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [psobject]$workflowStatus
    )

    begin { }#begin

    process {

        if (($workflowStatus.require_reason -eq $true) -and (-not $PSBoundParameters.ContainsKey('reason'))) {
            Write-Error -Message "Asset '$assetId' requires a reason: specify -reason" -Category InvalidArgument -TargetObject $assetId
            return
        }

        $URI = "$(Resolve-RequestUrl)/api/assets/$assetId/secret"

        #The endpoint is a POST which takes an optional reason for the retrieval, recorded in the audit
        $body = [ordered]@{}

        if ($PSBoundParameters.ContainsKey('reason')) {
            $body['reason'] = $reason
        }

        #Send Request
        $result = Invoke-IDRestMethod -Uri $URI -Method POST -Body ($body | ConvertTo-Json -Depth 2)

        if ($null -ne $result) {

            $result

        }

    }#process

    end { }#end

}
