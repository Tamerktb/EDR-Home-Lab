# Ransomware Simulation (Benign - No actual encryption)
# RUN WITH CAUTION - generates noise that EDR will detect

Write-Host "[*] Starting ransomware simulation..." -ForegroundColor Red
Write-Host "[!] This is a SIMULATION - no files will be encrypted" -ForegroundColor Yellow

# Create simulated ransomware notes
Write-Host "[+] Dropping ransomware notes..." -ForegroundColor Cyan
$locations = @(
    "C:\Users\Public\Desktop\READ_ME_TO_DECRYPT.html",
    "C:\Users\Public\Documents\HOW_TO_DECRYPT.txt",
    "C:\Users\Public\RECOVER_FILES.hta"
)

$noteContent = @"
<html>
<body>
<h1>YOUR FILES HAVE BEEN ENCRYPTED</h1>
<p>This is a LAB SIMULATION. No files were actually encrypted.</p>
<p>Contact: simulation@lab.local</p>
</body>
</html>
"@

foreach ($loc in $locations) {
    Set-Content -Path $loc -Value $noteContent -Force
    Write-Host "  [+] Dropped: $loc"
}

# Simulate file extension changes
Write-Host "[+] Creating simulated encrypted file markers..." -ForegroundColor Cyan
$targetFiles = Get-ChildItem -Path "C:\Users\Public\Documents" -File
foreach ($file in $targetFiles) {
    $encryptedPath = "$($file.FullName).locker"
    Copy-Item -Path $file.FullName -Destination $encryptedPath -Force
    Write-Host "  [+] Created: $encryptedPath"
}

# Simulate volume shadow copy deletion
Write-Host "[+] Simulating Volume Shadow Copy deletion..." -ForegroundColor Cyan
Write-Host "  [+] vssadmin delete shadows /all /quiet (simulated)"

# Simulate spreading via network shares
Write-Host "[+] Simulating lateral movement..." -ForegroundColor Cyan
$shares = @("ADMIN$", "C$", "IPC$")
foreach ($share in $shares) {
    Write-Host "  [+] Attempted connection to \\localhost\$share"
}

# Simulate beaconing
Write-Host "[+] Simulating C2 beaconing..." -ForegroundColor Cyan
$c2Servers = @("185.234.72.18", "103.45.67.89", "evil-c2.local")
foreach ($c2 in $c2Servers) {
    try {
        $null = Test-NetConnection -ComputerName $c2 -Port 443 -WarningAction SilentlyContinue
    } catch {}
    Write-Host "  [+] Beaconing to $c2`:443 (simulated)"
}

Write-Host "[*] Ransomware simulation complete!" -ForegroundColor Green
Write-Host "[*] Check LimaCharlie detections for: New File, Network Connections, PowerShell activity"
