function new-DTgenuser {

    param([int]$NumberToDo = 1)

## Primary variables.
    $date = Get-Date -Format dd-MMM-yyyy
    $server = "dreamthief.co"
    $ouPath = "OU=TestUSers,DC=dreamthief,DC=co" 
#   $creds = Get-Credential

    for ($npcindex = 1; $npcindex -le $NumberToDo; $npcindex++) {
    $firstName = get-content ".\files\firstNames.txt" | random
    $surName = get-content ".\files\surNames.txt" | random
    $description = "Generated on $date "
    $city = get-content ".\files\cityNames.txt" | random
    $userName = $firstName + "." + $surName
    $displayName = $surname + ", " + $firstName
    $password = "Start12345" | ConvertTo-SecureString -AsPlainText -Force
    $telephoneNumber = new-phoneNumber
    $mobile = new-phoneNumber
    $department = get-content ".\files\departments.txt" | random
    $title = get-content ".\files\titles.txt" | random
    

##This still is not working, everything comes back as Idowa
## If the -eq $true is removed, everything comes back as new york.
    if ($city -eq "New York"  ) {$state = "New York"} 
     ElseIf ($city -eq "Boston"  ) {$state = "Msachussets"} 
     ElseIf ($city -eq "Los Angeles" ) {$state = "California"} 
     ElseIf ($city -eq "Chicago"  ) {$state = "Illinois"} 
     ElseIf ($city -eq "Houston" ) {$state = "Texas"} 
     ElseIf ($city -eq "Philadelphia" ) {$state = "Pennsylvania"} 
     ElseIf ($city -eq "Phoenix" ) {$state = "Arizona"} 
     ElseIf ($city -eq "San Antonio" ) {$state = "Texas"} 
     ElseIf ($city -eq "San Digeo" ) {$state = "California"} 
     ElseIf ($city -eq "Dallas" ) {$state = "Texas"} 
     ElseIf ($city -eq "San Jose" ) {$state = "California"} 
     ElseIf ($city -eq "Austin" ) {$state = "Texas"} 
     else {$state = "Idowa"}


## Screen output
    Write-host "I will try and create a new account with this username: $username"
    Write-host "The display name will be: $displayName"

## SPLAT Parameters 
$props = @{
            'Server' = $server;
            'Samaccountname' = $username;
            'UserPrincipalName' = $userName;
            'name' = $displayName;
            'givenName' = $firstName;
            'surname' = $surName;
            'displayName' = $displayName;
            'description' = $description;
            'mobile' = $mobile;
            'officePhone' = $telephoneNumber;
            'city' = $city;
            'office' = $city;
            'state' = $state;
            'department' = $department;
            'title' = $title;
            'AccountPassword' = $Password;
            'ChangePasswordAtLogon' = $True;
            'Enabled' = $True;
            'Path' = $ouPath 
            }  

## Actual work being done.
# May need to add in $creds
new-ADUser @props
        
         }
     }