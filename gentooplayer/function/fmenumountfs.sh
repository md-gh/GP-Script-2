#!/bin/bash


############### Mountfs Menu ###################################################
mountf(){
    clear
    echo -e "\e[38;5;82m--------------------------------------------------\e[0m"
    echo -e "$Green "Nas - "$Color_Off is going to LAN shares, nas and/or LAN shares generally"
    echo -e " As there are different because sometimes varies the cifs version on the server"
    #  echo "$Green samba devices:$Color_Off"
    #  echo ""
    #  adress=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
    #  nmap -sP 192.168.178.0/24 | awk '/is up/ {print up}; {gsub (/\(|\)/,""); up = $NF}'
    #  nmap -sU -sS --script smb-enum-shares.nse -p U:137,T:139 192.168.178.22/24 | grep '[0-9][0-9][0-9]\.\|[0-9][0-9]\.' | sed 's/Nmap scan report for//g; s/\\/\//g' | grep 192.168.178.22/ | sed 's/|//g' | sed 's/192.168.178.22//g' | sed 's/://g' | sed 's/\///g' | awk '!/IPC/'
    #  nmap -sU -sS --script smb-enum-shares.nse -p U:137,T:139 "$address"/24 | grep '[0-9][0-9][0-9]\.\|[0-9][0-9]\.' | sed 's/Nmap scan report for//g; s/\\/\//g'
    #  echo ""
    #  echo -e "$Green nfs devices:$Color_Off"
    #  echo -e ""
    #  nmap -sS --script nfs-showmount.nse -p T:111 "$address"/24 | grep '[0-9][0-9][0-9]\.\|[0-9][0-9]\.' | sed 's/Nmap scan report for//g; s/|//g; s/_//g'
    echo ""
    echo -e "$Green The filesystem fat, ext2, ext3, ext4 and ntfs are mounted by default in $BRed/media/$Color_Off"
    echo -e "$Green The LAN shares are mounted by default in $BRed/mnt/samba/$Color_Off"
    echo ""
    echo -e "$Green Disks on the system and related partitions:$Color_Off"
    echo
    lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT
    echo ""
    echo -e "\e[38;5;82m--------------------------------------------------\e[0m"
    echo
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo -e ""
    echo -e "        $color1"GentooPlayer"$color_off - $BBlue"MountFS"$Color_Off"
    echo -e ""
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo ""
    echo -e " [1]  $Green"Mount FS vfat"$Color_Off"
    echo -e " [2]  $Green"Mount FS ext2"$Color_Off"
    echo -e " [3]  $Green"Mount FS ext3"$Color_Off"
    echo -e " [4]  $Green"Mount FS ext4"$Color_Off"
    echo -e " [5]  $Green"Mount FS ntfs"$Color_Off"
    echo ""
    echo -e " [6]  $Yellow"Nas - standard version with password"$Color_Off"
    echo -e " [7]  $Yellow"Nas - standard version without password"$Color_Off"
    echo -e " [8]  $Yellow"Nas - v.1.0 with password"$Color_Off"
    echo -e " [9]  $Yellow"Nas - v.1.0 without password"$Color_Off"
    echo -e " [10] $Yellow"Nas - v.2.1 with password"$Color_Off"
    echo -e " [11] $Yellow"Nas - v.2.1 without password"$Color_Off"
    echo -e ""
    echo -e " [12] $Purple"Nfs"$Color_Off"
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo ""
    echo -e " [13] $BBlue"Base System Menu"$Color_Off"
    echo -e " [14] $BBlue"System Menu"$Color_Off"
    echo -e " [15] $BBlue"Main Menu"$Color_Off"
    echo -e " [0]  $BBlue"Exit"$Color_Off"
    echo ""
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo -e ""
    echo -e "$Green"Choose your operation:"$Color_Off"
    echo ""
    read -p  " [0 - 15]:" oper
    echo -e ""
    case $oper in

        1)
            vf ;
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; mountf ;;
        2)
            ex2 ;
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; mountf ;;
        3)
            ex3 ;
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; mountf ;;
        4)
            ex4 ;
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; mountf ;;
        5)
            ntf ;
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; mountf ;;
        6)
            nas ;
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; mountf ;;
        7)
            nas1 ;
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; mountf ;;
        8)
            nas2 ;
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; mountf ;;
        9)
            nas3 ;
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; mountf ;;
        10)
            nas4 ;
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; mountf ;;
        11)
            nas5 ;
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; mountf ;;
        12)
            nfss ;
            echo
            echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; mountf ;;
        13) systemb ;;
        14)  systemm ;;
        15) menu ;;
        0) esci ;;
        *) echo -e "$Red Invalid choice...$Color_Off" && sleep 2 ; mountf ;;
    esac
}
