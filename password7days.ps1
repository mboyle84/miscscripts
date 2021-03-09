$PasswordExpirationThreshold = 7
$Today = Get-Date
$Users = Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False} –Properties * | Where-Object { $_.PasswordLastSet -and !$_.PasswordExpired }
$ExpiringUsers = [System.Collections.ArrayList]@()
foreach ($User in $Users) {
$UserPwdExpireDate = $User.PasswordLastSet.AddDays($MaxPasswordAge)
$DaysUntilExpire = ($Today -$UserPwdExpireDate).Days
$FirstName = $User.GivenName
$LastName = $User.Surname
if ($DaysUntilExpire -le $PasswordExpirationThreshold) {
Write-Output "The user $($User.samAccountName)'s password will expire in $DaysUntilExpire days on $UserPwdExpireDate with e-mail of $($User.EmailAddress) "
}}





get-aduser -filter * -properties passwordlastset, passwordneverexpires |ft Name, passwordlastset, Passwordneverexpires

