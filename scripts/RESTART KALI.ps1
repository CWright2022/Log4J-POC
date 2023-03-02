echo "RESTARTING ATTACKER MACHINE..."

cd 'C:\Program Files\Oracle\VirtualBox'

$vm_running = .\vboxmanage showvminfo "KaliAttacker" | grep -c "running (since"

if ($vm_running -eq 0)
{
    echo "VM IS NOT RUNNING. STARTING..."
    .\vboxmanage startvm KaliAttacker --type gui
}

else
{
    echo "POWERING OFF..."
    .\vboxmanage controlvm KaliAttacker poweroff
    .\vboxmanage snapshot KaliAttacker restore useme
    sleep(3)
    .\vboxmanage startvm KaliAttacker --type gui
}
echo "DONE."
exit