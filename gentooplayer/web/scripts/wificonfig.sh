#!/bin/bash

#set -e

#repeats=1
#text="I'm called"
#filename='/etc/conf.d/mpdbp-conf'
clear=false

while (( $# >= 1 ))
do
    key="$1"

    case $key in
        -a)
            ssid="$2"
            shift # past argument
            ;;
        -b)
            pww="$2"
            shift # past argument
            ;;
        -c)
            ineterface="$2"
            shift # past argument
            ;;
        -d)
            mode="$2"
            shift # past argument
            ;;
        -e)
            iprou="$2"
            shift # past argument
            ;;
        -f)
            netmas="$2"
            shift # past argument
            ;;
        -g)
            ippc="$2"
            shift # past argument
            ;;
        *)
            # unknown option
            ;;
    esac
    shift # past argument or value
done


wpa_passphrase "$ssid" "$pww" > /tmp/passwifi
psk=$(echo $(awk '{if(NR==4) print $0}' /tmp/passwifi))



cat > /etc/wpa_supplicant/wpa_supplicant.conf <<EOF
# Allow users in the 'wheel' group to control wpa_supplicant
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=wheel
#
# Make this file writable for wpa_gui / wpa_cli
update_config=1
#
network={
      ssid="$ssid"
      $psk
      scan_ssid=1
      proto=RSN
      key_mgmt=WPA-PSK
      group=CCMP TKIP
      pairwise=CCMP TKIP
      priority=5
}
EOF
#
chmod 600 /etc/wpa_supplicant/wpa_supplicant.conf

ln -s net.lo /etc/init.d/net.$wlan 2>/dev/null

mv /etc/conf.d/hostapd /etc/conf.d/hostapd.back 2>/dev/null

case $mode in
    dhcp)
        cat > /etc/conf.d/net <<EOF
modules_$ineterface="!iw !iwconfig !wpa_supplicant"
config_$ineterface="dhcp"
EOF
;;
    IP_Static)
        cat > /etc/conf.d/net <<EOF
modules_$ineterface="!iw !iwconfig !wpa_supplicant"
config_$ineterface=( "$ippc netmask $netmas" )
routes_$ineterface=( "default gw $iprou" )
dns_servers_$ineterface=( "$iprou" )
EOF
;;
esac

#mv /etc/local.d/ireteonline.start /etc/local.d/ireteonline.start.back 2>/dev/null

rm /tmp/passwifi
#
#
/etc/init.d/wpa_supplicant restart &>/dev/null
/etc/init.d/net.$ineterface restart &>/dev/null
rc-update add wpa_supplicant default
rc-update add net.$ineterface default
reboot
