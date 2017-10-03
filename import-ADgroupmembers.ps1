cls
#set the OU Path
$groupou = 'OU=TestGroups,DC=dreamthief,DC=co'

#pull the data
$impGroups = import-csv .\Desktop\members.csv

#find unique groups
$unique = $impgroups | select groupname, scope, desc, displayname |Get-Unique -asstring

#create groups
foreach ($junk in $unique) {
    $args = @{
        'name'        = $junk.groupname
        'GroupScope'  = $junk.scope
        'description' = $junk.desc
        'path'        = $groupOU
        'displayname' = $junk.displayname
    }
    try {
        new-adgroup @args
        write-host "The group $($junk.groupname) has been created"
    }
    Catch {
        write-host ""
        Write-host "The group $($junk.groupname) already exists"
    }
}

#put users into groups
foreach ($imp in $impgroups) {
    Add-ADGroupMember -identity $imp.GroupName -members $imp.name
    Write-host $imp.name "was added to" $imp.groupname 
}