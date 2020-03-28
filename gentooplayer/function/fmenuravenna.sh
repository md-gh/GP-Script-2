#!/bin/bash

################# Ravenna-Driver ######################################
ravenna(){
  clear
  echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
  echo -e ""
  echo -e "        $color1"GentooPlayer"$color_off - $BBlue"Merging Ravenna"$Color_Off"
  echo -e ""
  echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
  echo -e " [1] Install/Update Ravenna-Deamon"
  echo -e " [2] Enable Ravenna"
  echo -e " [3] Disable Ravenna"
  echo -e " [4] $BBlue"System Menu"$Color_Off"
  echo -e " [5] $BBlue"Main Menu"$Color_Off"
  echo -e " [0] $BBlue"Exit"$Color_Off"
  echo -e ""
  echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
echo -e "$Green"Choose your operation:"$Color_Off"
echo -e ""
local choice
read -p " [0 - 5] " choice
case $choice in
1)
cd /tmp
git clone https://bitbucket.org/MergingTechnologies/ravenna-alsa-lkm.git
chmod u+x ravenna-alsa-lkm/Butler/Merging_RAVENNA_Daemon
rm -r /opt/ravenna-alsa 2>/dev/null
mv ravenna-alsa-lkm/Butler /opt/ravenna-alsa
rm -r ravenna-alsa-lkm/

cat > /opt/ravenna-alsa/ravenna_start.sh <<EOF
#!/bin/bash

cd /opt/ravenna-alsa/
LD_PRELOAD=/usr/lib64/libcurl.so.4 /opt/ravenna-alsa/Merging_RAVENNA_Daemon
#/root/ravenna-alsa-lkm/Butler/Merging_RAVENNA_Daemon
EOF

chmod +x /opt/ravenna-alsa/ravenna_start.sh

cat > /etc/init.d/ravenna-alsa <<\EOF
#!/sbin/openrc-run

user="root:root"
logfile="/var/log/ravenna.log"

start_stop_daemon_args="--user $user"

command="/opt/ravenna-alsa/ravenna_start.sh"
#command="cd /root/ravenna-alsa-lkm/Butler/ && ./Merging_RAVENNA_Daemon"

#command_args="-d"
#command_args="
#	-f $logfile
#"


command_background=yes
pidfile=/run/ravenna.pid

#start_stop_daemon_args="--background --make-pidfile --stderr ${logfile}"


depend() {
    need net
    use alsasound
    after bootmisc
    avahi-daemon
}

start_pre() {
    checkpath --file --owner $user --mode 0644 $logfile
}

stop() {
    ebegin "ravenna"
    start-stop-daemon --stop --exec $command\
    --retry 15 --pidfile $pidfile
    pkill Merging_RAVENNA
    eend $?
}
EOF

chmod +x /etc/init.d/ravenna-alsa
echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; ravenna ;;
2)
if
uname -r | grep "RAVENNA" 2>/dev/null; then
   echo -e "\n kernel control\e[38;5;154m   [OK]\e[0m\n"
   echo -e "\n \e[38;5;154mWait...\e[0m\n"
  else
    echo -e "\n kernel control\e[38;5;197m  [FAILED]\e[0m\n"
    echo -e "The system must be booted with one of the two RAVENNA kernels"
    echo -e "use the \e[38;5;154mselectkernel\e[0m command to select the right kernel and restart the system"
    echo -e "try again to install ravenna after reboot"
    exit 0
  fi


depmod -a
insmod /lib/modules/$(uname -r)/kernel/sound/drivers/MergingRavennaALSA.ko

mkdir /etc/modules-load.d 2>/dev/null
touch /etc/modules-load.d/ravenna.conf 2>/dev/null
echo "MergingRavennaALSA" > /etc/modules-load.d/ravenna.conf
rc-service avahi-daemon start
rc-update add avahi-daemon default
rc-service ravenna-alsa start
rc-update add ravenna-alsa default
echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; ravenna ;;
3)
rc-update delete avahi-daemon
rc-update delete ravenna-alsa
rm /etc/modules-load.d/ravenna.conf 2>/dev/null
echo -e "$Yellow press ENTER to continue $Color_Off" ; read -n1 ; ravenna ;;
4) systemm ;;
5) menu ;;
0) esci ;;
*) echo -e "$Red Invalid choice...$Color_Off" && sleep 2 ;;
esac
}
