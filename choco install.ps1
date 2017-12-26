iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
#base programs for all machines
$progs = @( 
            'conemu' , 
            'chocolateygui' , 
            'windowspowershell' , 
            'notepadplusplus' , 
            'avastfreeantivirus' , 
            'firefox' , 
            'googlechrome' , 
            'adobeair' , 
            'flashplayerplugin' , 
            'jre8' , 
            'javaruntime' , 
            'adobeshockwaveplayer' , 
            'windirstat' , 
            '7zip' , 
            'vlc' , 
            'audacity' , 
            'foxitreader' , 
            'skype' , 
            'spotify' , 
            'dropbox' , 
            'evernote' , 
            'itunes' , 
            'keepass2' , 
            'dotnet4.7' , 
            'jdk8' , 
            'spybot' , 
            'opera' , 
            'zoom' , 
            'visioviewer2016' , 
            'silverlight' , 
            'sysinternals' , 
            'procexp' , 
            'itunes' , 
            'evernote-chrome' , 
            'isorecorder' , 
            'kindle' ,
            'slack' , 
            'sendtokindle'  

            )

#programs for dev machines
$dev = @(
            'visualstudiocode' , 
            'vscode-powershell' , 
            'git' , 
            'github',
            'openssh' , 
            'git-credential-winstore',
            'hyper' , 
            'rdmfree' , 
            'rdcman' ,
            'superputty' , 
            'putty' , 
            'winscp' 
        )

#programs for personal needs
$extend = @(
            'vmwareworkstation' ,
            'nomachine' ,
            'trillian' , 
            'evernote' , 
            'thunderbird' 
           )




choco install $progs $dev $extend


