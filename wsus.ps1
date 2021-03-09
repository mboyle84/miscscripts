try {

$UpdateSession = New-Object -ComObject Microsoft.Update.Session
$UpdateSearcher = $UpdateSession.CreateupdateSearcher()
$Updates = @($UpdateSearcher.Search("IsHidden=0 and IsInstalled=0").Updates)
$Updates | Select-Object Title
}

catch {

Write-Host "Error Fetching Pending Updates"

}


$query = (Get-HotFix | Select-Object -Property HotfixID,Description,InstalledOn)[-1]
ConvertTo-Csv -InputObject $query -Delimiter "|" | Select-Object -Skip 2

