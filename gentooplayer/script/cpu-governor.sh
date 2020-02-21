#!/bin/bash
function pausa() {
    echo
    read -s -p 'Press "Enter" to continue...'
    clear
    echo
}


echo -e "Available Governors for this CPU/kernel:"
echo -e "\e[1;38;5;88m$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors)\e[0m"

pausa

echo -e "Information on the CPU-governors will be displayed"

pausa

less /opt/.gentooplayer/script/governors.txt

nano /etc/default/gp.txt


/opt/.gentooplayer/GentooPlayer/gentooplayer/func/dietpi-set_cpu
