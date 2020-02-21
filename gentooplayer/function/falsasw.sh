#!/bin/bash

################# Select alsa version ################################################
alsasw(){
    clear
    mount /dev/mmcblk0p1 2>/dev/null
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo -e ""
    echo -e "        $color1"GentooPlayer"$color_off - $BBlue"Select Alsa Version"$Color_Off"
    echo -e ""
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo ""
    echo -e " [1] Select alsa version"
    echo ""
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo ""
    echo -e " [2] $BBlue"Main Menu"$Color_Off"
    echo -e " [0] $BBlue"Exit"$Color_Off"
    echo ""
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo -e ""
    echo -e "$Green"Choose your operation:"$Color_Off"
    echo ""
    read -p  " [0 - 2]:" oper
    echo -e ""
    case $oper in

        1)
            echo
            echo
            echo -e "$Green"Alsa Version list:"$Color_Off"
            echo
            echo
            ls -1v /usr/portage/packages/media-libs/ | sed 's/.tbz2//' | sed 's/alsa-lib-//' | cat -n
            echo
            echo -e "$Green"
            echo
            read -p  "Choose your Kernel (corresponding number): " oper
            echo -e "$Color_Off"
            alsav=$(ls -1v /usr/portage/packages/media-libs/ | sed 's/.tbz2//' | sed 's/alsa-lib-//' | cat -n | awk '{if(NR=='$oper') print $0}' | awk '{print $2}')
            case $alsav in
                1.0.29)
                    emerge --ask -k =media-libs/alsa-lib-1.0.29 =media-sound/alsa-utils-1.0.29
                    /etc/init.d/alsasound restart
                    echo -e "alsa switching ok"
                    echo -e "$Yellow Wait... $Color_Off" && sleep 5 ; alsasw ;;
                1.1.2)
                    emerge --ask -k =media-libs/alsa-lib-1.1.2 =media-sound/alsa-utils-1.1.2
                    /etc/init.d/alsasound restart
                    echo -e "alsa switching ok"
                    echo -e "$Yellow Wait... $Color_Off" && sleep 5 ; alsasw ;;
                1.1.6)
                    emerge --ask -k =media-libs/alsa-lib-1.1.6 =media-sound/alsa-utils-1.1.6
                    /etc/init.d/alsasound restart
                    echo -e "alsa switching ok"
                    echo -e "$Yellow Wait... $Color_Off" && sleep 5 ; alsasw ;;
                1.1.8)
                    emerge --ask -k =media-libs/alsa-lib-1.1.8 =media-sound/alsa-utils-1.1.8
                    /etc/init.d/alsasound restart
                    echo -e "alsa switching ok"
                    echo -e "$Yellow Wait... $Color_Off" && sleep 5 ; alsasw ;;
                1.1.9)
                    emerge --ask -k =media-libs/alsa-lib-1.1.9 =media-sound/alsa-utils-1.1.9
                    /etc/init.d/alsasound restart
                    echo -e "alsa switching ok"
                    echo -e "$Yellow Wait... $Color_Off" && sleep 5 ; alsasw ;;
                1.2.1.2)
                    emerge --ask -k =media-libs/alsa-lib-1.2.1.2 =media-sound/alsa-utils-1.2.1
                    /etc/init.d/alsasound restart
                    echo -e "alsa switching ok"
                    echo -e "$Yellow Wait... $Color_Off" && sleep 5 ; alsasw ;;
                *) echo -e "$Red Invalid choice...$Color_Off" && sleep 2 ; alsasw ;;
            esac
            ;;
        2) menu ;;
        0) exit 0 ;;
        *) echo -e "$Red Invalid choice...$Color_Off" && sleep 2 ; alsasw ;;
    esac
}
