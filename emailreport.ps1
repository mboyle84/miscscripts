#written by: Mike
#Contact: 
#
#Description: process for transfer weekly reports to people
#
#error handling and logging
#Set-StrictMode -Version latest
$Error.clear()
$Error
$ErrorActionPreference = "Stop"
#setting variables and loading configuration
$yesterday =  get-date -date $(get-date).adddays(-1) -format yyyy-MM-dd
$thedaybefore =  get-date -date $(get-date).adddays(-7) -format yyyy-MM-dd
$mailbox = 'princilple'
$email= 'test@blah.com'
$username = 'username'
$smtpserver = 'mail'
$domain = 'testing.local'
$intRec =0





try {


Write-Output "Gathering credentials and loading into memory"
    #to create password run command with same users that userpowershell script runs as to create encrypted string. 
    #read-host -assecurestring | convertfrom-securestring | out-file  C:\credentials\pwd.txt
 #password for
    $password2 = cat C:\credentials\pwd.txt | convertto-securestring
    $Ptr2 = [System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($password2)
    $Decryptpassword2 = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($Ptr2)
    [System.Runtime.InteropServices.Marshal]::ZeroFreeCoTaskMemUnicode($Ptr2)
    #
$password=$Decryptpassword2|ConvertTo-SecureString -AsPlainText -Force
$UserCredential = New-Object System.Management.Automation.PSCredential $username, $password



Get-MessageTrackingLog -Server serverbox.local -Start $thedaybefore -End $yesterday -Recipients $email |  ForEach {  
          
        # Received E-mails  
        If ($_.EventId -eq "DELIVER") { 
            $intRec += $_.RecipientCount 
           
        } 
    }  
  
  
  
Write-Output "E-mail to $email from $thedaybefore to $yesterday was $intRec" 
$body = "E-mail to $email from $thedaybefore to $yesterday was $intRec" 

[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }
Send-MailMessage -From 'administrator@testing.com' -To 'user1@testing.com', 'user2@testing.com' -Bcc 'm@testing.com' -Subject 'Mail Report' -Body $body -SmtpServer $smtpserver
# -Credential $UserCredential -UseSsl


} catch {
    # !! This shouldn't be necessary, but if we left $ErrorActionPreference
    # !! 'Stop' in effect, the use of Write-Error itself would cause an 
    # !! - uncaught - terminating error.
    $ErrorActionPreference = 'Continue'
    # Write the error to the error stream or screen for testing
    Write-Error $_
       
    # Exit the script with a nonzero exit code to signal failure.
    exit 1
}





