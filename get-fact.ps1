function get-fact {
$random = get-content .\files\random.txt | get-random
write-host $random -ForegroundColor Yellow
}