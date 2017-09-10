## iex ((New-Object System.Net.WebClient).DownloadString('http://dreamthief.us/CoreServerSetup01.ps1'))

# import needed modules
write-host "Importing needed modules" -ForegroundColor Green
write-host ""
import-module netsecurity, dnsclient, NetTCPIP, netadapter
write-host "import complete" -ForegroundColor Green
write-host ""

### Rename the server

Write-host "Renaming the computer"
rename-computer WINSVR2012CORE
Write-Host "Computer rename process complete" -ForegroundColor Green
write-host ""


### Install the conemu and build a batch file
Write-Host "Installing ConEmu" -ForegroundColor Green
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install conemu -y
dir > conemu.bat
$test ='"C:\Program Files\ConEmu\ConEmu64.exe"'
set-content .\conemu.bat $Test
Write-Host "ConEmu install complete" -ForegroundColor Green
write-host ""

##Set up the network
Write-Host "Setting up the network" -ForegroundColor Green
Disable-NetAdapterBinding -Name "Ethernet0" -ComponentID ms_tcpip6
New-NetIPAddress -InterfaceIndex 12 -IPAddress 10.0.0.142 -PrefixLength 24 -DefaultGateway 10.0.0.1
Set-DnsClientServerAddress -InterfaceIndex 12 -ServerAddresses ("10.0.0.1", "8.8.8.8")
Write-Host "Network setup complete" -ForegroundColor Green
write-host ""

###Allow ping
Write-Host "Allow ping through the firewall" -ForegroundColor Green
$FWM=new-object -com hnetcfg.fwmgr
$pro=$fwm.LocalPolicy.CurrentProfile
$pro.icmpsettings.AllowInboundEchoRequest=$true
Write-Host "PIng now allowed" -ForegroundColor Green
write-host ""

### Allow RDP
Write-Host "Allowing RDP access" -ForegroundColor Green
set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
Write-Host "RDP Access complete" -ForegroundColor Green
write-host ""

#### Allow PS Web access and PS remoting 
Write-Host "Allow PS Web access and PS remoting" -ForegroundColor Green
Install-WindowsFeature –Name WindowsPowerShellWebAccess -IncludeManagementTools

Install-PswaWebApplication -UseTestCertificate

Set-Item WSMan:\localhost\Client\TrustedHosts '*' -force

Add-PswaAuthorizationRule -UserName * -ComputerName * -ConfigurationName *
write-host "PS Web and PS Remoting now complete" -ForegroundColor Green
write-host "" -ForegroundColor Green
write-host ""

write-host "All processes complete" -ForegroundColor Green
write-host ""



<#
write-host "" -ForegroundColor Green
write-host ""
#>