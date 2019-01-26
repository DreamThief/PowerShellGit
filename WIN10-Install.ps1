# Set-ExecutionPolicy Bypass -Scope Process -Force; 

Clear-Host

##Banner
Write-host "#############################################################" -ForegroundColor Green
Write-host "###                  Welcome to CLaSS                     ###" -ForegroundColor Green
Write-host "###               Casteel's LAptop Setup script           ###" -ForegroundColor Green
Write-host "###                  Use at your own risk!                ###" -ForegroundColor Green
Write-host "###                                                       ###" -ForegroundColor Green
Write-host "#############################################################" -ForegroundColor Green
write-host ""
write-host ""


write-host "Importing modules" -ForegroundColor blue
import-module netsecurity, dnsclient, NetTCPIP, netadapter

write-host ""
write-host ""

Write-Host "Disabling tcp/ip 6" -ForegroundColor Green
$ethList = Get-NetIPConfiguration
foreach ($nic in $ethList) {
            Disable-NetAdapterBinding -InterfaceAlias $nic.interfacealias -ComponentID ms_tcpip6

}
write-host ""
write-host ""

write-host "What do you want to do?" -ForegroundColor Yellow
write-host "1. Basic setup: root Adminuser setup, rename, add O365 admin" -ForegroundColor Yellow
write-host "2. Install chocolatey and associtated required software" -ForegroundColor Yellow
write-host "3. Windows Updates" -ForegroundColor Yellow
write-host "4. Start Win10 1803 setup" -ForegroundColor Yellow
write-host "5. Cleanup all temp directories" -ForegroundColor Yellow

write-host ""
 $option = read-host -Prompt "What option number do you want?"
write-host ""
write-host ""

## Section 1 setup

if ($option -eq 1) {
    ## Create local user account and add it to the local admins
    $password = ConvertTo-SecureString 'BadPAssword123&*' -AsPlainText -Force

    $adminName = 'WINAdmin'

    $usr = @{
        'name'                 = $adminName
        'Description'          = "Generic WIN Admin"
        'password'             = $password
        'AccountNeverExpires'  = $true
        'PasswordNeverExpires' = $true
    }

    new-localuser @usr

    Add-LocalGroupMember -Group "Administrators" -Member $adminName



    #Ask the user what they want the new computername to be
    $newHostName = read-host -Prompt "What do you want to name this machine?"
    ##Rename the computer
    rename-computer $newHostName
    write-host ""
    write-host ""

    # email address of who will be the admin onthis box:
    # net localgroup administrators AzureAD\dcasteel@perftuning.com /add
}
## End section 1 setup

## Begin section 2setup
elseif ($option -eq 2) {
    #Install chocolatey
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

    ##Set up programs for chocolately to install.
    #base programs for all machines
    $progs = @(
        'conemu' ,
        'chocolateygui' ,
        'notepadplusplus' ,
        'firefox' ,
        'googlechrome' ,
        'adobeair' ,
        'flashplayerplugin' ,
        'jre8' ,
        'javaruntime' ,
        'jdk8' ,
        'windirstat' ,
        '7zip' ,
        'foxitreader' ,
        'zoom' ,
        'visioviewer2016' ,
        'sysinternals' ,
        'slack',
        'office365business' ,
        'microsoft-teams' ,
        'bginfo'
    )

    #programs for dev machines
    $dev = @(
        'visualstudiocode' ,
        'vscode-powershell' ,
        'vscode-icons' ,
        'git' ,
        'openssh' ,
        'git-credential-winstore',
        'rdmfree' ,
        'rdcman' ,
        'superputty' ,
        'putty' ,
        'winscp'
    )

    #security options, these may conflict with other choices
    $security = @(
        'avastfreeantivirus' ,
        'spybot' ,
        'malwarebytes' ,
        'keepass'
    )

    #programs for virtual needs
    $extend = @(
        'vmwareworkstation' ,
        'nomachine' ,
        'virtualbox'
    )

    #Install the programs
    choco install $progs $dev -y #$extend $security
}
## End section 2 setup

### Begin section 3 setup
elseif ($option -eq 3){
        iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/DreamThief/PowerShellGit/master/run-WInUpdate.ps1'))
        }
### End section  setup

## Begin section 4

## End section 4

## Begin section 5 setup
#iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/DreamThief/PowerShellGit/master/clean-disk.ps1'))
### end Section 5