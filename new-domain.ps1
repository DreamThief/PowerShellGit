#
# Windows PowerShell script for AD DS Deployment
#

$domain = @{
    'CreateDnsDelegation'  = $false ;
    'DatabasePath'         = "C:\Windows\NTDS" ;
    'DomainMode'           = "Win2016" ;   #This can also be "7"
    'DomainName'           = "dreamthief.co" ;
    'DomainNetbiosName'    = "DREAMTHIEF" ;
    'ForestMode'           = "Win2016" ;  #This can also be "7"
    'InstallDns'           = $true ;
    'LogPath'              = "C:\Windows\NTDS" ;
    'NoRebootOnCompletion' = $false ;
    'SysvolPath'           = "C:\Windows\SYSVOL" ;
    'Force'                = $true
}

Import-Module ServerManager 

Add-WindowsFeature AD-Domain-Services 


Import-Module ADDSDeployment

#This will jsut show you what it looks like when executed, it will not actually run the command
write-host "Install-ADDSForest" @domain

# Just unremark the below line to make it all work. 
#Install-ADDSForest @domain

#Really should not keep a password here
# [password]

##After words
#Install-WindowsFeature rsat-remoteaccess rsat-adds

#Import-module servermanager ; Get-WindowsFeature | where-object {$_.Installed -eq $True} | format-list DisplayName


#$check = Read-Host "What are you looking for?"

#(Get-WindowsFeature -name $check).Installed 





