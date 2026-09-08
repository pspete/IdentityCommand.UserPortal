BeforeAll {
    $Script:UPModuleName = 'IdentityCommand.UserPortal'

    #Get Current Directory
    $Here = Split-Path -Parent $PSCommandPath

    #Resolve Path to Module Directory
    $ModulePath = Resolve-Path "$Here\..\$Script:UPModuleName"

    #Define Path to Module Manifest
    $ManifestPath = Join-Path "$ModulePath" "$Script:UPModuleName.psd1"

    if ( -not (Get-Module -Name $Script:UPModuleName -All)) {

        Import-Module -Name "$ManifestPath" -ArgumentList $true -Force -ErrorAction Stop

    }
}

Describe 'Get-UPAssetSecret' {

    BeforeEach {

        Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:UPModuleName -MockWith {
            [pscustomobject]@{ 'assetId' = '12_34'; 'secret' = 'SomeSecretValue' }
        }

        InModuleScope -ModuleName $Script:UPModuleName {
            $ISPSSSession = [ordered]@{
                tenant_url = 'https://somedomain.api.userportal.cyberark.cloud'
                User       = $null
                TenantId   = 'SomeTenant'
                SessionId  = 'SomeSession'
                WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            }
            New-Variable -Name ISPSSSession -Value $ISPSSSession -Scope Script -Force
        }

        $Script:response = Get-UPAssetSecret -assetId '12_34'
    }

    Context 'Request' {

        It 'sends request' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:UPModuleName -Times 1 -Exactly -Scope It
        }

        It 'sends request to expected endpoint' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:UPModuleName -ParameterFilter {
                $URI -eq 'https://somedomain.api.userportal.cyberark.cloud/api/assets/12_34/secret'
            } -Times 1 -Exactly -Scope It
        }

        It 'uses expected method' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:UPModuleName -ParameterFilter {
                $Method -eq 'POST'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends an empty body when no reason is given' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:UPModuleName -ParameterFilter {
                ($Body | ConvertFrom-Json).PSObject.Properties.Name.Count -eq 0
            } -Times 1 -Exactly -Scope It
        }

        It 'sends the reason in the request body' {
            $null = Get-UPAssetSecret -assetId '12_34' -reason 'SomeReason'
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:UPModuleName -ParameterFilter {
                ($Body | ConvertFrom-Json).reason -eq 'SomeReason'
            } -Times 1 -Exactly -Scope It
        }

        It 'accepts the asset id from the pipeline by property name' {
            [pscustomobject]@{ assetId = '56_78' } | Get-UPAssetSecret
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:UPModuleName -ParameterFilter {
                $URI -eq 'https://somedomain.api.userportal.cyberark.cloud/api/assets/56_78/secret'
            } -Times 1 -Exactly -Scope It
        }
    }

    Context 'Response' {

        It 'provides output' {
            $Script:response | Should -Not -BeNullOrEmpty
        }

        It 'outputs the secret' {
            $Script:response.secret | Should -Be 'SomeSecretValue'
        }
    }
}
