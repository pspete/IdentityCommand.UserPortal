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

Describe 'Get-UPAsset' {

    BeforeEach {

        Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:UPModuleName -MockWith {
            [pscustomobject]@{
                'diagnostics' = [pscustomobject]@{ status = 'success' }
                'assets'      = @([pscustomobject]@{ assetId = '12_34'; address = '10.0.0.1' })
                'size'        = 1
            }
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

        $Script:response = Get-UPAsset
    }

    Context 'Request' {

        It 'sends request' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:UPModuleName -Times 1 -Exactly -Scope It
        }

        It 'sends request to expected endpoint' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:UPModuleName -ParameterFilter {
                $URI -eq 'https://somedomain.api.userportal.cyberark.cloud/api/assets'
            } -Times 1 -Exactly -Scope It
        }

        It 'uses expected method' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:UPModuleName -ParameterFilter {
                $Method -eq 'GET'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends request with no body' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:UPModuleName -ParameterFilter {
                $null -eq $Body
            } -Times 1 -Exactly -Scope It
        }

        It 'sends request with expected query string' {
            $null = Get-UPAsset -accessMethod zsp -limit 50 -search 'all contains prod' -sort 'address.asc'
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:UPModuleName -ParameterFilter {
                ($URI -like 'https://somedomain.api.userportal.cyberark.cloud/api/assets`?*') -and
                ($URI -match 'accessMethod=zsp') -and
                ($URI -match 'limit=50') -and
                ($URI -match 'sort=address.asc')
            } -Times 1 -Exactly -Scope It
        }

        It 'sends switch parameters as their boolean value' {
            $null = Get-UPAsset -favoritesOnly -recentsOnly
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:UPModuleName -ParameterFilter {
                ($URI -match 'favoritesOnly=True') -and ($URI -match 'recentsOnly=True')
            } -Times 1 -Exactly -Scope It
        }
    }

    Context 'Response' {

        It 'provides output' {
            $Script:response | Should -Not -BeNullOrEmpty
        }

        It 'outputs the assets of the response' {
            $Script:response.assetId | Should -Be '12_34'
        }

        It 'warns when the service reports an incomplete result' {
            Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:UPModuleName -MockWith {
                [pscustomobject]@{
                    'diagnostics' = [pscustomobject]@{ status = 'partial_success' }
                    'assets'      = @([pscustomobject]@{ assetId = '12_34' })
                }
            }
            $null = Get-UPAsset -WarningVariable Warned -WarningAction SilentlyContinue
            $Warned | Should -Not -BeNullOrEmpty
        }

        It 'does not warn when the service reports success' {
            $null = Get-UPAsset -WarningVariable Warned -WarningAction SilentlyContinue
            $Warned | Should -BeNullOrEmpty
        }
    }
}
