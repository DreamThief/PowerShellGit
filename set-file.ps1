function set-filez{
param (
[switch]$new ,
[switch]$old
)

if($new){
copy-item .\files\newFile.txt .\files\ztest.txt
}
elseif($old){
copy-item .\files\oldFile.txt .\files\ztest.txt
}
else{
write-host "Hey dumbass, you did not do anything!" -ForegroundColor Cyan
}
 

 }