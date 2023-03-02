$response = Read-Host "STOPPING ALL LOG4J RELATED PROCESSES - ARE YOU SURE?"
if ($response -ne "y")
{
    exit
}
$response = Read-Host "shut down RasPi?"
if ($response -eq "y")
{
echo "shutting down RasPi..."
Start-Job -ScriptBlock {plink -pw C@yden8616Wr!ght -batch -ssh pi@192.168.137.87 'sudo shutdown now'}
$j = Get-Job -Command "*plink*"
$ID = $j.InstanceID
sleep(2)
Stop-Job -InstanceId $ID
Remove-Job -InstanceId $ID
}
cd 'C:\Program Files\Oracle\VirtualBox'
echo "powering off victim..."
.\vboxmanage controlvm w10vuln poweroff
echo "restoring victim state..."
.\vboxmanage snapshot w10vuln restore usethisone
echo "powering off attacker..."
.\vboxmanage controlvm KaliAttacker poweroff
echo "restoring attacker state..."
.\vboxmanage snapshot KaliAttacker restore useme
echo "quitting Minecraft..."
Get-Process -Name "*minecraft*" | Stop-Process
Get-Process -Name "*javaw*" | Stop-Process
echo "quitting notepad..."
Get-Process -Name "*notepad*" | Stop-Process
echo "quitting Quasar..."
Get-Process -Name "*quasar*" | Stop-Process
echo "setting display mode back to Extend..."
displayswitch.exe /extend
echo "disabling connection sharing..."
Disable-Ics
echo "ALL DONE"