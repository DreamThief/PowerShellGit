<######################################################
If the workstation you run this from is already on the desired domain, 
you can remark out $creds and $server. Also remove them from the $userinfo line

If you are checkign accounts agains a different domain (other than one your workstation is joined to)
you can leave them in.

######################################################>

#Global variables are defined
#. .\modules\global.ps1
. .\c:\scripts\global.ps1


function get-corpUserinfo {
    param (
            [string]$user
            )
 #   $creds = Get-Credential

    Try {
      $userinfo = ( Get-ADUser -server $server -Credential $creds -identity $user -properties *  )# `
      <#passwordexpired, description, office, proxyaddresses, employeeType,UserPrincipalName, homedirectory, mdbusedefaults,
       mdboverquotalimit, mdbstoragequota, msExchHideFromAddressLists, `
      passwordlastset, telephoneNumber, mobile, passwordneverexpires, whenCreated, AccountExpirationDate, homeMDB, `
      employeeID, manager, title, mail, adminCount, lockedout, department,accountexpires,lastLogon, CanonicalName, msDS-UserPasswordExpiryTimeComputed)
        #>}
      catch
        {
     # Write-colr "The username", " $user ", "was not found. Sheesh, $env:username, learn how to type!" Green,red,green
     write-host ""
     write-host "The function faled. Please check your credentials and validate the AD server." -ForegroundColor red
        }

        if ($userInfo -ne $null) {
        if ($userInfo.passwordneverexpires -eq $false ){ $days = (([datetime]::FromFileTime(($userInfo)."msDS-UserPasswordExpiryTimeComputed"))-(Get-Date)).Days }
        if ($userInfo.admincount -ne $null) { Write-host -ForegroundColor red "Priviledged account"}
        
        Write-host "Name                  :" $userInfo.name
        Write-host "Enabled               : " -NoNewline; if ($userInfo.enabled -eq $false) {Write-Host -ForegroundColor red $userInfo.enabled} ELSE {Write-Host -ForegroundColor white $userInfo.enabled}
        write-host "Account/Username      :" $userInfo.samaccountname
        Write-host "Principle Name        :" $userInfo.UserPrincipalName
        Write-host "Title                 :" $userInfo.title
        Write-host "Description           :" $userInfo.description
        Write-host "Office                :" $userInfo.office
        Write-host "Department            :" $userInfo.department
        Write-host "Manager               : " -noNewLine; if($userinfo.manager -ne $null) { (Get-Aduser -server $server -credential $creds -identity $userInfo.manager).Name } ELSE {Write-Host "No Manager Assigned"}
        Write-host "DeskPhone             :" $userInfo.telephoneNumber
        Write-host "Mobile Phone          :" $userInfo.mobile
        Write-host "Primary Email         :" $userInfo.mail
        Write-host "AD OU                 :" $userInfo.CanonicalName
        Write-host "Employee ID           :" $userInfo.employeeID
        Write-host "Employee Type         :" $userInfo.employeeType
        Write-host "When Created          :" $userInfo.whenCreated
        Write-host "Password Last Changed :" $userInfo.passwordlastset
        Write-host "PW never expires?     : " -NoNewline; if ($userInfo.passwordneverexpires -eq $false ) {Write-Host -ForegroundColor white $userInfo.passwordneverexpires} ELSE {Write-Host -ForegroundColor red $userInfo.passwordneverexpires}
        if ($userInfo.passwordneverexpires -eq $false) { `
        Write-host "PW expired?           : " -NoNewline; if ($userInfo.passwordexpired -eq $false) {Write-Host -ForegroundColor white $userInfo.passwordexpired} ELSE {Write-Host -ForegroundColor red $userInfo.passwordexpired}
        Write-host "PW Expiration date    :" ([datetime]::FromFileTime($userInfo.“msDS-UserPasswordExpiryTimeComputed”)) 
        Write-host "Days until pw expires : " -nonewline; if ($days -lt 10) {write-host -foregroundcolor red $days} else {write-host -foregroundcolor white $days} }
        Write-host "Account Locked?       : " -NoNewline; if ($userInfo.lockedout -eq $false) {Write-Host -ForegroundColor white $userInfo.LockedOut} ELSE {Write-Host -ForegroundColor Red $userInfo.LockedOut}
        if ($userInfo.AccountExpirationDate -ne $null) { `
        Write-host -ForegroundColor red "Acct Expiration date  :" $userInfo.AccountExpirationDate }
        Write-host "Home Directory        :" $userInfo.homedirectory
        if ($userInfo.admincount -ne $null) { Write-host -ForegroundColor red "Priviledged account"}
        Write-host ""
        Write-host "#### Exchange Information ####"
        Write-host ""
        if ($userInfo.homeMDB -ne $null) { `
        Write-host "Exchange database name   : " -nonewline; write-host ($userInfo.homeMDB | % {($_ -split ',')[0] -join ", `n" }).remove(0,3) }
        if ($userInfo.mdbusedefaults -eq $true) { `
        Write-host "Using Exchange Defaults? :" $userInfo.mdbusedefaults }
        if ($userInfo.mdbusedefaults -eq $false) { `
        Write-host "Mail storage Quota warn  :" ($userInfo.mdbstoragequota / 1024000) }
        if ($userInfo.mdbusedefaults -eq $false) { `
        Write-host "Mail storage Quota max   :" ($userInfo.mdboverquotalimit / 1024000)}
        if ($userInfo.msExchHideFromAddressLists -ne $null) { `
        Write-host "Hidden from Address list?:" $userInfo.msExchHideFromAddressLists }
        if ($userInfo.proxyaddresses -ne $null) { `
        Write-host "SIP Address for Lync     :" (($userInfo.proxyaddresses | ? {$_ -match '^sip'})-join'; ') 
        Write-host "Proxy Addresses          :" 
        Write-host (($userInfo.proxyaddresses | ? {$_ -match '^smtp'})-join"; `n ") }
}
  }
