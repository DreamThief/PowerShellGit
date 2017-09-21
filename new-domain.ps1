#
# Windows PowerShell script for AD DS Deployment
#

$domain = @{
    'CreateDnsDelegation'  = $false ;
    'DatabasePath'         = "C:\Windows\NTDS" ;
    'DomainMode'           = "Win2012R2" 
    'DomainName'           = "dreamthief.co" ;
    'DomainNetbiosName'    = "DREAMTHIEF" ;
    'ForestMode'           = "Win2012R2" ;
    'InstallDns'           = $true ;
    'LogPath'              = "C:\Windows\NTDS" ;
    'NoRebootOnCompletion' = $false ;
    'SysvolPath'           = "C:\Windows\SYSVOL" ;
    'Force'                = $true
}

Import-Module ServerManager 

Add-WindowsFeature AD-Domain-Services 


Import-Module ADDSDeployment

write-host "Install-ADDSForest" @domain

BrokenArrow1!!


Install-WindowsFeature rsat-remoteaccess rsat-adds


Import-module servermanager ; Get-WindowsFeature | where-object {$_.Installed -eq $True} | format-list DisplayName


$check = Read-Host "What are you looking for?"

(Get-WindowsFeature -name $check).Installed 





