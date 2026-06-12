# LimaCharlie Sensor Installation Helper
# Replace YOUR_INSTALL_KEY with the key from your LimaCharlie console

param(
    [Parameter(Mandatory=$true)]
    [string]$InstallKey
)

Write-Host "[*] Downloading LimaCharlie sensor..." -ForegroundColor Cyan
$sensorUrl = "https://repo.limacharlie.io/windows/sensor.exe"
$sensorPath = "$env:TEMP\limacharlie-sensor.exe"

Invoke-WebRequest -Uri $sensorUrl -OutFile $sensorPath

Write-Host "[*] Installing LimaCharlie sensor..." -ForegroundColor Cyan
Start-Process -FilePath $sensorPath -ArgumentList "--install $InstallKey" -Wait -NoNewWindow

Write-Host "[+] LimaCharlie sensor installed successfully!" -ForegroundColor Green
Write-Host "[+] Check the sensor status at: https://app.limacharlie.io/" -ForegroundColor Green
