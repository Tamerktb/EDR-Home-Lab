# Windows Victim Setup Script
# Run on the Windows VM before deploying LimaCharlie

Write-Host "[*] Disabling Windows Defender (for lab purposes only)..." -ForegroundColor Yellow
Set-MpPreference -DisableRealtimeMonitoring $true
Set-MpPreference -DisableIntrusionPreventionSystem $true
Set-MpPreference -DisableBehaviorMonitoring $true
Set-MpPreference -DisableBlockAtFirstSeen $true

Write-Host "[*] Creating lab user accounts..." -ForegroundColor Cyan
$users = @("jdoe", "asmith", "backup_admin")
foreach ($user in $users) {
    $password = ConvertTo-SecureString "LabPassword123!" -AsPlainText -Force
    try {
        New-LocalUser -Name $user -Password $password -FullName $user -Description "Lab user"
        Add-LocalGroupMember -Group "Users" -Member $user
        Write-Host "  [+] Created user: $user"
    } catch {
        Write-Host "  [!] User $user may already exist: $_"
    }
}

Write-Host "[*] Creating sensitive files for telemetry..." -ForegroundColor Cyan
$paths = @(
    "C:\Users\Public\Documents\passwords.txt",
    "C:\Users\Public\Documents\customer_data.csv",
    "C:\Users\Public\Documents\financial_report.xlsx"
)
foreach ($path in $paths) {
    Set-Content -Path $path -Value "CONFIDENTIAL - DO NOT SHARE - LAB USE ONLY"
}

Write-Host "[*] Installing Sysmon..." -ForegroundColor Cyan
$sysmonUrl = "https://download.sysinternals.com/files/Sysmon.zip"
$sysmonZip = "$env:TEMP\Sysmon.zip"
$sysmonDir = "$env:TEMP\Sysmon"
Invoke-WebRequest -Uri $sysmonUrl -OutFile $sysmonZip
Expand-Archive -Path $sysmonZip -DestinationPath $sysmonDir -Force

Write-Host "[*] Please install LimaCharlie sensor manually."
Write-Host "[*] Download from: https://app.limacharlie.io/ -> Install -> Windows Sensor"
Write-Host "[*] Use the install key from your LimaCharlie console." -ForegroundColor Green

Write-Host "[*] Setup complete. Reboot recommended." -ForegroundColor Green
