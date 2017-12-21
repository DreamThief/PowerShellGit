
$Colors = @{
    BackgroundColor = "#FF252525"
    FontColor = "#FFFFFFFF"
}

Start-UdDashboard -AutoReload -port 8080 -Content {


$Page1 = New-UDPage -Name "Home" -Icon home -Content { New-UDCard }    
$Page2 = New-UDPage -Name "Links" -Icon link -Content { New-UDCard }    
New-UDDashboard @colors -Pages @($Page1, $Page2)



    New-UdDashboard -Title "Server Performance Dashboard" @colors -Content {
        New-UdRow {
            New-UdColumn -Size 6 -Content {
                New-UdRow {
                    New-UdColumn -Size 12 -Content {
                        New-UdTable -Title "Server Information" -Headers @(" ", " ") @colors -Endpoint {
                            @{
                                'Computer Name' = $env:COMPUTERNAME
                                'Operating System' = (Get-CimInstance -ClassName Win32_OperatingSystem).Caption
                                'Total Disk Space (C:)' = (Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='C:'").Size / 1GB | ForEach-Object { "$([Math]::Round($_, 2)) GBs " }
                                'Free Disk Space (C:)' = (Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='C:'").FreeSpace / 1GB | ForEach-Object { "$([Math]::Round($_, 2)) GBs " }
                            }.GetEnumerator() | Out-UDTableData -Property @("Name", "Value")
                        }
                    }
                }
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
            New-UdColumn -Size 6 -Content {
                New-UdRow {
                    New-UdColumn -Size 6 -Content {
                        New-UdMonitor  @colors -Title "CPU (% processor time)" -Type Line -DataPointHistory 20 -RefreshInterval 5 -ChartBackgroundColor '#80FF6B63' -ChartBorderColor '#FFFF6B63'  -Endpoint {
						    try {
								Get-Counter '\Processor(_Total)\% Processor Time' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue | Out-UDMonitorData
							}
                            catch {
								0 | Out-UDMonitorData
							}
                        }
                    }
                    New-UdColumn -Size 6 -Content {
                        New-UdMonitor @colors -Title "Memory (% in use)" -Type Line -DataPointHistory 20 -RefreshInterval 5 -ChartBackgroundColor '#8028E842' -ChartBorderColor '#FF28E842'  -Endpoint {
							try {
								Get-Counter '\memory\% committed bytes in use' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue | Out-UDMonitorData
							}
                            catch {
								0 | Out-UDMonitorData
							}
                        }
                    }
                }
                New-UdRow {
                    New-UdColumn -Size 6 -Content {
                        New-UdMonitor @colors -Title "Network (IO Read Bytes/sec)" -Type Line -DataPointHistory 20 -RefreshInterval 5 -ChartBackgroundColor '#80E8611D' -ChartBorderColor '#FFE8611D'  -Endpoint {
							try {
								Get-Counter '\Process(_Total)\IO Read Bytes/sec' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue | Out-UDMonitorData
							}
                            catch {
								0 | Out-UDMonitorData
							}
                        }
                    }
                    New-UdColumn -Size 6 -Content {
                        New-UdMonitor @colors -Title "Disk (% disk time)" -Type Line -DataPointHistory 20 -RefreshInterval 5 -ChartBackgroundColor '#80E8611D' -ChartBorderColor '#FFE8611D'  -Endpoint {
							try {
								Get-Counter '\physicaldisk(_total)\% disk time' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue | Out-UDMonitorData
							}
							catch {
								0 | Out-UDMonitorData
							}
                        }
                    }
                }
                New-UdRow {
                    New-UdColumn -Size 12 {
                        New-UdGrid -Title "Processes"  @colors -Headers @("Name", "ID", "Working Set", "CPU") -Properties @("Name", "Id", "WorkingSet", "CPU") -AutoRefresh -RefreshInterval 60 -Endpoint {
                            Get-Process | Out-UDGridData
                        }
                    }
                }
            }
        }
    }
}