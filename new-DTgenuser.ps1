﻿
function new-DTgenuser {

    param([int]$NumberToDo = 1)

    $date = Get-Date -Format dd-MMM-yyyy
    $server = "dreamthief.co"

    for ($npcindex = 1; $npcindex -le $NumberToDo; $npcindex++) {
    $firstName = get-content ".\files\firstNames.txt" | random
    $surName = get-content ".\files\surNames.txt" | random
    $description = "Generated on $date "
    $city = get-content ".\files\cityNames.txt" | random
    $userName = $firstName + "." + $surName
    $displayName = $surname + ", " + $firstName
    $password = "Start12345" | ConvertTo-SecureString -AsPlainText -Force

    if ($city = "New York" -eq $true ) {$state = "New York"} 
     ElseIf ($city = "Boston" -eq $true ) {$state = "Msachussets"} 
     ElseIf ($city -eq "Los Angeles" -eq $true) {$state = "California"}
     ElseIf ($city = "Chicago" -eq $true ) {$state = "Illinois"}
     ElseIf ($city = "Houston" -eq $true) {$state = "Texas"}
     ElseIf ($city = "Philadelphia" -eq $true) {$state = "Pennsylvania"}
     ElseIf ($city = "Phoenix" -eq $true) {$state = "Arizona"}
     ElseIf ($city = "San Antonio" -eq $true) {$state = "Texas"}
     ElseIf ($city = "San Digeo" -eq $true) {$state = "California"}
     ElseIf ($city = "Dallas" -eq $true) {$state = "Texas"}
     ElseIf ($city = "San Jose" -eq $true) {$state = "California"}
     ElseIf ($city = "Austin" -eq $true) {$state = "Texas"}
     else {$state = "Idowa"}



    Write-host "I will try and create a new account with this username: $username"
    Write-host "The display name will be: $displayName"
    
#    $creds = Get-Credential

new-ADUser -Server $server `
    -Credential $creds `
        -samaccountname $username `
        -name $displayName `
        -givenName $firstName `
        -surname $surName `
        -displayName $displayName `
        -description $description `
        -city $city `
        -office $city `
        -state $state `
        -AccountPassword $Password `
        -ChangePasswordAtLogon $True `
        -Enabled $True `
        -Path "OU=TestUSers,DC=dreamthief,DC=co" 
     }
     }


    <# 
    [-MobilePhone    <string>] 
[-Office <string>] 
[-OfficePhone <string>] 
[-Organization <string>]
   
    #>