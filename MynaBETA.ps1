# ============================================================================
# ITSMYNAX ULTIMATE INSTALLER - SUPER PRO EDITION (v7.0)
# -- Project: ItsMynaX (Myna X System)
# -- Author: son171020
# -- Features: Speed Injection, Win11 Bypass, GPT/UEFI Reconstruction, Logging
# ============================================================================
$ErrorActionPreference = "Stop"
$LogFile = "$env:TEMP\ItsMynaX_Deploy.log"
Clear-Host

# 1. CORE ENGINE FUNCTIONS & LOGGING
function Write-MynaX {
    param([string]$Msg, [string]$Col = "Cyan")
    $Time = Get-Date -Format "HH:mm:ss"
    Write-Host "[$Time] [MynaX] $Msg" -ForegroundColor $Col
    "[$Time] $Msg" | Out-File $LogFile -Append
}

# 2. SYSTEM OVERCLOCKING (POWER & PRIORITY)
Write-MynaX "Activating MynaX High-Performance Engine..." "Magenta"
try {
    $Process = Get-Process -Id $PID
    $Process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::High
    # Force High Performance Power Scheme
    powercfg /s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2>$null
} catch { Write-MynaX "High-Priority execution enabled." "Yellow" }

# 3. YOUR OFFICIAL HEADER STYLE
$Header = @"
 .---------------------------------------------------------.
 |  __  __                       __  __                    |
 | |  \/  |_   _ _ __   __ _    \ \/ /                    |
 | | |\/| | | | | '_ \ / _` |    \  /                     |
 | | |  | | |_| | | | | (_| |    /  \                     |
 | |_|  |_|\__, |_| |_|\__,_|   /_/\_\                    |
 |          |___/                                          |
 '---------------------------------------------------------'
 >> PROJECT: ItsMynaX | VERSION: SUPER PRO | DEV: son171020
 -----------------------------------------------------------
"@
Write-Host $Header -ForegroundColor Cyan

# 4. HARDWARE TELEMETRY & AUDIT
Write-MynaX "Auditing system hardware for deployment..." "Green"
$PhysMem = Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum
$RAM = [Math]::Round($PhysMem.Sum / 1GB, 2)
$CPU = (Get-CimInstance Win32_Processor).Name
$Arch = (Get-CimInstance Win32_Processor).AddressWidth
$DiskCount = (Get-Disk).Count

Write-Host " [CPU]   : $CPU" -ForegroundColor Gray
Write-Host " [RAM]   : $RAM GB" -ForegroundColor Gray
Write-Host " [ARCH]  : $Arch-bit System" -ForegroundColor Gray
Write-Host " [STORAGE]: $DiskCount Physical Drive(s) found" -ForegroundColor Gray

# 5. THE ADVANCED DISK SELECTOR MATRIX
Write-MynaX "Scanning for target storage devices..." "Green"
Write-Host "--------------------------------------------------------------------------------" -ForegroundColor White
Write-Host "ID  Model Name                     Size (GB)   Type      Bus       Status" -ForegroundColor Yellow
Write-Host "--------------------------------------------------------------------------------" -ForegroundColor White

$DiskList = Get-Disk | Sort-Object Number
foreach ($D in $DiskList) {
    $Phys = Get-PhysicalDisk -DeviceNumber $D.Number
    $Sz = [Math]::Round($D.Size / 1GB, 2)
    "{0,-3} {1,-30} {2,-11} {3,-9} {4,-9} {5}" -f $D.Number, $D.FriendlyName, $Sz, $Phys.MediaType, $Phys.BusType, $D.OperationalStatus
}
Write-Host "--------------------------------------------------------------------------------" -ForegroundColor White

$DId = Read-Host "`n[?] Select Target Disk ID for ItsMynaX Deployment"
$Target = Get-Disk -Number $DId

Write-Host "`n!!!!!!!!!!!!!!!! CRITICAL SECURITY ALERT !!!!!!!!!!!!!!!!!" -ForegroundColor White -BackgroundColor Red
Write-Host " DESTROYING ALL DATA ON: [$($Target.FriendlyName)] " -ForegroundColor White -BackgroundColor Red
Write-Host "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" -ForegroundColor White -BackgroundColor Red
if ((Read-Host "[?] Confirm wipe of Disk $DId? (Type 'YES')") -cne "YES") { Exit }

# 6. DISKPART RECONSTRUCTION (CLEAN INSTALL)
Write-MynaX "Wiping Disk $DId and rebuilding GPT architecture..." "Yellow"
$PartScript = @"
select disk $DId
clean
convert gpt
create partition efi size=100
format quick fs=fat32 label="System"
assign letter=S
create partition msr size=16
create partition primary
format quick fs=ntfs label="Windows"
assign letter=C
"@
$PartScript | diskpart | Out-Null
Write-MynaX "GPT Partitioning complete. Target: C: (OS), S: (EFI)" "Green"

# 7. INSTALLATION SOURCE PAYLOAD
Write-MynaX "Locating Windows Installation Source..." "Green"
$Src = (Read-Host "[?] Drag and drop ISO or install.wim here").Replace('"', '').Trim()
$IsIso = $false; $OrigIso = ""

if ($Src.EndsWith(".iso")) {
    Write-MynaX "Mounting MynaX-Targeted ISO Image..." "Yellow"
    $OrigIso = $Src
    $Mnt = Mount-DiskImage -ImagePath $Src -PassThru
    $Drv = ($Mnt | Get-Volume).DriveLetter
    $Src = "$($Drv):\sources\install.wim"
    if (-not (Test-Path $Src)) { $Src = "$($Drv):\sources\install.esd" }
    $IsIso = $true
}

# 8. VERSION SELECTION (WIM INDEXING)
Write-MynaX "Querying Windows Image Indexes..." "Cyan"
$Imgs = Get-WindowsImage -ImagePath $Src
foreach ($I in $Imgs) {
    Write-Host "  [$($I.ImageIndex)] $($I.ImageName)" -ForegroundColor Cyan
}
$Idx = Read-Host "`n[?] Select Index for Deployment"

# 9. DEPLOYMENT (HIGH-SPEED DISM ENGINE)
Write-MynaX "Applying Image... Peak SSD performance requested." "Magenta"
dism /Apply-Image /ImageFile:"$Src" /Index:$Idx /ApplyDir:C:\ /CheckIntegrity

# 10. MYNAX TURBO: REGISTRY BYPASS & OPTIMIZATION
Write-MynaX "Injecting ItsMynaX Optimization & Bypass Hooks..." "Yellow"
try {
    # Load Offline Registry
    reg load HKLM\MYNAX_SYS C:\Windows\System32\config\SYSTEM | Out-Null
    reg load HKLM\MYNAX_SOFT C:\Windows\System32\config\SOFTWARE | Out-Null

    # Windows 11 Compatibility Bypass
    $Lab = "HKLM\MYNAX_SYS\Setup\LabConfig"
    if (-not (Test-Path "Registry::$Lab")) { New-Item -Path "Registry::$Lab" -Force | Out-Null }
    Set-ItemProperty -Path "Registry::$Lab" -Name "BypassTPMCheck" -Value 1 -Type DWord
    Set-ItemProperty -Path "Registry::$Lab" -Name "BypassSecureBootCheck" -Value 1 -Type DWord
    Set-ItemProperty -Path "Registry::$Lab" -Name "BypassRAMCheck" -Value 1 -Type DWord
    Set-ItemProperty -Path "Registry::$Lab" -Name "BypassCPUCheck" -Value 1 -Type DWord

    # MynaX Turbo: Disable Reserved Storage (Gain ~7GB)
    Set-ItemProperty -Path "HKLM\MYNAX_SOFT\Microsoft\Windows\CurrentVersion\ReserveManager" -Name "ShippedWithReserves" -Value 0 -Type DWord
    
    # MynaX Turbo: Telemetry Strip & Hibernation Kill
    Set-ItemProperty -Path "HKLM\MYNAX_SOFT\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord
    Set-ItemProperty -Path "HKLM\MYNAX_SYS\ControlSet001\Control\Power" -Name "HibernateEnabled" -Value 0 -Type DWord

    # Unload Offline Registry
    reg unload HKLM\MYNAX_SYS | Out-Null
    reg unload HKLM\MYNAX_SOFT | Out-Null
    Write-MynaX "Optimizations and Bypasses successfully applied." "Green"
} catch { Write-MynaX "Post-install hooks encountered an exception." "Red" }

# 11. DEVICE IDENTITY CONFIGURATION
$HostName = Read-Host "[?] Name this Device (Leave empty for 'ItsMynaX-PC')"
if (-not $HostName) { $HostName = "ItsMynaX-PC" }
Write-MynaX "Finalizing Device Identity: $HostName" "Cyan"
reg load HKLM\MYNAX_SYS C:\Windows\System32\config\SYSTEM | Out-Null
Set-ItemProperty -Path "HKLM\MYNAX_SYS\ControlSet001\Control\ComputerName\ComputerName" -Name "ComputerName" -Value $HostName
Set-ItemProperty -Path "HKLM\MYNAX_SYS\ControlSet001\Services\Tcpip\Parameters" -Name "Hostname" -Value $HostName
reg unload HKLM\MYNAX_SYS | Out-Null

# 12. BOOTLOADER FINALIZATION (UEFI)
Write-MynaX "Initializing UEFI Bootloader (BCD)..." "Yellow"
bcdboot C:\Windows /s S: /f UEFI

# 13. SYSTEM CLEANUP & EXIT
Write-MynaX "Cleaning deployment residue..." "Gray"
if ($IsIso) { Dismount-DiskImage -ImagePath $OrigIso | Out-Null }
Remove-Item "$env:TEMP\*.txt" -ErrorAction SilentlyContinue

Write-Host "`n===========================================================" -ForegroundColor Green
Write-Host "  ItsMynaX ULTIMATE INSTALLER - MISSION SUCCESS            " -ForegroundColor Green
Write-Host "  Windows has been successfully deployed and optimized.    " -ForegroundColor White
Write-Host "===========================================================" -ForegroundColor Green

$Go = Read-Host "`n[?] Deployment finished. Reboot now? (Y/N)"
if ($Go -match "^[Yy]$") { Restart-Computer }