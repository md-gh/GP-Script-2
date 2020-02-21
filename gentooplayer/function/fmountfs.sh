#!/bin/bash
################ Nas5 ##########################################################
nfss(){
    clear
    echo ""
    echo -e "$Green "nfs devices:"$Color_Off"
    echo -e ""
    address=$(ip route show | awk '/default/ {print $3}')
    echo "(Please wait... Scanning the network)"
    nmap -sS --script nfs-showmount.nse -p T:111 "$address"/24 | grep '[0-9][0-9][0-9]\.\|[0-9][0-9]\.' | sed 's/Nmap scan report for//g; s/|//g; s/_//g'
    echo ""
    echo -e "\e[38;5;197mATTENTION: give different names for different servers\e[0m"
    echo
    echo -e "$Yellow"
    read -s -p 'Press "Enter" to continue... CTRL+C to end'
    echo -e "$Color_Off"
    echo
    read -p "Type the server ip:   "	ipserver
    read -p "Type the directory of the server you want to mount (exact name):   "	nomedir
    read -p "insert nfs version (4 3 2 etc. Press ENTER for default):   " nfsversion
    if [ ${#nfsversion} -eq 0 ]; then
        version=""
        version="vers="$nfsversion","
    fi
    #  read -p "Type username:"      nomeu
    #  read -p "Type password:"      passwd
    read -p "Give a name to the server, it is free and of your choice (eg nas, nas1, mio_nas, pc_server, debian, etc.):   " nomcond
    echo
    mkdir /mnt/samba/$nomcond 2>/dev/null
    if
    mkdir /mnt/samba/$nomcond/$nomedir 2>/dev/null; then
        chmod -R 777 /mnt/samba/$nomcond
        chmod -R 777 /mnt/samba/$nomcond/$nomedir
        echo -e "\n \e[38;5;154m[OK] The directory /mnt/samba/$nomcond/$nomedir It was created correctly\e[0m\n"
    else
        echo -e "\n \e[38;5;197mThe directory /mnt/samba/$nomcond/$nomedir already exists, sure you want to use this path?\e[0m\n"
        echo ""
        echo -e "$Yellow"
        read -s -p 'Press "Enter" to continue... CTRL+C to end'
        echo -e "$Color_Off"
    fi
    if
    mount -t nfs "$ipserver":/"$nomedir" /mnt/samba/$nomcond/$nomedir -o "$version"; then
        echo -e "\n \e[38;5;154m[OK]\e[0m\n"
        echo -e "\e[38;5;82mLa condivisione remota //$ipserver/$nomedir It has been mounted in /mnt/samba/$nomcond/$nomedir\e[0m"
    else
        echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
        echo -e ""
        exit 0
    fi
    echo -e ""
    echo -e "\e[38;5;82mDo you want to add the mount when the system starts?\e[0m y/n"
    read aggiungere
    if [ "$aggiungere" = "y" ]; then
        echo ""$ipserver":/"$nomedir" /mnt/samba/$nomcond/$nomedir nfs "$version" 0 0" >> /etc/fstab
        echo -e "\n \e[38;5;154m[OK]\e[0m\n"
    else
        echo -e "\n \e[38;5;197m[NOT ADDED]\e[0m\n"
    fi
}


################ Nas5 ##########################################################
nas5(){
    clear
    echo ""
    echo -e "$Green "samba devices:"$Color_Off"
    echo ""
    #adress=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
    address=$(ip route show | awk '/default/ {print $3}')
    echo "(Please wait... Scanning the network)"
    #nmap -sP 192.168.178.0/24 | awk '/is up/ {print up}; {gsub (/\(|\)/,""); up = $NF}'
    #nmap -sU -sS --script smb-enum-shares.nse -p U:137,T:139 192.168.178.22/24 | grep '[0-9][0-9][0-9]\.\|[0-9][0-9]\.' | sed 's/Nmap scan report for//g; s/\\/\//g' | grep 192.168.178.22/ | sed 's/|//g' | sed 's/192.168.178.22//g' | sed 's/://g' | sed 's/\///g' | awk '!/IPC/'
    nmap -sU -sS --script smb-enum-shares.nse -p U:137,T:139 "$address"/24 | grep '[0-9][0-9][0-9]\.\|[0-9][0-9]\.' | sed 's/Nmap scan report for//g; s/\\/\//g'
    echo ""
    echo -e "\e[38;5;197mATTENTION: give different names for different servers\e[0m"
    echo
    echo -e "$Yellow"
    read -s -p 'Press "Enter" to continue... CTRL+C to end'
    echo -e "$Color_Off"
    echo
    read -p "Type the server ip:   "	ipserver
    read -p "Type the directory of the server you want to mount (exact name):   "	nomedir
    #  read -p "Type username:"      nomeu
    #  read -p "Type password:"      passwd
    read -p "Give a name to the server, it is free and of your choice (eg nas, nas1, mio_nas, pc_server, debian, etc.):   " nomcond
    echo
    mkdir /mnt/samba/$nomcond 2>/dev/null
    if
    mkdir /mnt/samba/$nomcond/$nomedir 2>/dev/null; then
        chmod -R 777 /mnt/samba/$nomcond
        chmod -R 777 /mnt/samba/$nomcond/$nomedir
        echo -e "\n \e[38;5;154m[OK] The directory /mnt/samba/$nomcond/$nomedir It was created correctly\e[0m\n"
    else
        echo -e "\n \e[38;5;197mThe directory /mnt/samba/$nomcond/$nomedir already exists, sure you want to use this path?\e[0m\n"
        echo ""
        echo -e "$Yellow"
        read -s -p 'Press "Enter" to continue... CTRL+C to end'
        echo -e "$Color_Off"
    fi
    if
    mount -w -t cifs -o vers=2.1,guest //$ipserver/$nomedir /mnt/samba/$nomcond/$nomedir; then
        echo -e "\n \e[38;5;154m[OK]\e[0m\n"
        echo -e "\e[38;5;82mLa condivisione remota //$ipserver/$nomedir It has been mounted in /mnt/samba/$nomcond/$nomedir\e[0m"
    else
        echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
        echo -e ""
        exit 0
    fi
    echo -e ""
    echo -e "\e[38;5;82mDo you want to add the mount when the system starts?\e[0m y/n"
    read aggiungere
    if [ "$aggiungere" = "y" ]; then
        echo "//$ipserver/$nomedir /mnt/samba/$nomcond/$nomedir cifs vers=2.1,guest 0 0" >> /etc/fstab
        echo -e "\n \e[38;5;154m[OK]\e[0m\n"
    else
        echo -e "\n \e[38;5;197m[NOT ADDED]\e[0m\n"
    fi
}

################ Nas4 ##########################################################
nas4(){
    clear
    echo ""
    echo -e "$Green "samba devices:"$Color_Off"
    echo ""
    #adress=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
    address=$(ip route show | awk '/default/ {print $3}')
    echo "(Please wait... Scanning the network)"
    #nmap -sP 192.168.178.0/24 | awk '/is up/ {print up}; {gsub (/\(|\)/,""); up = $NF}'
    #nmap -sU -sS --script smb-enum-shares.nse -p U:137,T:139 192.168.178.22/24 | grep '[0-9][0-9][0-9]\.\|[0-9][0-9]\.' | sed 's/Nmap scan report for//g; s/\\/\//g' | grep 192.168.178.22/ | sed 's/|//g' | sed 's/192.168.178.22//g' | sed 's/://g' | sed 's/\///g' | awk '!/IPC/'
    nmap -sU -sS --script smb-enum-shares.nse -p U:137,T:139 "$address"/24 | grep '[0-9][0-9][0-9]\.\|[0-9][0-9]\.' | sed 's/Nmap scan report for//g; s/\\/\//g'
    echo ""
    echo -e "\e[38;5;197mATTENTION: give different names for different servers\e[0m"
    echo
    echo -e "$Yellow"
    read -s -p 'Press "Enter" to continue... CTRL+C to end'
    echo -e "$Color_Off"
    echo
    read -p "Type the server ip:   "	ipserver
    read -p "Type the directory of the server you want to mount (exact name):   "	nomedir
    read -p "Type username:"      nomeu
    read -p "Type password:"      passwd
    read -p "Give a name to the server, it is free and of your choice (eg nas, nas1, mio_nas, pc_server, debian, etc.):   " nomcond
    echo
    mkdir /mnt/samba/$nomcond 2>/dev/null
    if
    mkdir /mnt/samba/$nomcond/$nomedir 2>/dev/null; then
        chmod -R 777 /mnt/samba/$nomcond
        chmod -R 777 /mnt/samba/$nomcond/$nomedir
        echo -e "\n \e[38;5;154m[OK] The directory /mnt/samba/$nomcond/$nomedir It was created correctly\e[0m\n"
    else
        echo -e "\n \e[38;5;197mThe directory /mnt/samba/$nomcond/$nomedir already exists, sure you want to use this path?\e[0m\n"
        echo ""
        echo -e "$Yellow"
        read -s -p 'Press "Enter" to continue... CTRL+C to end'
        echo -e "$Color_Off"
    fi
    if
    mount -w -t cifs -o vers=2.1,username=$nomeu,password=$passwd //$ipserver/$nomedir /mnt/samba/$nomcond/$nomedir; then
        echo -e "\n \e[38;5;154m[OK]\e[0m\n"
        echo -e "\e[38;5;82mLa condivisione remota //$ipserver/$nomedir It has been mounted in /mnt/samba/$nomcond/$nomedir\e[0m"
    else
        echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
        echo -e ""
        exit 0
    fi
    echo -e ""
    echo -e "\e[38;5;82mDo you want to add the mount when the system starts?\e[0m y/n"
    read aggiungere
    if [ "$aggiungere" = "y" ]; then
        echo "//$ipserver/$nomedir /mnt/samba/$nomcond/$nomedir cifs vers=2.1,username=$nomeu,password=$passwd 0 0" >> /etc/fstab
        echo -e "\n \e[38;5;154m[OK]\e[0m\n"
    else
        echo -e "\n \e[38;5;197m[NOT ADDED]\e[0m\n"
    fi
}

################ Nas3 ##########################################################
nas3(){
    clear
    echo ""
    echo -e "$Green "samba devices:"$Color_Off"
    echo ""
    #adress=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
    address=$(ip route show | awk '/default/ {print $3}')
    echo "(Please wait... Scanning the network)"
    #nmap -sP 192.168.178.0/24 | awk '/is up/ {print up}; {gsub (/\(|\)/,""); up = $NF}'
    #nmap -sU -sS --script smb-enum-shares.nse -p U:137,T:139 192.168.178.22/24 | grep '[0-9][0-9][0-9]\.\|[0-9][0-9]\.' | sed 's/Nmap scan report for//g; s/\\/\//g' | grep 192.168.178.22/ | sed 's/|//g' | sed 's/192.168.178.22//g' | sed 's/://g' | sed 's/\///g' | awk '!/IPC/'
    nmap -sU -sS --script smb-enum-shares.nse -p U:137,T:139 "$address"/24 | grep '[0-9][0-9][0-9]\.\|[0-9][0-9]\.' | sed 's/Nmap scan report for//g; s/\\/\//g'
    echo ""
    echo -e "\e[38;5;197mATTENTION: give different names for different servers\e[0m"
    echo
    echo -e "$Yellow"
    read -s -p 'Press "Enter" to continue... CTRL+C to end'
    echo -e "$Color_Off"
    echo
    read -p "Type the server ip:   "	ipserver
    read -p "Type the directory of the server you want to mount (exact name):   "	nomedir
    #  read -p "Type username:"      nomeu
    #  read -p "Type password:"      passwd
    read -p "Give a name to the server, it is free and of your choice (eg nas, nas1, mio_nas, pc_server, debian, etc.):   " nomcond
    echo
    mkdir /mnt/samba/$nomcond 2>/dev/null
    if
    mkdir /mnt/samba/$nomcond/$nomedir 2>/dev/null; then
        chmod -R 777 /mnt/samba/$nomcond
        chmod -R 777 /mnt/samba/$nomcond/$nomedir
        echo -e "\n \e[38;5;154m[OK] The directory /mnt/samba/$nomcond/$nomedir It was created correctly\e[0m\n"
    else
        echo -e "\n \e[38;5;197mThe directory /mnt/samba/$nomcond/$nomedir already exists, sure you want to use this path?\e[0m\n"
        echo ""
        echo -e "$Yellow"
        read -s -p 'Press "Enter" to continue... CTRL+C to end'
        echo -e "$Color_Off"
    fi
    if
    mount -w -t cifs -o vers=1.0,guest //$ipserver/$nomedir /mnt/samba/$nomcond/$nomedir; then
        echo -e "\n \e[38;5;154m[OK]\e[0m\n"
        echo -e "\e[38;5;82mLa condivisione remota //$ipserver/$nomedir It has been mounted in /mnt/samba/$nomcond/$nomedir\e[0m"
    else
        echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
        echo -e ""
        exit 0
    fi
    echo -e ""
    echo -e "\e[38;5;82mDo you want to add the mount when the system starts?\e[0m y/n"
    read aggiungere
    if [ "$aggiungere" = "y" ]; then
        echo "//$ipserver/$nomedir /mnt/samba/$nomcond/$nomedir cifs vers=1.0,guest 0 0" >> /etc/fstab
        echo -e "\n \e[38;5;154m[OK]\e[0m\n"
    else
        echo -e "\n \e[38;5;197m[NOT ADDED]\e[0m\n"
    fi
}
################ Nas2 ##########################################################
nas2(){
    clear
    echo ""
    echo -e "$Green "samba devices:"$Color_Off"
    echo ""
    #adress=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
    address=$(ip route show | awk '/default/ {print $3}')
    echo "(Please wait... Scanning the network)"
    #nmap -sP 192.168.178.0/24 | awk '/is up/ {print up}; {gsub (/\(|\)/,""); up = $NF}'
    #nmap -sU -sS --script smb-enum-shares.nse -p U:137,T:139 192.168.178.22/24 | grep '[0-9][0-9][0-9]\.\|[0-9][0-9]\.' | sed 's/Nmap scan report for//g; s/\\/\//g' | grep 192.168.178.22/ | sed 's/|//g' | sed 's/192.168.178.22//g' | sed 's/://g' | sed 's/\///g' | awk '!/IPC/'
    nmap -sU -sS --script smb-enum-shares.nse -p U:137,T:139 "$address"/24 | grep '[0-9][0-9][0-9]\.\|[0-9][0-9]\.' | sed 's/Nmap scan report for//g; s/\\/\//g'
    echo ""
    echo -e "\e[38;5;197mATTENTION: give different names for different servers\e[0m"
    echo
    echo -e "$Yellow"
    read -s -p 'Press "Enter" to continue... CTRL+C to end'
    echo -e "$Color_Off"
    echo
    read -p "Type the server ip:   "	ipserver
    read -p "Type the directory of the server you want to mount (exact name):   "	nomedir
    read -p "Type username:"      nomeu
    read -p "Type password:"      passwd
    read -p "Give a name to the server, it is free and of your choice (eg nas, nas1, mio_nas, pc_server, debian, etc.):   " nomcond
    echo
    mkdir /mnt/samba/$nomcond 2>/dev/null
    if
    mkdir /mnt/samba/$nomcond/$nomedir 2>/dev/null; then
        chmod -R 777 /mnt/samba/$nomcond
        chmod -R 777 /mnt/samba/$nomcond/$nomedir
        echo -e "\n \e[38;5;154m[OK] The directory /mnt/samba/$nomcond/$nomedir It was created correctly\e[0m\n"
    else
        echo -e "\n \e[38;5;197mThe directory /mnt/samba/$nomcond/$nomedir already exists, sure you want to use this path?\e[0m\n"
        echo ""
        echo -e "$Yellow"
        read -s -p 'Press "Enter" to continue... CTRL+C to end'
        echo -e "$Color_Off"
    fi
    if
    mount -w -t cifs -o vers=1.0,username=$nomeu,password=$passwd //$ipserver/$nomedir /mnt/samba/$nomcond/$nomedir; then
        echo -e "\n \e[38;5;154m[OK]\e[0m\n"
        echo -e "\e[38;5;82mLa condivisione remota //$ipserver/$nomedir It has been mounted in /mnt/samba/$nomcond/$nomedir\e[0m"
    else
        echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
        echo -e ""
        exit 0
    fi
    echo -e ""
    echo -e "\e[38;5;82mDo you want to add the mount when the system starts?\e[0m y/n"
    read aggiungere
    if [ "$aggiungere" = "y" ]; then
        echo "//$ipserver/$nomedir /mnt/samba/$nomcond/$nomedir cifs vers=1.0,username=$nomeu,password=$passwd 0 0" >> /etc/fstab
        echo -e "\n \e[38;5;154m[OK]\e[0m\n"
    else
        echo -e "\n \e[38;5;197m[NOT ADDED]\e[0m\n"
    fi
}

################ Nas1 ##########################################################
nas1(){
    clear
    echo ""
    echo -e "$Green "samba devices:"$Color_Off"
    echo ""
    #adress=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
    address=$(ip route show | awk '/default/ {print $3}')
    echo "(Please wait... Scanning the network)"
    #nmap -sP 192.168.178.0/24 | awk '/is up/ {print up}; {gsub (/\(|\)/,""); up = $NF}'
    #nmap -sU -sS --script smb-enum-shares.nse -p U:137,T:139 192.168.178.22/24 | grep '[0-9][0-9][0-9]\.\|[0-9][0-9]\.' | sed 's/Nmap scan report for//g; s/\\/\//g' | grep 192.168.178.22/ | sed 's/|//g' | sed 's/192.168.178.22//g' | sed 's/://g' | sed 's/\///g' | awk '!/IPC/'
    nmap -sU -sS --script smb-enum-shares.nse -p U:137,T:139 "$address"/24 | grep '[0-9][0-9][0-9]\.\|[0-9][0-9]\.' | sed 's/Nmap scan report for//g; s/\\/\//g'
    echo ""
    echo -e "\e[38;5;197mATTENTION: give different names for different servers\e[0m"
    echo
    echo -e "$Yellow"
    read -s -p 'Press "Enter" to continue... CTRL+C to end'
    echo -e "$Color_Off"
    echo
    read -p "Type the server ip:   "	ipserver
    read -p "Type the directory of the server you want to mount (exact name):   "	nomedir
    #  read -p "Type username:"      nomeu
    #  read -p "Type password:"      passwd
    read -p "Give a name to the server, it is free and of your choice (eg nas, nas1, mio_nas, pc_server, debian, etc.):   " nomcond
    echo
    mkdir /mnt/samba/$nomcond 2>/dev/null
    if
    mkdir /mnt/samba/$nomcond/$nomedir 2>/dev/null; then
        chmod -R 777 /mnt/samba/$nomcond
        chmod -R 777 /mnt/samba/$nomcond/$nomedir
        echo -e "\n \e[38;5;154m[OK] The directory /mnt/samba/$nomcond/$nomedir It was created correctly\e[0m\n"
    else
        echo -e "\n \e[38;5;197mThe directory /mnt/samba/$nomcond/$nomedir already exists, sure you want to use this path?\e[0m\n"
        echo ""
        echo -e "$Yellow"
        read -s -p 'Press "Enter" to continue... CTRL+C to end'
        echo -e "$Color_Off"
    fi
    if
    mount -w -t cifs //$ipserver/$nomedir /mnt/samba/$nomcond/$nomedir; then
        echo -e "\n \e[38;5;154m[OK]\e[0m\n"
        echo -e "\e[38;5;82mLa condivisione remota //$ipserver/$nomedir It has been mounted in /mnt/samba/$nomcond/$nomedir\e[0m"
    else
        echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
        echo -e ""
        exit 0
    fi
    echo -e ""
    echo -e "\e[38;5;82mDo you want to add the mount when the system starts?\e[0m y/n"
    read aggiungere
    if [ "$aggiungere" = "y" ]; then
        echo "//$ipserver/$nomedir /mnt/samba/$nomcond/$nomedir cifs 0 0" >> /etc/fstab
        echo -e "\n \e[38;5;154m[OK]\e[0m\n"
    else
        echo -e "\n \e[38;5;197m[NOT ADDED]\e[0m\n"
    fi
}

################ Nas ##########################################################
nas(){
    clear
    echo ""
    echo -e "$Green "samba devices:"$Color_Off"
    echo ""
    #adress=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
    address=$(ip route show | awk '/default/ {print $3}')
    echo "(Please wait... Scanning the network)"
    #nmap -sP 192.168.178.0/24 | awk '/is up/ {print up}; {gsub (/\(|\)/,""); up = $NF}'
    #nmap -sU -sS --script smb-enum-shares.nse -p U:137,T:139 192.168.178.22/24 | grep '[0-9][0-9][0-9]\.\|[0-9][0-9]\.' | sed 's/Nmap scan report for//g; s/\\/\//g' | grep 192.168.178.22/ | sed 's/|//g' | sed 's/192.168.178.22//g' | sed 's/://g' | sed 's/\///g' | awk '!/IPC/'
    nmap -sU -sS --script smb-enum-shares.nse -p U:137,T:139 "$address"/24 | grep '[0-9][0-9][0-9]\.\|[0-9][0-9]\.' | sed 's/Nmap scan report for//g; s/\\/\//g'
    echo ""
    echo -e "\e[38;5;197mATTENTION: give different names for different servers\e[0m"
    echo
    echo -e "$Yellow"
    read -s -p 'Press "Enter" to continue... CTRL+C to end'
    echo -e "$Color_Off"
    echo
    read -p "Type the server ip:   "	ipserver
    read -p "Type the directory of the server you want to mount (exact name):   "	nomedir
    read -p "Type username:"      nomeu
    read -p "Type password:"      passwd
    read -p "Give a name to the server, it is free and of your choice (eg nas, nas1, mio_nas, pc_server, debian, etc.):   " nomcond
    echo
    mkdir /mnt/samba/$nomcond 2>/dev/null
    if
    mkdir /mnt/samba/$nomcond/$nomedir 2>/dev/null; then
        chmod -R 777 /mnt/samba/$nomcond
        chmod -R 777 /mnt/samba/$nomcond/$nomedir
        echo -e "\n \e[38;5;154m[OK] The directory /mnt/samba/$nomcond/$nomedir It was created correctly\e[0m\n"
    else
        echo -e "\n \e[38;5;197mThe directory /mnt/samba/$nomcond/$nomedir already exists, sure you want to use this path?\e[0m\n"
        echo ""
        echo -e "$Yellow"
        read -s -p 'Press "Enter" to continue... CTRL+C to end'
        echo -e "$Color_Off"
    fi
    if
    mount -w -t cifs -o username=$nomeu,password=$passwd //$ipserver/$nomedir /mnt/samba/$nomcond/$nomedir; then
        echo -e "\n \e[38;5;154m[OK]\e[0m\n"
        echo -e "\e[38;5;82mLa condivisione remota //$ipserver/$nomedir It has been mounted in /mnt/samba/$nomcond/$nomedir\e[0m"
    else
        echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
        echo -e ""
        exit 0
    fi
    echo -e ""
    echo -e "\e[38;5;82mDo you want to add the mount when the system starts?\e[0m y/n"
    read aggiungere
    if [ "$aggiungere" = "y" ]; then
        echo "//$ipserver/$nomedir /mnt/samba/$nomcond/$nomedir cifs username=$nomeu,password=$passwd 0 0" >> /etc/fstab
        echo -e "\n \e[38;5;154m[OK]\e[0m\n"
    else
        echo -e "\n \e[38;5;197m[NOT ADDED]\e[0m\n"
    fi
}

################ Ntfs ##########################################################
ntf(){
    clear
    echo ""
    echo -e "\e[38;5;82m--------------------------------------------------\e[0m"
    echo ""
    echo -e "Partition \e[38;5;82mntfs\e[0m present on the system:"
    echo ""
    echo -e "NAME SIZE FSTYPE MOUNTPOINT"
    lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT | grep ntfs | sed 's/\├─//g' | sed 's/\└─//g'
    echo ""
    echo -e "\e[38;5;82m--------------------------------------------------\e[0m"
    echo ""
    echo -e "$Red If no partition is displayed it means that you do not have $Green"ntfs"$Color_Off $Red"partitions in your system"$Color_Off"
    echo
    echo -e "$Yellow"
    read -s -p 'Press "Enter" to continue... CTRL+C to end'
    echo -e "$Color_Off"
    echo
    echo -e "\e[38;5;197mWARNING: give different names to the mount point for different disks\e[0m"
    echo
    read -p "Type the name of the mount point, name to give to the directory that must contain the disk. (eg Music1, Music2 etc.):"   nomedir
    read -p "Type the partition to be mounted, see above. (eg sda1, sda2, sdb1 etc.):"  nomepart
    mkdir /media/$nomedir
    chmod -R 777 /media/$nomedir
    if
    mount -t ntfs-3g /dev/$nomepart /media/$nomedir; then
        echo ""
        echo -e "\e[38;5;82mthe disk $nomepart It has been mounted in /media/$nomedir\e[0m"
    else
        echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
        echo ""
    fi
    echo ""
    echo -e "\e[38;5;82mDo you want to add disk mount at system startup?\e[0m y/n"
    read aggiungere
    if [ "$aggiungere" = "y" ]; then
        echo "/dev/$nomepart /media/$nomedir ntfs-3g defaults 0 0" >> /etc/fstab
        echo -e "\n \e[38;5;154m[OK]\e[0m\n"
    else
        echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
    fi
}

################ ext4 ##########################################################
ex4(){
    clear
    echo ""
    echo -e "\e[38;5;82m--------------------------------------------------\e[0m"
    echo ""
    echo -e "Partition \e[38;5;82mext4\e[0m present on the system:"
    echo ""
    echo -e "NAME SIZE FSTYPE MOUNTPOINT"
    lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT | grep ext4 | sed 's/\├─//g' | sed 's/\└─//g'
    echo ""
    echo -e "\e[38;5;82m--------------------------------------------------\e[0m"
    echo ""
    echo -e "$Red If no partition is displayed it means that you do not have $Green"ext4"$Color_Off $Red"partitions in your system"$Color_Off"
    echo
    echo -e "$Yellow"
    read -s -p 'Press "Enter" to continue... CTRL+C to end'
    echo -e "$Color_Off"
    echo
    echo -e "\e[38;5;197mWARNING: give different names to the mount point for different disks\e[0m"
    echo
    read -p "Type the name of the mount point, name to give to the directory that must contain the disk. (eg Music1, Music2 etc.):"   nomedir
    read -p "Type the partition to be mounted, see above. (eg sda1, sda2, sdb1 etc.):"  nomepart
    mkdir /media/$nomedir
    chmod -R 777 /media/$nomedir
    if
    mount /dev/$nomepart /media/$nomedir; then
        echo ""
        echo -e "\e[38;5;82mthe disk $nomepart It has been mounted in /media/$nomedir\e[0m"
    else
        echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
        echo ""
    fi
    echo -e "\e[38;5;82mDo you want to add disk mount at system startup?\e[0m y/n"
    read aggiungere
    if [ "$aggiungere" = "y" ]; then
        echo "/dev/$nomepart /media/$nomedir ext4 defaults 0 0" >> /etc/fstab
        echo -e "\n \e[38;5;154m[OK]\e[0m\n"
    else
        echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
    fi
}

################ ext3 ##########################################################
ex3(){
    clear
    echo ""
    echo -e "\e[38;5;82m--------------------------------------------------\e[0m"
    echo ""
    echo -e "Partition \e[38;5;82mext3\e[0m present on the system:"
    echo ""
    echo -e "NAME SIZE FSTYPE MOUNTPOINT"
    lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT | grep ext3 | sed 's/\├─//g' | sed 's/\└─//g'
    echo ""
    echo -e "\e[38;5;82m--------------------------------------------------\e[0m"
    echo ""
    echo -e "$Red If no partition is displayed it means that you do not have $Green"ext3"$Color_Off $Red"partitions in your system"$Color_Off"
    echo
    echo -e "$Yellow"
    read -s -p 'Press "Enter" to continue... CTRL+C to end'
    echo -e "$Color_Off"
    echo
    echo -e "\e[38;5;197mWARNING: give different names to the mount point for different disks\e[0m"
    echo
    read -p "Type the name of the mount point, name to give to the directory that must contain the disk. (eg Music1, Music2 etc.):"   nomedir
    read -p "Type the partition to be mounted, see above. (eg sda1, sda2, sdb1 etc.):"  nomepart
    mkdir /media/$nomedir
    chmod -R 777 /media/$nomedir
    if
    mount /dev/$nomepart /media/$nomedir; then
        echo ""
        echo -e "\e[38;5;82mthe disk $nomepart It has been mounted in /media/$nomedir\e[0m"
    else
        echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
        echo ""
    fi
    echo ""
    echo -e "\e[38;5;82mDo you want to add disk mount at system startup?\e[0m y/n"
    read aggiungere
    if [ "$aggiungere" = "y" ]; then
        echo "/dev/$nomepart /media/$nomedir ext3 defaults 0 0" >> /etc/fstab
        echo -e "\n \e[38;5;154m[OK]\e[0m\n"
    else
        echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
    fi
}

################ ext2 ##########################################################
ex2(){
    clear
    echo ""
    echo -e "\e[38;5;82m--------------------------------------------------\e[0m"
    echo ""
    echo -e "Partition \e[38;5;82mext2\e[0m present on the system:"
    echo ""
    echo -e "NAME SIZE FSTYPE MOUNTPOINT"
    lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT | grep ext2 | sed 's/\├─//g' | sed 's/\└─//g'
    echo ""
    echo -e "\e[38;5;82m--------------------------------------------------\e[0m"
    echo ""
    echo -e "$Red If no partition is displayed it means that you do not have $Green"ext2"$Color_Off $Red"partitions in your system"$Color_Off"
    echo
    echo -e "$Yellow"
    read -s -p 'Press "Enter" to continue... CTRL+C to end'
    echo -e "$Color_Off"
    echo
    echo -e "\e[38;5;197mWARNING: give different names to the mount point for different disks\e[0m"
    echo
    read -p "Type the name of the mount point, name to give to the directory that must contain the disk. (eg Music1, Music2 etc.):"   nomedir
    read -p "Type the partition to be mounted, see above. (eg sda1, sda2, sdb1 etc.):"  nomepart
    mkdir /media/$nomedir
    chmod -R 777 /media/$nomedir
    if
    mount /dev/$nomepart /media/$nomedir; then
        echo ""
        echo -e "\e[38;5;82mthe disk $nomepart It has been mounted in /media/$nomedir\e[0m"
    else
        echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
        echo ""
    fi
    echo ""
    echo -e "\e[38;5;82mDo you want to add disk mount at system startup?\e[0m y/n"
    read aggiungere
    if [ "$aggiungere" = "y" ]; then
        echo "/dev/$nomepart /media/$nomedir ext2 defaults 0 0" >> /etc/fstab
        echo -e "\n \e[38;5;154m[OK]\e[0m\n"
    else
        echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
    fi
}
################ vfat ##########################################################
vf(){
    clear
    echo ""
    echo -e "\e[38;5;82m--------------------------------------------------\e[0m"
    echo ""
    echo -e "Partition \e[38;5;82mvfat\e[0m present on the system:"
    echo ""
    echo -e "NAME SIZE FSTYPE MOUNTPOINT"
    lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT | grep vfat | sed 's/\├─//g' | sed 's/\└─//g'
    echo ""
    echo -e "\e[38;5;82m--------------------------------------------------\e[0m"
    echo ""
    echo -e "$Red If no partition is displayed it means that you do not have $Green"vfat"$Color_Off $Red"partitions in your system"$Color_Off"
    echo
    echo -e "$Yellow"
    read -s -p 'Press "Enter" to continue... CTRL+C to end'
    echo -e "$Color_Off"
    echo ""
    echo -e "\e[38;5;197mWARNING: give different names to the mount point for different disks\e[0m"
    echo
    read -p "Type the name of the mount point, name to give to the directory that must contain the disk. (eg Music1, Music2 etc.):"   nomedir
    read -p "Type the partition to be mounted, see above. (eg sda1, sda2, sdb1 etc.):"  nomepart
    mkdir /media/$nomedir
    chmod -R 777 /media/$nomedir
    if
    mount /dev/$nomepart /media/$nomedir; then
        echo ""
        echo -e "\e[38;5;82mthe disk $nomepart It has been mounted in /media/$nomedir\e[0m"
    else
        echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
        echo ""
    fi
    echo ""
    echo -e "\e[38;5;82mDo you want to add disk mount at system startup?\e[0m y/n"
    read aggiungere
    if [ "$aggiungere" = "y" ]; then
        echo "/dev/$nomepart /media/$nomedir vfat defaults 0 0" >> /etc/fstab
        echo -e "\n \e[38;5;154m[OK]\e[0m\n"
    else
        echo -e "\n \e[38;5;197m[FAILED]\e[0m\n"
    fi
}
