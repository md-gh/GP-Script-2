#!/bin/bash
. /opt/.gentooplayer/function/fcolors.sh

bldylw='\e[1;33m' # Giallo
txtrst='\e[0m'    # Text Resett
function run_as_root() {
    [ "$(whoami)" == "root" ] || {
        echo -e '\a\nWARNING: This command must be run from the "SuperUser" (root user).'
        exec su -c "$0"
    }
}
run_as_root
clear
echo "-----------------------------------------------------------------------------------------------------"
route -n
echo "-----------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------"
echo -e "${bldylw}YOU HAVE ALL INFORMATION ABOVE:"
echo "-The iface_name IN THE COLUMN Iface"
echo -e "-IP ROUTER IN THE COLUMN Gateway"
echo -e "-NetMask IN THE COLUMN Genmask${txtrst}"
echo "-----------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------"
getinfo()
{
    read -p "Enter iface_name(looks like enp3s0 or eth0 etc):"  namerete
    read -p "Enter the IP of your router(Gateway) - (looks like 192.168.1.1,192.168.178.1....):"	routerip
    read -p "Enter the ip address for your (looks like 192.168.1.22):"	staticip
    read -p "Enter the NetMask - Genmask (looks like 255.255...):"   netma
}

writeinterfacefile()
{
    cat > /etc/conf.d/net <<EOF
config_$namerete=( "$staticip netmask $netma" )
routes_$namerete=( "default gw $routerip" )
dns_servers_$namerete=( "$routerip" )
EOF
    ln -s /etc/init.d/net.lo /etc/init.d/net.$namerete
    rc-update add net.$namerete default
    /etc/init.d/net.$namerete restart
    rc-update del dhcpcd default
    exit 0
}




infom(){
    echo ""
    echo -e "$Green"So your settings are:"$Color_Off"
    echo
    echo -e "$BRed"Your iface_name is:"$Color_Off         $BGreen"$namerete"$Color_Off"
    echo -e "$BRed"Address of your Router is:"$Color_Off  $BGreen"$routerip"$Color_Off"
    echo -e "$BRed"Your decided IP is:"$Color_Off         $BGreen"$staticip"$Color_Off"
    echo -e "$BRed"Your NetMask is:"$Color_Off            $BGreen"$netma"$Color_Off"
    echo ""
}

getinfo
infom

while true; do
    echo -e "$Yellow"
    read -p "Are these informations correct? [y/n]: " yn
    echo -e "$Color_Off"
    case $yn in
        [Yy]* ) writeinterfacefile ;;
        [Nn]* ) getinfo;infom ;;
        * ) echo "Pleas enter y or n!" ;;
    esac

done
