#get-allADgroupMembers | Export-Csv .\desktop\members.csv

function get-allADgroupMembers{
$Groups = Get-ADGroup -Properties * -Filter * |
    where {$_.isCriticalSystemObject -eq $null} 

foreach( $Group in $Groups ){
    Get-ADGroupMember -Identity $Group | 
        where {$_.objectClass -eq "user"} | 
            foreach {
            [pscustomobject]@{
            GroupName   = $Group.Name
            Name        = $_.Name
            ObjType     = $_.objectClass
            scope       = $group.groupScope
            Desc        = $group.description
            displayname = $group.displayname

             }
          }
       }
    }