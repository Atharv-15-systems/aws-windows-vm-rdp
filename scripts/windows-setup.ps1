# Run in an elevated PowerShell on the Windows Server instance.
# Creates a low-privilege RDP user, enables Windows Firewall, sets a lockout
# policy and creates a test file. The password is prompted for, never stored.

$pw = Read-Host -AsSecureString "Enter a strong password for labuser"
New-LocalUser -Name "labuser" -Password $pw -FullName "Lab User" `
  -Description "Standard user for Unit 4 assignment"
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "labuser"

net accounts /lockoutthreshold:5 /lockoutduration:30 /lockoutwindow:30

Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
Get-NetFirewallProfile | Select-Object Name, Enabled, DefaultInboundAction

New-Item -Path "C:\Lab" -ItemType Directory -Force | Out-Null
Set-Content -Path "C:\Lab\hello.txt" -Value "Unit 4 - Cloud Security Assignment. Windows VM on AWS EC2 accessed via RDP."
Get-Content "C:\Lab\hello.txt"
