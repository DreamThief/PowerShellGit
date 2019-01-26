# iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/DreamThief/PowerShellGit/master/run-WInUpdate.ps1'))
# 
# In case you need to sysprep 
# %WINDIR%\system32\sysprep\sysprep.exe /generalize /shutdown /oobe /mode:vm
# . $env:systemroot\system32\sysprep\sysprep.exe /generalize /shutdown /oobe /mode:vm

cls

#Define update criteria.

$Criteria = "IsInstalled=0"


#Search for relevant updates.

write-host "Checking for what needs to be installed" -ForegroundColor green

$Searcher = New-Object -ComObject Microsoft.Update.Searcher

$SearchResult = $Searcher.Search($Criteria).Updates


#Download updates.

write-host "Downloading the needful" -ForegroundColor yellow

$Session = New-Object -ComObject Microsoft.Update.Session

$Downloader = $Session.CreateUpdateDownloader()

$Downloader.Updates = $SearchResult

$Downloader.Download()

write-host "Installing the needful" -ForegroundColor green

$Installer = New-Object -ComObject Microsoft.Update.Installer

$Installer.Updates = $SearchResult

$Result = $Installer.Install()


$choice = ""
while ($choice -notmatch "[y|n]") {
    $choice = read-host "You, may need a reboot, Do you want to continue? (Y/N)" 
}

if ($choice -eq "n") {
    break
}

If ($Result.rebootRequired) { shutdown.exe /t 0 /r }