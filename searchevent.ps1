$ErrorActionPreference= 'silentlycontinue'
Get-WinEvent –ListLog * | foreach-object {Get-EventLog -logname $_.LogName | where {$_.message -match 'Grace Period'}}
