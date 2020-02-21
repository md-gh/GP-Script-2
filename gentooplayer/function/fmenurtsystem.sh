#!/bin/bash


####################### RT System ##############################################
rts(){
    clear
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo -e ""
    echo -e "        $color1"GentooPlayer"$color_off - $BBlue"RTSystem"$Color_Off"
    echo -e ""
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo -e " [1] Opens the RTirq configuration wizard"
    echo -e " [2] Opens the RTirq configuration file for system irq priorities"
    echo -e " [3] Add RTirq on startup"
    echo -e " [4] Remove RTirq from startup"
    echo -e " [5] RT Check - rtcheck will show some important information about your system"
    echo -e " [6] RT Monitor IRQ - For checking the realtime utilization you can start rtmonitorirq"
    echo -e " [7] RT Reset - reset all real time priority (irq and applications) to SCHED_OTHER"
    echo -e " [8] RT Status - show the status of irq and applications realtime priorities"
    echo -e " [9] RT Cards - It is very useful for checking if your audio card is sharing IRQ with another device"
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo
    echo -e " [10] $BBlue"System Menu"$Color_Off"
    echo -e " [11] $BBlue"Main Menu"$Color_Off"
    echo -e " [0]  $BBlue"Exit"$Color_Off"
    echo -e ""
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo -e ""
    echo -e "$Green"Choose your operation:"$Color_Off"
    echo ""
    read -p  " [0 - 11]:" play
    echo -e ""
    case $play in

        1)
            rtirqconf
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; rts ;;
        2)
            rtirqc
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; rts ;;
        3)
            rtirqadd
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; rts ;;
        4)
            rtirqremove
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; rts ;;
        5)
            rtcheck
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; rts ;;
        6)
            rtmonitorirq
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; rts ;;
        7)
            rtreset
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; rts ;;
        8)
            rtstatus
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; rts ;;
        9)
            rtcards
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; rts ;;
        10) systemm ;;
        11) menu ;;
        0) esci ;;
        *) echo -e "$Red Invalid choice...$Color_Off" && sleep 2 ; rts ;;
    esac
}
