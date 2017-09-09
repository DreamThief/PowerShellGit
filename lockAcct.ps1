function lockAcct {
param ([string]$username)

$password = convertto-securestring -String "notverysecretpassword" -AsPlainText -Force
$server = $glserver # Set this to a domain controller near you
$badcreds = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password
$attempts = [int]10

 write-colr "This will make"," $attempts ","attempts to authenticate against", " $server" green,red,green,red 

try {
    for($i=1; $i -le $attempts; $i++){
    get-aduser -Server $glserver -Credential $badcreds -Identity Administrator -ErrorAction SilentlyContinue
     <# Invoke-Command -ComputerName $glserver {Get-Process `
      } -Credential ($badcreds) -ErrorAction SilentlyContinue #>
      Write-host "Authentication Unseccessful $i times." -ForegroundColor Red
        }
      }
catch {
  Write-host "The attempt to connect to the server was wholly unseccful" -ForegroundColor Red
        }
     }


  cls
 write-host ""
 write-host "done!"
 write-host ""
 Write-host "`$texas = get-aduser -filter {state -eq 'Texas' } | select samaccountname "
 write-host ""
write-host "foreach (`$texan in `$texas) {lockacct `$texan.samaccountname }" 
  


  <#

  function lockAcct {
param ([string]$username)

$password = convertto-securestring -String "notverysecretpassword" -AsPlainText -Force
$server = "dreamthief.co" # Set this to a domain controller near you
$badcreds = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password
$attempts = [int]10

write-colr "This will make"," $attempts ","attempts to authenticate against", " $server" green,red,green,red 

try {

    write-colr "This will make"," $attempts ","attempts to authenticate against", " $server" green,red,green,red 
   
    for($i=1; $i -le $attempts; $i++){
    get-aduser -Server $server -Credential ($badcreds) -Identity $username -ErrorAction SilentlyContinue | out-null
#    Invoke-Command -ComputerName $glserver {Get-Process `
#      } -Credential ($badcreds) -ErrorAction SilentlyContinue
      Write-host "Authentication Unseccessful $i times." -ForegroundColor Red
      }
      }
catch {
  Write-host "The attempt to connect to the server was wholly unseccful" -ForegroundColor Red
        }
     }
 <#
 if (Get-Command $cmdName -errorAction SilentlyContinue)
  else
    {write-host "This will make $attempts attempts to authenticate agains $server" -ForegroundColor green }
 #>
#<
 cls
 write-host ""
 write-host "done!"
 write-host ""
 Write-host "`$texas = get-aduser -filter {state -eq 'Texas' } | select samaccountname "
 write-host ""
write-host "foreach (`$texan in `$texas) {lockacct `$texan.samaccountname }"

#>