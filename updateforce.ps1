

Install-Module PSWindowsUpdate

 

#Defining Variables $nodes = ComputerNames $logfile = Logfile location
$nodes = "Computername"
$logfile = "\\server\Share\Logs\$nodes-$(Get-Date -f yyyy-mm-dd)-msupdated.log"

 


#Runs all windows update automatically rebooting and creates a log file @ $logfile
Invoke-WUJob -ComputerName $nodes -Script {Import-Module PSWindowsUpdate;`
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot}`
-RunNow -Confirm:$false | Out-File $logfile -Force

 
