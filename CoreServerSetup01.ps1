### Rename the server

rename-server WINSVR2012CORE

### Install the conemu and build a batch file
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install conemu
dir > conemu.bat
$test ='"C:\Program Files\ConEmu\ConEmu64.exe"'
set-content .\conemu.bat $Test

##Set up the network
Disable-NetAdapterBinding -Name "Ethernet0" -ComponentID ms_tcpip6
New-NetIPAddress -InterfaceIndex 12 -IPAddress 10.0.0.142 -PrefixLength 24 -DefaultGateway 10.0.0.1
Set-DnsClientServerAddress -InterfaceIndex 12 -ServerAddresses ("10.0.0.1", "8.8.8.8")

###Allow ping
$FWM=new-object -com hnetcfg.fwmgr
$pro=$fwm.LocalPolicy.CurrentProfile
$pro.icmpsettings.AllowInboundEchoRequest=$true


### Allow RDP
set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

#### Allow PS Web access and PS remoting 
Install-WindowsFeature –Name WindowsPowerShellWebAccess -IncludeManagementTools
Install-PswaWebApplication -UseTestCertificate
Set-Item WSMan:\localhost\Client\TrustedHosts '*'
Add-PswaAuthorizationRule -UserName * -ComputerName * -ConfigurationName *



