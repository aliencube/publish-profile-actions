Param(
    [string]
    [Parameter(Mandatory=$true)]
    $ResourceGroupName,

    [string]
    [Parameter(Mandatory=$true)]
    $AppName
)

$clientId = ($env:AZURE_CREDENTIALS | ConvertFrom-Json).clientId
$clientSecret = ($env:AZURE_CREDENTIALS | ConvertFrom-Json).clientSecret | ConvertTo-SecureString -AsPlainText -Force
$tenantId = ($env:AZURE_CREDENTIALS | ConvertFrom-Json).tenantId

$credentials = New-Object System.Management.Automation.PSCredential($clientId, $clientSecret)

$connected = Connect-AzAccount -ServicePrincipal -Credential $credentials -Tenant $tenantId

$profile = Get-AzWebAppPublishingProfile `
    -ResourceGroupName $ResourceGroupName `
    -Name $AppName

Write-Output "::set-output name=profile::'$profile'"

Remove-Variable profile
Remove-Variable connected
Remove-Variable credentials
Remove-Variable tenantId
Remove-Variable clientSecret
Remove-Variable clientId
