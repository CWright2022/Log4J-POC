echo "RESTARTING VICTIM MACHINE..."

cd 'C:\Program Files\Oracle\VirtualBox'

$vm_running = .\vboxmanage showvminfo "w10vuln" | grep -c "running (since"

if ($vm_running -eq 0)
{
    echo "VICTIM IS NOT RUNNING. STARTING..."
    .\vboxmanage startvm w10vuln --type headless
    echo "OPENING RDP SESSION..."
    Start-Job -ScriptBlock {plink -pw C@yden8616Wr!ght -batch -ssh pi@192.168.137.87 'sudo /home/pi/togglerdp.sh ; exit'>$null 2>&1}
    $j = Get-Job -Command "*plink*"
    $ID = $j.InstanceID
    sleep(1)
    Stop-Job -InstanceId $ID
    Remove-Job -InstanceId $ID
}

else
{
    echo "POWERING OFF..."
    .\vboxmanage controlvm w10vuln poweroff
    .\vboxmanage snapshot w10vuln restore usethisone
    .\vboxmanage startvm w10vuln --type headless
    Start-Job -ScriptBlock {plink -pw C@yden8616Wr!ght -batch -ssh pi@192.168.137.87 'sudo /home/pi/togglerdp.sh ; exit'>$null 2>&1}
    $j = Get-Job -Command "*plink*"
    $ID = $j.InstanceID
    sleep(2)
    Stop-Job -InstanceId $ID
    Remove-Job -InstanceId $ID
}
echo "DONE."
exit