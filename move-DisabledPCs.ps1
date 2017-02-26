function move-DisabledPCs {

$disabledPCs = Get-ADComputer -server $server -Credential $creds -filter {enabled -eq $false}
$ouPath = "OU=TestComputers,DC=dreamthief,DC=co" 

foreach ($pc in $disabledPCs) {
    move-adobject $pc -TargetPath $ouPath

        }
    }