## iex ((New-Object System.Net.WebClient).DownloadString('http://dreamthief.us/CoreServerSetup02.ps1'))

cls

Write-host "#############################################################" -ForegroundColor Green
Write-host "###                  Welcome to CUSCO                     ###" -ForegroundColor Green
Write-host "###     Casteel's Ultimate Server Configuration Online    ###" -ForegroundColor Green
Write-host "###                  Use at your own risk!                ###" -ForegroundColor Green
Write-host "###                                                       ###" -ForegroundColor Green
Write-host "#############################################################" -ForegroundColor Green
write-host ""
write-host ""

$newhost = read-host "What is the hostname for his machine?" 
write-host ""
$ipaddr = read-host "What is the IP Address?"
write-host ""
$subnet = read-host "What is the Subnet? Slash format e.g. 24 or 27 or 26"

if ($subnet -eq 30)	{$mask = "255.255.255.252"}
elseif	($subnet -eq 29)	{$mask = "255.255.255.248"}	
elseif  ($subnet -eq 28)	{$mask = "255.255.255.240"}
elseif	($subnet -eq 27)	{$mask = "255.255.255.224"}	
elseif	($subnet -eq 26)	{$mask = "255.255.255.192"	}
elseif	($subnet -eq 25)	{$mask = "255.255.255.128"	}
elseif	($subnet -eq 24)	{$mask = "255.255.255.0"}
elseif	($subnet -eq 23)	{$mask = "255.255.254.0"}	
elseif	($subnet -eq 22)	{$mask = "255.255.252.0"}	
elseif	($subnet -eq 21)	{$mask = "255.255.248.0"}	
elseif	($subnet -eq 20)	{$mask = "255.255.240.0"}	
elseif	($subnet -eq 19)	{$mask = "255.255.224.0"}	
elseif	($subnet -eq 18)	{$mask = "255.255.192.0"}	
elseif	($subnet -eq 17)	{$mask = "255.255.128.0"}	
elseif	($subnet -eq 16)	{$mask = "255.255.0.0"	}

write-host ""
$gateway = read-host "What is the gateway address?"
write-host ""
$dns = read-host "What is the DNS? More can be added after final config if needed"

write-host ""
Write-host "The new hostname will be:    " -NoNewline -foregroundcolor yellow
write-host $newhost.ToUpper() -ForegroundColor red

Write-host "  The IP Address will be:    " -nonewline -ForegroundColor yellow
write-host $ipaddr -ForegroundColor red

Write-host " The subnet mask will be:    " -nonewline -ForegroundColor yellow
write-host $mask -ForegroundColor red

Write-host "      The gateay will be:    " -nonewline -ForegroundColor yellow
write-host $gateway -ForegroundColor red

Write-host "  The DNS Server will be:    "-nonewline -ForegroundColor yellow
write-host $dns -ForegroundColor red
write-host ""

$choice = ""
while ($choice -notmatch "[y|n]"){
    $choice = read-host "Do you want to continue? (Y/N)" 
    }

if ($choice -eq "n"){
    break
    }

write-host ""
write-host ""
Write-host "...and so we begin!" -ForegroundColor red
write-host ""
write-host ""
write-host ""

# import needed modules
write-host "Importing needed modules" -ForegroundColor Green
write-host ""
import-module netsecurity, dnsclient, NetTCPIP, netadapter
write-host "Import complete" -ForegroundColor Green
write-host ""

### Rename the server

Write-host "Renaming the computer"
write-host ""
write-host ""
rename-computer $newhost
Write-Host "Computer rename process complete" -ForegroundColor Green
Write-host "The new hostname will be: " -ForegroundColor Green -NoNewline
Write-host $newhost.ToUpper() -ForegroundColor Yellow
write-host ""


### Install the conemu and build a batch file
Write-Host "Installing Chocolatey" -ForegroundColor Green
invoke-expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
write-host ""
write-host ""
Write-Host "Installing conemu" -ForegroundColor Green
choco install conemu -y -r -no-progress 
dir > conemu.bat
$test ='"C:\Program Files\ConEmu\ConEmu64.exe"'
set-content .\conemu.bat $Test
Write-Host "ConEmu install complete" -ForegroundColor Green
write-host ""

##Set up the network
Write-Host "Setting up the network" -ForegroundColor Green
Disable-NetAdapterBinding -Name "Ethernet0" -ComponentID ms_tcpip6
New-NetIPAddress -InterfaceIndex 12 -IPAddress $ipaddr -PrefixLength $subnet -DefaultGateway $gateway
Set-DnsClientServerAddress -InterfaceIndex 12 -ServerAddresses ("$dns", "8.8.8.8")
Write-Host "Network setup complete" -ForegroundColor Green
write-host ""

###Allow ping
Write-Host "Allow ping through the firewall" -ForegroundColor Green
$FWM=new-object -com hnetcfg.fwmgr
$pro=$fwm.LocalPolicy.CurrentProfile
$pro.icmpsettings.AllowInboundEchoRequest=$true
Write-Host "Ping now allowed" -ForegroundColor Green
Write-Host "Ping was my best friend in school" -ForegroundColor Green
write-host ""

### Allow RDP
Write-Host "Setting up RDP access" -ForegroundColor Green
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

write-host "Upgrading windows Management Framework (Powershell)" -BackgroundColor red
choco install powershell -y -r -no-progress
write-host ""
write-host "WMI and Powershell have been updated" -BackgroundColor Magenta
write-host ""

write-host ""
write-host "All processes complete" -ForegroundColor Green
write-host ""
write-host "You must " -NoNewline -ForegroundColor Green
write-host "REBOOT" -NoNewline -BackgroundColor Red
write-host " to finish the setup" -ForegroundColor Green
write-host ""
write-host "Use the command  " -NoNewline -ForegroundColor Green
write-host "shutdown /r" -NoNewline -BackgroundColor Red
write-host "  To reboot" -ForegroundColor Green

$shutdown = ""
while ($shutdown -notmatch "[y|n]"){
    $shutdown = read-host "Do you want to reboot now? (Y/N)" 
    }

if ($shutdown -eq "n"){
    break
    }
else { shutdown /r }

<#
write-host "" -ForegroundColor Green
write-host ""
#>