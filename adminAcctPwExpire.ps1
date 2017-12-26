<##########################################################################

  NAME: adminPW01.ps1

  AUTHOR:  Casteel
    contributors:

  FUNCTION: This will run a query against everything in the AD with the attib of adminCount=1. 
            This signifies that the AD object was at one time in one of the default special groups.

  USIING GL Variables? YES
  
  VERSION HISTORY:  1.0 2-Sept-2016 - Initial release
                    1.1 10-feb-2017 - added password age

##########################################################################>


#Global variables are defined
. .\modules\global.ps1

#$path = .\html\privcount.html

$props = @(
    'passwordexpired' , 
    'samaccountname' , 
    'passwordlastset' , 
    'description' , 
    'mail' , 
    'lockedout' , 
    'msDS-UserPasswordExpiryTimeComputed'
    )

$parms = @{
            'filter'     = '{Enabled -eq "True" -and adminCount -eq "1" }' 
            'properties' =  $props
            }

$one = get-aduser $parms | 
            sort msDS-UserPasswordExpiryTimeComputed |
            select name,passwordlastset, 
            @{Name=“PW Expiration Date”;Expression={[datetime]::FromFileTime($_.“msDS-UserPasswordExpiryTimeComputed”)}}, 
            @{Name="PW Age(days)";Expression={ (([datetime]::FromFileTime(($psitem)."msDS-UserPasswordExpiryTimeComputed"))-(Get-Date)).Days }},
            description 


$fragments = @()
$fragments+= "<H1>Priv Account status</H1>"
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
 <Title>Priv Account Password Expirations</Title>
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

$top = "<p> This script checks for the <i>adminCount=1</i> attribute in AD. If found it will put the account into this list and sorts by password expiration date.</p>
            <p> The accounts <i>without</i> a password expiration date are listed after the more recent dates.</p> "

$body = "$top $data " 

<# uncomment this if you want to see this as an HTML page.
convertto-html @convertParams | out-file $path

invoke-item $path
#>

$to = "sysadmin@example.com" # Add more email addresses, seperated by comma

$subject = "Priveledged count"

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