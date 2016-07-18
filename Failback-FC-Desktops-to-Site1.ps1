Import-Module c:\Users\jason\desktop\Simplivity.psm1

#Connect to OmniStack Virtual Controller
$OVC = Read-Host "Enter the Management IP Address for a local OmniStack Virtual Controller"
Connect-OmniStack -Server $OVC -IgnoreCertReqs

Connect-VIServer 10.144.199.159

$Site1FCs = Get-OmniStackVM | where {$_.Name -match "fullclone1" -and $_.State -eq "ALIVE"}

foreach ($Site1FC in $Site1FCs) {

	$HypervisorVM = Get-VM -Name $Site1FC.Name

	if ($HypervisorVM.PowerState -eq "PoweredOn") {
	$HypervisorVM | Stop-VM -Confirm:$false
	}

$Site1FC | Move-OmniStackVM -DestinationDatastore DC1_Datastore0

}