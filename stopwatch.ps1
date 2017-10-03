cls
$StopWatch = [Diagnostics.Stopwatch]::StartNew()
Write-host ""
Write-host "oops"
Start-Sleep -Seconds 2
Write-host ""
Write-host "Wait for it..."
Start-Sleep -Seconds 2
Write-host ""
Write-host "Oops I did it again... UNH!"
Start-Sleep -Seconds 2

$StopWatch.Stop()	

#$StopWatch.elapsed
write-host ""
write-host "Ths took "$StopWatch.elapsed.hours" hours "$StopWatch.elapsed.minutes" minutes and "$StopWatch.elapsed.seconds" seconds "
write-host ""
write-host "Ths took $($StopWatch.elapsed.hours) hours $($StopWatch.elapsed.minutes) minutes and $($stopWatch.elapsed.seconds) seconds "