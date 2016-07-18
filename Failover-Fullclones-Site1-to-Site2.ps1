Import-Module c:\Users\jason\desktop\Simplivity.psm1

#Connect to OmniStack Virtual Controller
$OVC = Read-Host "Enter the Management IP Address for a local OmniStack Virtual Controller"
Connect-OmniStack -Server $OVC -IgnoreCertReqs

$Site1FCs = "fullclone1-1","fullclone1-2","fullclone1-3","fullclone1-4","fullclone1-5"

foreach ($Site1FC in $Site1FCs) {
	$backupstosort = @()
	$Backups = Get-OmniStackBackups | where {$_.VirtualMachineName -eq $Site1FC}
	
		foreach ($Backup in $backups) {
		$Backup1 = $Backup.Name
		$backupstosort += $Backup1
		}
	$backupstosort = $backupstosort | Sort-Object -Descending
	$backupname = $backupstosort[0]
	
	Write-Host "The latest backup for $Site1FC is " $Backupname
	
	Restore-OmniStackVM -BackupName $backup1 -Name $Site1FC -NewVMName $Site1FC -DestinationDatastore DC2_Datastore0 -RestoreOriginal:$false
}