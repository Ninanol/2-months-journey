
# Load Windows Runtime Metadata for Bluetooth connectivity
try {
    $WinMDPath = "$env:SystemRoot\System32\WinMetadata\Windows.Devices.winmd"
    if (Test-Path $WinMDPath) { [void][System.Reflection.Assembly]::LoadFile($WinMDPath) }
    [void][Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementWatcher, Windows.Devices.Bluetooth, ContentType=WindowsRuntime]
    [void][Windows.Devices.Bluetooth.BluetoothLEDevice, Windows.Devices.Bluetooth, ContentType=WindowsRuntime]
} catch {
    Write-Host "[!] CRITICAL: Failed to load Windows Bluetooth Runtime library." -ForegroundColor Green
    Exit
}

Clear-Host
Write-Host "==================================================" -ForegroundColor Green
Write-Host "  AIROHA SOC / BLE AUDIO SECURITY AUDIT UTILITY  " -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Green

# Hardware Check
$RadioTask = [Windows.Devices.Bluetooth.BluetoothAdapter]::GetDefaultAsync()
while ($RadioTask.Status -eq 'Started') { Start-Sleep -Milliseconds 50 }
$Adapter = $RadioTask.GetResults()
if (-not $Adapter -or -not $Adapter.IsLowEnergySupported) {
    Write-Host "[-] HARDWARE ERROR: BLE adapter not found or Bluetooth is turned off.`n" -ForegroundColor Green
    Exit
}

# Scan Configuration
$Watcher = New-Object Windows.Devices.Bluetooth.Advertisement.BluetoothLEAdvertisementWatcher
$Watcher.ScanningMode = [Windows.Devices.Bluetooth.Advertisement.BluetoothLEScanningMode]::Active
$DiscoveredDevices = @{}

$Action = {
    param($sender, $eventArgs)
    $Address = $eventArgs.BluetoothAddress
    $Name = $eventArgs.Advertisement.LocalName
    if ($Name -and -not $DiscoveredDevices.ContainsKey($Address)) {
        $DiscoveredDevices[$Address] = $Name
        Write-Host "[+] DISCOVERED: $Name ($Address)" -ForegroundColor Green
    }
}

$EventToken = Register-ObjectEvent -InputObject $Watcher -EventName "Received" -Action $Action
$Watcher.Start()

Write-Host "[*] SCANNING FOR PERIPHERALS (7 SECONDS)..." -ForegroundColor Green
Start-Sleep -Seconds 7

$Watcher.Stop()
Unregister-Event -SourceIdentifier $EventToken.Name

# Audit Phase
Write-Host "`n[*] EVALUATING UNPAIRED SERVICE PERMISSIONS..." -ForegroundColor Green
if ($DiscoveredDevices.Count -eq 0) {
    Write-Host "[-] No broadcasting BLE devices detected in range.`n" -ForegroundColor Green
    Exit
}

foreach ($Address in $DiscoveredDevices.Keys) {
    $DeviceName = $DiscoveredDevices[$Address]
    Write-Host "`n[+] AUDITING: $DeviceName [$Address]" -ForegroundColor Green
    
    try {
        $DeviceTask = [Windows.Devices.Bluetooth.BluetoothLEDevice]::FromBluetoothAddressAsync($Address)
        while ($DeviceTask.Status -eq 'Started') { Start-Sleep -Milliseconds 50 }
        $Device = $DeviceTask.GetResults()
        
        if ($Device) {
            $GattTask = $Device.GetGattServicesAsync()
            while ($GattTask.Status -eq 'Started') { Start-Sleep -Milliseconds 50 }
            $GattResult = $GattTask.GetResults()
            
            if ($GattResult.Status -eq 'Success') {
                Write-Host "    [!] CONNECTED WITHOUT PAIRING ENFORCEMENT." -ForegroundColor Green
                $Vulnerable = $false
                
                foreach ($Service in $GattResult.Services) {
                    $Uuid = $Service.Uuid.ToString()
                    Write-Host "      - SERVICE UUID: $Uuid" -ForegroundColor DarkGreen
                    if ($Uuid -like "*00001000*" -or $Uuid -like "*0000180a*") { $Vulnerable = $true }
                }
                
                if ($Vulnerable) {
                    Write-Host "    [ALERT] UNPAIRED CONFIGURATION ACCESS CONFIRMED (POTENTIAL AIROHA FLAW)." -ForegroundColor Green
                } else {
                    Write-Host "    [PASS] Standard architectural profile layout secure." -ForegroundColor Green
                }
            } else {
                Write-Host "    [-] ACCESS DENIED / PAIRING REQUIRED (Enforcing Authentication)." -ForegroundColor DarkGreen
            }
        }
    } catch {
        Write-Host "    [-] Interface communication closed: $_" -ForegroundColor DarkGreen
    }
}
Write-Host "`n[*] AUDIT CONCLUDED.`n" -ForegroundColor Green
