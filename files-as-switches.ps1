$list = $null
$dir = $null
$path = $null

$dir = '.\desktop'

$path = get-childitem $dir

ForEach($i in $path){
    $list +=  '.\documents\' + $i.Name + ' , '
     }

write-host "somecommand.exe " $list -ForegroundColor green