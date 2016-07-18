Import-Module c:\Users\jason\desktop\Simplivity.psm1

#Connect to OmniStack Virtual Controller
$OVC = Read-Host "Enter the Management IP Address for a local OmniStack Virtual Controller"
Connect-OmniStack -Server $OVC -IgnoreCertReqs

$Site1FCs = Get-OmniStackVM | where {$_.Name -match "fullclone1" -and $_.State -eq "ALIVE"}

foreach ($Site1FC in $Site1FCs) {
$Site1FC | Set-OmniStackVMBackupPolicy -PolicyName "Backup Desktops Site 1 to Site 2"
}

$Site2FCs = Get-OmniStackVM | where {$_.Name -match "fullclone2" -and $_.State -eq "ALIVE"}

foreach ($Site2FC in $Site2FCs) {
$Site2FC | Set-OmniStackVMBackupPolicy -PolicyName "Backup Desktops Site 2 to Site 1"
}