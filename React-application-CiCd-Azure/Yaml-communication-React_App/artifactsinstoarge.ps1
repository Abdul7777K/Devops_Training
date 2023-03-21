
# Load Azure PowerShell module if not already loaded
if (!(Get-Module -Name Az.Storage)) {
    Import-Module -Name Az.Storage
}
# Set the Azure AD tenant and subscription ID
$tenantId = "3e71393e-4c55-42a7-8787-cddc48ffe5ed"
$subscriptionId = "c57bebcf-1810-4890-8f90-f88b6eff926d"

# Set the service principal client ID and secret
$clientId = "c15827f0-473c-4167-9147-e607daf21342"
$clientSecret = "CyK8Q~4aQkZDTTO8rg1tlbgWamZIYBXR1WTsWaEG"

# Authenticate to Azure using the service principal
$securePassword = ConvertTo-SecureString $clientSecret -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($clientId, $securePassword)

# Connect to Azure
Connect-AzAccount -ServicePrincipal -Tenant $tenantId -Subscription $subscriptionId -Credential $credential

# Set variables for Azure Blob Storage account
$storageAccountName = "storageartifact"
$containerName = "buildartifacts"
$storageAccountKey = "o/rQ9WHsLlSMGJLBzFR01ELkpR/W18q35o8hWYcoGlXhEp90MJKokIw6+YreZXZhFY9YD980uAH/+AStdSigLg=="
# Create context for Azure Blob Storage
$context = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey

# Set local path of directory containing files to upload
$localFolderPath = "D:\a\1\a\"

# Get list of files in the directory
$fileList = Get-ChildItem -Path $localFolderPath -File

# Loop through files and upload each file to Azure Blob Storage
foreach ($file in $fileList) {
    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $fileName = $file.Name
    $blobName = $timestamp + "-" + $fileName

    Set-AzStorageBlobContent -Container $containerName -Context $context -File $file.FullName -Blob $blobName
}
