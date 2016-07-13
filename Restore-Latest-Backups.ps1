Import-Module c:\Users\jason\desktop\Simplivity.psm1

#Connect to OmniStack Virtual Controller
$OVC = Read-Host "Enter the Management IP Address for a local OmniStack Virtual Controller"
Connect-OmniStack -Server $OVC -IgnoreCertReqs

$ManagementVMs = "vCenter-DT","Composer","ConnServ1","ConnServ2","SecServ1","SecServ2"

foreach ($ManagementVM in $ManagementVMs) {
	$backupstosort = @()
	$Backups = Get-OmniStackVMBackups -Name $ManagementVM
	
		foreach ($Backup in $backups) {
		$Backup1 = $Backup.Name
		$backupstosort += $Backup1
		}
	$backupstosort = $backupstosort | Sort-Object -Descending
	$backupname = $backupstosort[0]
	
	Restore-OmniStackVM -Name $ManagementVM -NewVMName $ManagementVM"-Restored-"$backupname -DestinationDatastore Desktops_Datastore0 -BackupName $backupname -RestoreOriginal:$false 
	
}