<##########################################################################

  NAME: GroupPasswordExpire.ps1

  AUTHOR:  DreamThief
    contributors:

  FUNCTION: Lists all the members of the a group and lists them in descending order by their password expiration date.

  USIING GL Variables? YES
  
  VERSION HISTORY:  2.0 

##########################################################################>

#Global variables are defined, make sure this points to your email paramters
. .\modules\global.ps1

$group = "Executinve Team"

$summary = "<p> The list below are all members of $group. This list shows their password expirations dates. "

$one = Get-ADGroupMember $group | 
    Get-ADUser -properties passwordexpired, passwordlastset, title, msDS-UserPasswordExpiryTimeComputed | 
    sort passwordlastset |
            select name, title, `
                 @{Name=“ExpiryDate”;Expression={[datetime]::FromFileTime($_.“msDS-UserPasswordExpiryTimeComputed”)}}, `
                 @{Name="Days Until Expiration";Expression={ (([datetime]::FromFileTime(($psitem)."msDS-UserPasswordExpiryTimeComputed"))-(Get-Date)).Days }} 
    


$fragments = @()
$fragments+= "<H1>$group Passwords</H1>"
[xml]$html = $one | convertto-html -Fragment
 
for ($i=1;$i -le $html.table.tr.count-1;$i++) {
  if (
       ([int]10 -gt $html.table.tr[$i].td[3] )
      )
   {
    $class = $html.CreateAttribute("class")
    $class.value = 'alert'
    $html.table.tr[$i].attributes.append($class) | out-null
    #$html.table.tr[$i].childnodes[3].attributes.append($class) | out-null
  }
}
$fragments+= $html.InnerXml
$fragments+= "<p class='footer'>$glfootertxt</p>"
$convertParams = @{ 
  head = @"
 <Title>$group Password Expirations</Title>
<style>
body { background-color:#E5E4E2;
       font-family:Monospace;
       font-size:10pt; }
td, th { border:0px solid black; 
         border-collapse:collapse;
         white-space:pre; }
th { color:white;
     background-color:black; }
     table, tr, td, th { padding: 2px; margin: 0px ;white-space:pre; }
     tr:nth-child(odd) {background-color: lightgray}
     table { width:95%;margin-left:5px; margin-bottom:20px;}
h2 {
     font-family:Tahoma;
     color:#6D7B8D;
}
.alert {
     color: red; 
 }
.footer 
{ color:green; 
      margin-left:10px; 
      font-family:Tahoma;
      font-size:8pt;
      font-style:italic;
    }
</style>
"@
 body = $fragments
}



$data = convertto-html @convertParams

$body = "$Summary $data $glfooter" #if more than one $body = "$one $two $three $footer"

$to = "sysadmin@example.com" # Add more email addresses, seperated by comma

$subject = "$glSubjTest $group Passwords expiring"


$mailParams = @{
           'SmtpServer' = $glsmtp 
           'To'         = $to 
           'From'       = $glfrom 
           'Subject'    = $subject 
           'Body'       = $body
           'BodyAsHtml' = $true
           'Priority'   = 'high' 
}

send-MailMessage @mailParams
      
  