# Variables
## Ubuntu download
$iso_url = "https://releases.ubuntu.com/22.04.2/ubuntu-22.04.2-live-server-amd64.iso"
$iso_outfile = "C:\HYPER-V\ubuntu-22.04.2-live-server-amd64.iso"

## Local paths for VM
$vm_name = "ubuntu_web"
$vm_path = "C:\HYPER-V\ubuntu_web"
$vhd_path = "C:\HYPER-V\ubuntu_web\ubuntu_web.vhdx"
$switch_name = "New Virtual Switch"

# Download ubuntu installer
$ProgressPreference = "SilentlyContinue"
if (!(Test-Path -Path $iso_outfile)) {
    Invoke-WebRequest -Uri $iso_url -Outfile $iso_outfile
}

# Create VM
New-VM -Name $vm_name -MemoryStartupBytes 2GB -Path $vm_path -NewVHDPath $vhd_path -NewVHDSizeBytes 20GB -Generation 2 -SwitchName $switch_name  -Force

# Mount iso
Add-VMDvdDrive -VMName $vm_name -Path $iso_outfile

# Set VM firmware options
Set-VMFirmware -VMName $vm_name -EnableSecureBoot Off -BootOrder $(Get-VMDvdDrive -VMName $vm_name), $(Get-VMHardDiskDrive -VMName $vm_name), $(Get-VMNetworkAdapter -VMName $vm_name)

# Start VM
Start-VM -VMName $vm_name