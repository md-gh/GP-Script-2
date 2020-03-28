#!/bin/bash

function pausa() {
    echo
    read -s -p 'Press "Enter" to continue... or CTRL+C to exit'
    echo
}


function pausa1() {
    echo
    read -s -p 'Press "Enter" to continue and apply the changes... or CTRL+C to exit'
    clear
    echo
}

function pausa3() {
    echo
    read -s -p 'Press "Enter" to continue...'
    clear
    echo
}

cpum=$(cat /proc/cpuinfo | grep processor | wc -l |  awk '{print $1-1}')

if [ "$cpum" = 0 ]; then
    cpmax=$(echo "1")
elif [ "$cpum" = 1 ]; then
    cpmax=$(echo "2")
elif [ "$cpum" = 2 ]; then
    cpmax=$(echo "4")
elif [ "$cpum" = 3 ]; then
    cpmax=$(echo "8")
elif [ "$cpum" = 4 ]; then
    cpmax=$(echo "16")
elif [ "$cpum" = 5 ]; then
    cpmax=$(echo "32")
elif [ "$cpum" = 6 ]; then
    cpmax=$(echo "64")
elif [ "$cpum" = 7 ]; then
    cpmax=$(echo "128")
fi

#    echo -e "$cpus"

clear
echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
cat /proc/interrupts
echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
echo -e "IRQ already set"
#cho -e "\e[1;38;5;88m$(cat /etc/default/irq-affinity-start.sh | cut -b20-21)\e[0m"
echo -e "\e[1;38;5;88m$(cat /etc/default/irq-affinity-start.sh | awk '{print $4}' | sed 's/\///g'|sed 's/\procirq//g'|sed 's/\_//g' | sed 's/smpaffinity//g')\e[0m"
echo -e "cancel the current settings? y/n"
read cancellare
if [ "$cancellare" = "y" ]; then
    echo "#!/bin/bash" > /etc/default/irq-affinity-start.sh
fi
echo -e "IRQ already set"
#echo -e "\e[1;38;5;88m$(cat /etc/default/irq-affinity-start.sh | cut -b20-21)\e[0m"
echo -e "\e[1;38;5;88m$(cat /etc/default/irq-affinity-start.sh | awk '{print $4}' | sed 's/\///g'|sed 's/\procirq//g'|sed 's/\_//g' | sed 's/smpaffinity//g')\e[0m"
echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"

echo -e ""
echo -e ""
echo -e ""
read -p "Choose the IRQ to change the affinity:"  irq
#irqs=$(cat /proc/interrupts | egrep "$irq" |head -1 | sed 's/$irq\:\ //g' | awk  '{print $NF}')
irqs=$(cat /proc/interrupts | egrep "$irq:" | head -1 | awk  '{print $NF}')
echo -e ""
echo -e "\e[1;38;5;88m$irq\e[0m \e[38;5;154m----->\e[0m \e[1;38;5;88m$irqs\e[0m"

pausa
clear
echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
cat /proc/interrupts

echo -e ""
echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
echo -e "How the CPUs in hexadecimal are listed:"
echo -e ""
echo -e "CPU0 ----> \e[1;38;5;88m1\e[0m <---- corresponding number"
echo -e "CPU1 ----> \e[1;38;5;88m2\e[0m <---- corresponding number"
echo -e "CPU2 ----> \e[1;38;5;88m4\e[0m <---- corresponding number"
echo -e "CPU3 ----> \e[1;38;5;88m8\e[0m <---- corresponding number"
echo -e "CPU4 ----> \e[1;38;5;88m16\e[0m <---- corresponding number"
echo -e "CPU5 ----> \e[1;38;5;88m32\e[0m <---- corresponding number"
echo -e "CPU6 ----> \e[1;38;5;88m64\e[0m <---- corresponding number"
echo -e "CPU7 ----> \e[1;38;5;88m128\e[0m <---- corresponding number"
echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
echo -e ""
echo -e "eg: type \e[1;38;5;88m16\e[0m for affinity with cpu4"
echo -e "for affinity with more cpu make the sum 16+8=24  \e[1;38;5;88m24\e[0mfrom the affinity to cpu3 and cpu4 to the same IRQ"
echo -e "\e[1;38;5;88mf\e[0m is the default: affiliate with all the cpu"
echo -e "you see: \e[1;38;5;88mhttps://cs.uwaterloo.ca/~brecht/servers/apic/SMP-affinity.txt\e[0m"
echo -e ""
echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
echo -e ""
echo -e ""

echo -e "I will change the affinity for IRQ \e[1;38;5;88m$irq\e[0m \e[38;5;154m----->\e[0m \e[1;38;5;88m$irqs\e[0m"


read -p "Enter the number corresponding to the CPU, see above:"  cpu




if [ "$cpu" = 1 ]; then
    cpus=$(echo "CPU0")
elif [ "$cpu" = 2 ]; then
    cpus=$(echo "CPU1")
elif [ "$cpu" = 4 ]; then
    cpus=$(echo "CPU2")
elif [ "$cpu" = 8 ]; then
    cpus=$(echo "CPU3")
elif [ "$cpu" = 16 ]; then
    cpus=$(echo "CPU4")
elif [ "$cpu" = 32 ]; then
    cpus=$(echo "CPU5")
elif [ "$cpu" = 64 ]; then
    cpus=$(echo "CPU6")
elif [ "$cpu" = 128 ]; then
    cpus=$(echo "CPU7")
elif [ "$cpu" = f ]; then
    cpus=$(echo "Tutte le CPU")
else
    echo "incorrect value"
    exit 0
fi

function cpux() {
    cpun=$(echo $cpu)
    cpumxn=$(echo $cpmax)

    #echo "$cpun"
    #echo "$cpumxn"

    #pausa

    #read cpun
    if [ "$cpun" -gt "$cpumxn" ] ; then
        echo "incorrect value"
        exit 0
    else
        echo "$cpun"
    fi
}

cpux


echo -e "Change the affinity for \e[1;38;5;88m$irq\e[0m \e[38;5;154m----->\e[0m \e[1;38;5;88m$irqs\e[0m \e[38;5;154m----->\e[0m \e[1;38;5;88m$cpus\e[0m"

#    if [ "$cpu" > $cpmax ] && ; then
#     echo "incorrect value"
#     read -p "Change the affinity for $irqs - Enter the number corresponding to the CPU, see above:"  cpu
#  fi#
#
#

##read -p "Change the affinity for $irqs - Enter the number corresponding to the CPU, see above:"  cpu
#    if [ "$cpu" = 1 ]; then
#    cpus=$(echo "CPU0")
#    elif [ "$cpu" = 2 ]; then
#     cpus=$(echo "CPU1")
#     elif [ "$cpu" = 4 ]; then
#     cpus=$(echo "CPU2")
#     elif [ "$cpu" = 8 ]; then
#     cpus=$(echo "CPU3")
#     elif [ "$cpu" = 16 ]; then
#     cpus=$(echo "CPU4")
#     elif [ "$cpu" = 32 ]; then
#     cpus=$(echo "CPU5")
#     elif [ "$cpu" = 64 ]; then
#     cpus=$(echo "CPU6")
#     elif [ "$cpu" = 128 ]; then
#     cpus=$(echo "CPU7")
#     else
#     echo "incorrect value"
#     read -p "Change the affinity for $irqs - Enter the number corresponding to the CPU, see above:"  cpu
#    elif [ "$cpu" > $cpmax ]; then
#     echo "incorrect value"
#      read -p "Change the affinity for $irqs - Enter the number corresponding to the CPU, see above:"  cpu
#    fi



# echo -e "$cpus"





pausa

echo "echo "$cpu" > /proc/irq/$irq/smp_affinity" >> /etc/default/irq-affinity-start.sh




/etc/default/irq-affinity-start.sh

echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
echo -e "IRQ impostati"
#echo -e "\e[1;38;5;88m$(cat /etc/default/irq-affinity-start.sh | cut -b20-21)\e[0m"
echo -e "\e[1;38;5;88m$(cat /etc/default/irq-affinity-start.sh | awk '{print $4}' | sed 's/\///g'|sed 's/\procirq//g'|sed 's/\_//g' | sed 's/smpaffinity//g')\e[0m"
#echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
echo -e "\n \e[38;5;154m─────────────────────────────────────────────────────\e[0m\n \e[1mGentooPlayer irq-affinity\n\e[30m Use \e[1;38;5;88mirqadd \e[30mto add changes to the restart\n it is sufficient to do it only once - even if you change settings\e[0m\n \e[38;5;154m─────────────────────────────────────────────────────\e[0m"
