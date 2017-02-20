function get-CORPcompinfo {
param ([string]$lt)
    Try 
    {
Get-ADComputer $lt -properties `
     enabled, description, dnshostname, objectclass, location, managedby, ipv4address, whencreated, whenchanged,CanonicalName, OperatingSystem, OperatingSystemVersion, pwdlastset, lastlogon | 
     select enabled, dnshostname, description, `
     @{Name="Last Known IP address";Expression={ $psitem.ipv4address  }}, `
     objectclass, location, managedby, whencreated, whenchanged, OperatingSystem, OperatingSystemVersion,  `
     @{Name="PwdLastSet";Expression={[datetime]::FromFileTime($_.PwdLastSet)}}, `
     @{Name="LastLogon";Expression={[datetime]::FromFileTime($_.LastLogon)}}, `  
     @{Name="LastLogonTimeStamp";Expression={[datetime]::FromFileTime($_.LastLogonTimeStamp)}},
     @{Name="OU Location";Expression={ $psitem.CanonicalName  }}
     }
     Catch{
       Write-host "The Computername $lt was not found" -ForegroundColor Red
     }}