$group = "testgroup1"
Get-ADGroupMember $group | 
    ForEach-Object { 
    Remove-ADGroupMember $group $_  
} 