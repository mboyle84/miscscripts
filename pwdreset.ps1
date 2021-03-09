function Set-ADPassword {
    [cmdletBinding()]

 

      param (
  
      #Username of the user to be reset 
      [Parameter(Mandatory)]
      [string]$username,

 

      #New Password
      [Parameter(Mandatory)]
      [String]$password
      )
      
      $securePassword = ConvertTo-SecureString $password -AsPlainText -Force
      Set-AdAccountPassword -Identity $username -NewPassword $securePassword -Reset 
      Set-AdUSer -identity $username -ChangePasswordAtLogon $true
  
  }
