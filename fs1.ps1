Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser

Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force

Connect-AzAccount

$Vault = (Get-AzKeyVaultSecret -VaultName "sqlkeyvault9" -Name "FileShare").SecretValue 

$connectTestResult = Test-NetConnection -ComputerName storagemount7.file.core.windows.net -Port 445
if ($connectTestResult.TcpTestSucceeded) {
    cmd.exe /C "cmdkey /generic:`"storagemount7.file.core.windows.net`" /user:`"localhost\storagemount7`" /pass:`"$Vault`""
    # Mount the drive
    net use Y: \\storagemount7.file.core.windows.net\7777
} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}



