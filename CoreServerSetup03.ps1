## iex ((New-Object System.Net.WebClient).DownloadString('http://dreamthief.us/CoreServerSetup03.ps1'))


<#
TODO:
    Timezone check 
        Set-TimeZone -Name "Pacific Standard Time"
    Time Check
        NTP Servers
    WindowsUpdates


#>

clear-host

##Banner
Write-host "#############################################################" -ForegroundColor Green
Write-host "###                  Welcome to CUSCO                     ###" -ForegroundColor Green
Write-host "###     Casteel's Ultimate Server Configuration Online    ###" -ForegroundColor Green
Write-host "###                  Use at your own risk!                ###" -ForegroundColor Green
Write-host "###                                                       ###" -ForegroundColor Green
Write-host "#############################################################" -ForegroundColor Green
write-host ""
write-host ""


### Ask for input
$newhost = read-host "What is the hostname for this server?" 
write-host ""
$ipaddr = read-host "What is the IP Address?"
write-host ""
$subnet = read-host "What is the Subnet? Slash format e.g. 24 or 27 or 16"

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

### Write out the input
write-host ""
Write-host "The new hostname will be:    " -NoNewline -foregroundcolor yellow
write-host $newhost.ToUpper() -ForegroundColor red
Write-host "  The IP Address will be:    " -nonewline -ForegroundColor yellow
write-host $ipaddr -ForegroundColor red
Write-host " The subnet mask will be:    " -nonewline -ForegroundColor yellow
write-host $mask -ForegroundColor red
Write-host "     The gateway will be:    " -nonewline -ForegroundColor yellow
write-host $gateway -ForegroundColor red
Write-host "  The DNS Server will be:    "-nonewline -ForegroundColor yellow
write-host $dns -ForegroundColor red
write-host ""
write-host ""

##Final warnings
write-host ""
Write-host "This script will make the following changes to this machine"
write-host ""
write-host "  1. Update the network to the above details"
write-host "  2. Install Choclatey" 
write-host "  3. Install ConEMu"  
write-host "  4. Allow Ping throuw the firewall"
write-host "  5. Enable RDP Access and allow it through the firewall"
write-host "  6. Enable PS remote access and allow ANY machine to connect" 
write-host "  7. Enable PS Web access and allow ANY machine to connect"  
write-host "  8. Install PS Package Management"  -ForegroundColor red
write-host "  9. Update the WMI framework and Powershell" 
write-host ""
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
import-module netsecurity, dnsclient, NetTCPIP, netadapter
write-host "Import complete" -ForegroundColor Green
write-host ""

### Rename the server
Write-host "Renaming the computer"
rename-computer $newhost
Write-Host "Computer rename process complete" -ForegroundColor Green
write-host ""


### Install choclatey conemu and build a batch file
Write-Host "Installing Chocolatey" -ForegroundColor Green
invoke-expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
write-host ""
write-host ""

# install conemu and build a batch file
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
#$FWM=new-object -com hnetcfg.fwmgr
#$pro=$fwm.LocalPolicy.CurrentProfile
#$pro.icmpsettings.AllowInboundEchoRequest = $true
Enable-NetFirewallRule -DisplayGroup "File and Printer Sharing"
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


<#
write-host "Installing PS Package Management" -ForegroundColor Green
choco install powershell-packagemanagement -y
write-host "PS PackageManagement now complete" -ForegroundColor Green
#>

## update powershell
write-host "Upgrading windows Management Framework (Powershell)" -BackgroundColor red
write-host ""
choco install powershell -y -r -no-progress
write-host ""
write-host "WMI and Powershell have been updated" -BackgroundColor Magenta
write-host ""


### Wrap up
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
write-host ""
write-host ""

$shutdown = ""
while ($shutdown -notmatch "[y|n|s]"){
    $shutdown = read-host "Do you want to reboot now? (Y/N)" 
    }

if ($shutdown -eq "n"){
    break
    }
elseif ($shutdown -eq "y") { shutdown /r }
elseif ($shutdown -eq "s") { shutdown /s}

<#
write-host "" -ForegroundColor Green
write-host ""
#>