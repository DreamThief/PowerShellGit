Start-UdDashboard -AutoReload -port 8080 -Content {


$Page1 = New-UDPage -Name "Home" -Icon home -Content {

                New-UdRow {
                    New-UdColumn -Size 3  -Content {
                        New-UdChart -Title "Memory by Process"  @colors -Type Doughnut -RefreshInterval 5 -Endpoint {
                            Get-Process | ForEach-Object { [PSCustomObject]@{ Name = $_.Name; WorkingSet = [Math]::Round($_.WorkingSet / 1MB, 2) }} |  Out-UDChartData -DataProperty "WorkingSet" -LabelProperty Name
                        } -Options @{
                            legend = @{
                                display = $false
                            }
                        }
                    }
                    New-UdColumn -Size 3   -Content {
                        New-UdChart -Title "CPU by Process"  @colors -Type Doughnut -RefreshInterval 5 -Endpoint {
                            Get-Process | ForEach-Object { [PSCustomObject]@{ Name = $_.Name; CPU = $_.CPU } } |  Out-UDChartData -DataProperty "CPU" -LabelProperty Name
                        } -Options @{
                            legend = @{
                                display = $false
                            }
                        }
                    }
                    New-UdColumn -Size 3  -Content {
                        New-UdChart -Title "Handle Count by Process"  @colors -Type Doughnut -RefreshInterval 5 -Endpoint {
                            Get-Process | Out-UDChartData -DataProperty "HandleCount" -LabelProperty Name
                        } -Options @{
                            legend = @{
                                display = $false
                            }
                        }
                    }
                    New-UdColumn -Size 3 -Content {
                        New-UdChart -Title "Threads by Process"  @colors -Type Doughnut -RefreshInterval 5 -Endpoint {
                            Get-Process | ForEach-Object { [PSCustomObject]@{ Name = $_.Name; Threads = $_.Threads.Count } } |  Out-UDChartData -DataProperty "Threads" -LabelProperty Name
                        } -Options @{
                            legend = @{
                                display = $false
                            }
                        }
                    }
                }
 }    



$Page2 = New-UDPage -Name "Links" -Icon link -Content { 

               New-UdRow {
                    New-UdColumn -Size 12 -Content {
                        New-UdChart -Title "Disk Space by Drive"  @colors -Type Bar -AutoRefresh -Endpoint {
                            Get-CimInstance -ClassName Win32_LogicalDisk | ForEach-Object {
                                    [PSCustomObject]@{ DeviceId = $_.DeviceID;
                                                       Size = [Math]::Round($_.Size / 1GB, 2);
                                                       FreeSpace = [Math]::Round($_.FreeSpace / 1GB, 2); } } | Out-UDChartData -LabelProperty "DeviceID" -Dataset @(
                                New-UdChartDataset -DataProperty "Size" -Label "Size" -BackgroundColor "#80962F23" -HoverBackgroundColor "#80962F23"
                                New-UdChartDataset -DataProperty "FreeSpace" -Label "Free Space" -BackgroundColor "#8014558C" -HoverBackgroundColor "#8014558C"
                            )
                        }
                    }
                }
            }





    
New-UDDashboard @colors -Pages @($Page1, $Page2)

}