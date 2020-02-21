#!/bin/bash
. /opt/.gentooplayer/function/fcolors.sh

echo -e "list wlan:"
iw dev | awk '$1=="Interface"{print $2}' | cat -n
echo -e "$Green"
echo
read -p  "Choose your wlan interface (corresponding number): " oper
echo -e "$Color_Off"

wlan=$(iw dev | awk '$1=="Interface"{print $2}' | cat -n | awk '{if(NR=='$oper') print $0}' | awk '{print $2}')


iw $wlan scan | grep SSID: | awk '{ print substr($0, index($0,$2)) }' > /tmp/ssid

echo -e "available networks (ssid_name):"
echo

cat /tmp/ssid

echo
echo
read -p "Enter ssid_name:"  ssid
echo
read -p "type the wifi password:" passwifi

wpa_passphrase "$ssid" "$passwifi" > /tmp/passwifi

psk=$(echo $(awk '{if(NR==4) print $0}' /tmp/passwifi))


cat > /etc/wpa_supplicant/wpa_supplicant.conf <<EOF
# Allow users in the 'wheel' group to control wpa_supplicant
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=wheel

# Make this file writable for wpa_gui / wpa_cli
update_config=1

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

chmod 600 /etc/wpa_supplicant/wpa_supplicant.conf

ln -s net.lo /etc/init.d/net.$wlan 2>/dev/null

cat > /etc/conf.d/net <<EOF
modules_$wlan="!iw !iwconfig !wpa_supplicant"
config_$wlan="dhcp"
EOF

rm /tmp/passwifi

mv /etc/conf.d/hostapd /etc/conf.d/hostapd.back 2>/dev/null

echo -e "You want to start wi-fi? y/n"
read want
if [ "$want" = "y" ]; then
    /etc/init.d/wpa_supplicant restart &>/dev/null
    /etc/init.d/net.$wlan restart &>/dev/null
fi

echo -e "you want to add wi-fi to your computer's start? y/n"
read want
if [ "$want" = "y" ]; then
    rc-update add wpa_supplicant default
    rc-update add net.$wlan default
fi
