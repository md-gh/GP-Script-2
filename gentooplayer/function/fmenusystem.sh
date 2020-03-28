#!/bin/bash


####################### System Menu ############################################
systemm(){
    clear
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo -e ""
    echo -e "        $color1"GentooPlayer"$color_off - $BBlue"SystemMenu"$Color_Off"
    echo -e ""
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo -e " [1] Base System"
    echo -e " [2] CPU and Process-Setting"
    echo -e " [3] RT System"
    echo -e " [4] Configure System"
    echo -e " [5] $BBlue"Main Menu"$Color_Off"
    echo -e " [0] $BBlue"Exit"$Color_Off"
    echo -e ""
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo -e ""
    echo -e "$Green"Choose your operation:"$Color_Off"
    echo ""
    read -p  " [0 - 5]:" play
    echo -e ""
    case $play in

        1) systemb ;;
        2) cpum ;;
        3) rts ;;
        4) confs ;;
        5) menu ;;
        0) esci ;;
        *) echo -e "$Red Invalid choice...$Color_Off" && sleep 2 ; systemm ;;
    esac
}
