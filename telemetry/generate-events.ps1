# EDR Telemetry Generator
# Simulates various user and attacker activities to trigger EDR alerts

Write-Host "============================================"
Write-Host "  EDR Telemetry Generator"
Write-Host "  Running attack simulations..."
Write-Host "============================================"
Write-Host ""

# --- Phase 1: User Simulation ---
Write-Host "[Phase 1] Simulating normal user activity..." -ForegroundColor Green

# Browse files
Write-Host "  Opening documents..."
Get-ChildItem "C:\Users\Public\Documents" -Recurse -ErrorAction SilentlyContinue | Out-Null

# Browse websites (simulated)
Write-Host "  Simulating web browsing..."
$null = New-Object Net.WebClient

# Use Office-like processes
Write-Host "  Opening Office applications..."
Start-Process "notepad.exe" -WindowStyle Hidden
Start-Process "calc.exe" -WindowStyle Hidden

Start-Sleep -Seconds 2

# --- Phase 2: Reconnaissance ---
Write-Host "[Phase 2] Simulating recon activity..." -ForegroundColor Yellow

# Network scanning
Write-Host "  Enumerating network..."
Get-NetIPAddress -AddressFamily IPv4 | Out-Null
Get-NetTCPConnection | Out-Null
Get-NetNeighbor | Out-Null

# User enumeration
Write-Host "  Enumerating users..."
Get-LocalUser | Out-Null
Get-LocalGroupMember -Group "Administrators" | Out-Null

Start-Sleep -Seconds 2

# --- Phase 3: Suspicious Activity ---
Write-Host "[Phase 3] Simulating suspicious activity..." -ForegroundColor Red

# Suspicious PowerShell
Write-Host "  Base64 encoded command..."
$b64 = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("Write-Host 'EDR Test'"))
powershell.exe -WindowStyle Hidden -EncodedCommand $b64

# WMI queries
Write-Host "  WMI process query..."
Get-WmiObject -Class Win32_Process | Out-Null

# Registry access
Write-Host "  Registry enumeration..."
Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -ErrorAction SilentlyContinue | Out-Null

Start-Sleep -Seconds 2

# --- Phase 4: Attack Simulation ---
Write-Host "[Phase 4] Simulating malicious behavior..." -ForegroundColor Red

# Process injection-like behavior
Write-Host "  Opening process handles..."
$targets = @("explorer", "notepad", "svchost")
foreach ($t in $targets) {
    try {
        $p = Get-Process -Name $t -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($p) { $p.Id | Out-Null }
    } catch {}
}

# Scheduled task creation
Write-Host "  Creating scheduled task (local)..."
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -Command Write-Host"
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(5)
try {
    Register-ScheduledTask -TaskName "WindowsHealthCheck" -Action $action -Trigger $trigger -User "SYSTEM" -Force
} catch {}

# File creation (simulated ransomware note)
Write-Host "  Dropping test files..."
Set-Content -Path "$env:TEMP\README_LOCKED.txt" -Value "Test alert file" -Force

Write-Host ""
Write-Host "============================================"
Write-Host "  Telemetry generation complete!"
Write-Host "  Check LimaCharlie for detection alerts."
Write-Host "============================================" -ForegroundColor Green
