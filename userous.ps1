$OUpath = 'OU=company,OU=Employees,DC=domain,DC=com'
$ExportPath = 'c:\Users.csv'
Get-ADUser -Filter * -SearchBase $OUpath | Select-object DistinguishedName,Name,UserPrincipalName | Export-Csv -NoType $ExportPath

Get-ADUser -Filter * -SearchBase $OUpath -Property Enabled | Select-object DistinguishedName,Name,UserPrincipalName,Enabled | Export-Csv -NoType $ExportPath

