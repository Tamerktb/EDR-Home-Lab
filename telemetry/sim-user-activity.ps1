# Simulate Normal User Activity
# Generates baseline telemetry to distinguish from malicious activity

param(
    [int]$DurationMinutes = 5,
    [int]$ActivityInterval = 30
)

Write-Host "[*] Starting user activity simulation..."
Write-Host "[*] Duration: $DurationMinutes minutes, Interval: ${ActivityInterval}s"
Write-Host ""

$endTime = (Get-Date).AddMinutes($DurationMinutes)
$activityCount = 0

while ((Get-Date) -lt $endTime) {
    $activityCount++
    $action = Get-Random -Minimum 1 -Maximum 8

    Write-Host "[$activityCount] Activity: " -NoNewline

    switch ($action) {
        1 {
            Write-Host "File browsing" -ForegroundColor Cyan
            Get-ChildItem "C:\Users" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 50 | Out-Null
        }
        2 {
            Write-Host "Registry read" -ForegroundColor Cyan
            Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion" -ErrorAction SilentlyContinue | Out-Null
        }
        3 {
            Write-Host "Process listing" -ForegroundColor Cyan
            Get-Process | Select-Object -First 30 | Out-Null
        }
        4 {
            Write-Host "Network check" -ForegroundColor Cyan
            Test-NetConnection -ComputerName "8.8.8.8" -Port 443 -WarningAction SilentlyContinue | Out-Null
        }
        5 {
            Write-Host "DNS resolution" -ForegroundColor Cyan
            try {
                [System.Net.Dns]::GetHostAddresses("google.com") | Out-Null
            } catch {}
        }
        6 {
            Write-Host "Event log query" -ForegroundColor Cyan
            Get-WinEvent -LogName "System" -MaxEvents 10 -ErrorAction SilentlyContinue | Out-Null
        }
        7 {
            Write-Host "Service query" -ForegroundColor Cyan
            Get-Service | Where-Object { $_.Status -eq "Running" } | Select-Object -First 20 | Out-Null
        }
    }

    Start-Sleep -Seconds $ActivityInterval
}

Write-Host ""
Write-Host "[*] User activity simulation complete." -ForegroundColor Green
Write-Host "[*] Total activities: $activityCount"
