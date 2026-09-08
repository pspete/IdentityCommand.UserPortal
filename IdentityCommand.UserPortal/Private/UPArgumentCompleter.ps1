#The completer helper functions live in IdentityCommand's Private folder, which the psm1 loads
#into this module's scope.

#region Registration

#Assets carry an address for infrastructure and a name for Identity applications, so label with
#whichever is populated rather than picking one and showing blanks for half the estate.
Register-ArgumentCompleter -ParameterName 'assetId' -ScriptBlock (
    Get-ArgumentCompleter -RetrievalCommand 'Get-UPAsset' -ValueProperty 'assetId' -LabelProperty 'address'
) -CommandName 'Get-UPAssetSecret'

#endregion Registration
