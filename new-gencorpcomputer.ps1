function new-gencorpcomputer {

    param([int]$NumberToDo = 1)

  for ($npcindex = 1; $npcindex -le $NumberToDo; $npcindex++) {
    $asset = get-random -Minimum 10000 -Maximum 99999
    $computername = "lt-" + $asset
    $os = get-content ".\files\os.txt" | random
    $ouPath = "OU=TestComputers,DC=dreamthief,DC=co" 

    Write-host "I will try and create a new account with this hostname: $computername "


        new-adcomputer -server $server -Credential $creds `
            -name $computername `
            -samaccountname $computername `
            -OperatingSystem $os `
            -path $oupath `
            -Enabled $false
    }

}