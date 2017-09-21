$date = (get-date).adddays(-5)
get-aduser -Server $glserver -Credential $creds -filter {whenCreated -gt $date} -Properties * |
    select name, samaccountname, whencreated,employeenumber