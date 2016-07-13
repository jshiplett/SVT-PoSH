#Create Datastores for Desktop Deployment
[Int64]$TBinBytes = 1099511627776

Import-Module c:\Users\jason\desktop\Simplivity.psm1

#Connect to OmniStack Virtual Controller
$OVC = Read-Host "Enter the Management IP Address for a local OmniStack Virtual Controller"
Connect-OmniStack -Server $OVC -IgnoreCertReqs

#Decide which OmniStack Cluster to add datastores to
$Cluster = Read-Host "Enter the name of the OmniStack Cluster"

#Get the size of the datastores
[int64]$Size = Read-Host "How large (in TB) should the new datastores be?"
[Int64]$SizeInBytes = $Size*$TBinBytes

#Display Backup Policies
$Policies = Get-OmniStackBackupPolicy
$Policies.Name

#Get the default backup policy
$BackupPolicy = Read-Host "Which backup policy should be set as default for the new datatores?"

#Compute the number of datastores to add (corresponding to number of hosts)
$HostsToCount = Get-OmniStackClusters -Name $Cluster
$NumHosts = $HostsToCount.Members.Count

for ($i = 0; $i -lt $NumHosts; $i++) {
	New-OmniStackDatastore -ClusterName $Cluster -Name $Cluster"_Datastore"$i -Size 1099511627776 -PolicyName NoBackups	
}