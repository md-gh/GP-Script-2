#!/bin/bash
. /opt/.gentooplayer/function/fcolors.sh

wifir(){
    clear
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo -e ""
    echo -e "        $color1"GentooPlayer"$color_off - $BBlue"Wi-fi"$Color_Off"
    echo -e ""
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo ""
    echo -e " [1] wifi configure"
    echo -e " [2] wifi disable"
    echo -e " [3] wifi enable"
    echo -e ""
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo ""
    echo -e " [4] $BBlue"BaseSystemMenu"$Color_Off"
    echo -e " [0] $BBlue"Exit"$Color_Off"
    echo ""
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo -e ""
    echo -e "$Green"Choose your operation:"$Color_Off"
    echo ""
    read -p  " [0 - 4]:" oper
    echo -e ""
    case $oper in

        1)
            wificonfig ;
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; wifir ;;
        2)
            cat > /etc/local.d/wifidisable.start <<EOF
#!/bin/bash
ifconfig -v wlan0 down
EOF
            chmod +x /etc/local.d/wifidisable.start ;
            rc-update delete wpa_supplicant default ;
            rc-update delete net.wlan0 default ;
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; wifir ;;
        3)
            rm /etc/local.d/wifidisable.start 1>/dev/null ;
            rc-update add wpa_supplicant default ;
            rc-update add net.wlan0 default ;
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; wifir ;;
        4) systemb ;;
        0) esci ;;
        *) echo -e "$Red Invalid choice...$Color_Off" && sleep 2 ; wifir ;;
    esac
}
