# Credential Dumping Simulation
# THIS IS A SIMULATION - creates the TTPs without actual dumping

Write-Host "[*] Simulating credential dumping TTPs..." -ForegroundColor Yellow

# Simulate LSASS process open (what Mimikatz does)
Write-Host "[+] Simulating LSASS process access..." -ForegroundColor Cyan
$lsass = Get-Process -Name "lsass" -ErrorAction SilentlyContinue
if ($lsass) {
    Write-Host "  LSASS PID: $($lsass.Id)"
    # Reading a tiny amount simulates the access
    try {
        $handle = [System.Diagnostics.Process]::GetProcessById($lsass.Id)
        Write-Host "  [+] Opened handle to LSASS (simulated TTP)"
    } catch {
        Write-Host "  [!] LSASS access blocked (as expected with EDR)"
    }
}

# Simulate registry dump of SAM
Write-Host "[+] Simulating SAM registry dump..." -ForegroundColor Cyan
$regPaths = @(
    "HKLM:\SAM\SAM",
    "HKLM:\SECURITY\SECURITY",
    "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
)
foreach ($path in $regPaths) {
    if (Test-Path $path) {
        Write-Host "  [+] Accessing: $path (simulated TTP)"
    }
}

# Simulate creating dump file
Write-Host "[+] Simulating dump file creation..." -ForegroundColor Cyan
$dumpFile = "$env:TEMP\lsass_dump.dmp"
"Simulated LSASS dump content" | Set-Content -Path $dumpFile -Force
Write-Host "  [+] Created: $dumpFile"

# Simulate extracting hashes via registry
Write-Host "[+] Simulating hash extraction..." -ForegroundColor Cyan
$samDump = "$env:TEMP\sam_dump.txt"
@"
Administrator:500:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
Guest:501:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
jdoe:1001:aad3b435b51404eeaad3b435b51404ee:5f4dcc3b5aa765d61d8327deb882cf99:::
"@ | Set-Content -Path $samDump -Force
Write-Host "  [+] Created simulated hash dump: $samDump"

Write-Host "[*] Credential dumping simulation complete." -ForegroundColor Green
Write-Host "[*] Check LimaCharlie for detections!" -ForegroundColor Yellow
