#!/bin/bash
. /opt/.gentooplayer/function/fcolors.sh
###########################
esci(){
    clear
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    echo
    echo -e "$color1 GentooPlayer$color_off: use the $color1"home"$color_off command to return to the main screen "
    echo
    echo -e " \e[38;5;154m────────────────────────────────────────────\e[0m"
    exit
}
############################
function audio {
    echo "AUDIO CARDS"
    cards_path=$(echo $(find /proc/asound -type d -name "card*") | awk  '{print $NF}' | tail -c 2)
    fw_devices=$(find /sys/devices/ -maxdepth 4 -type d -name "fw*" | wc -l)
    echo -e -n "CARD\tTYPE\t\t\tADDRESS\t\t\tNAME
--------------------------------------------------------------------------------------------------------
    "
    for (( i=0; i<=$cards_path; i++ )); do
        if [[ -d  "/proc/asound/card"$i"" ]]; then
            echo -n "card$i"
            usbid=$(find "/proc/asound/card"$i -type f -name "usbid" -exec cat {} \; )
            if [[ -z $usbid ]]; then
                if [[ -d "/proc/asound/card"$i"/firewire" ]]; then
                    echo -e -n "\tFirewire Audio card"
                    for (( j=0; j<$fw_devices; j++ )); do
                        if [[ $(cat /proc/asound/cards | egrep "fw$j") ]]; then
                            echo -e -n "\tfw$j"
                            echo -n "   --> -- "
                            echo -e -n "\t\t$(find "/proc/asound/card"$i -type f -name "info" -exec cat {} \; | egrep "name" | head -1 | sed 's/name\:\ //g' | awk '{print $1,$2,$3}')"
                        fi
                    done
                else
                    echo -e -n "\tInternal Audio card"
                    echo -e -n "\tcard"$i
                    echo -n " --> -- "
                    echo -e -n "\t\t$(find "/proc/asound/card"$i -type f -name "info" -exec cat {} \; | egrep "id" | head -1 | sed 's/id\:\ //g' | awk '{print $1,$2,$3}' )"
                fi
            else
                echo -e -n "\tUSB Audio card"
                echo -e -n "\t\tusb"$(cat "/proc/asound/card"$i"/usbbus" | rev | cut -b5)
                echo -n "  --> "$usbid
                echo -e -n "\t$(find "/proc/asound/card"$i -type f -name "usbmixer" -exec cat {} \; | egrep "Card" | head -1 | sed 's/Card\://g' | awk '{print $1,$2,$3}' )"
            fi
            echo ""
            if [[ -a  "/proc/asound/card"$i"/pcm0p/sub0/hw_params" ]]; then
                echo -e "card$i\tSTATUS  --> "$(cat /proc/asound/card"$i"/pcm0p/sub0/hw_params)
            else
                echo -e "card$i\tSTATUS  --> unavailable"
            fi
            echo "--------------------------------------------------------------------------------------------------------"
        fi
    done
}
############
function sqc {
    nano /etc/conf.d/squeezelite
    /etc/init.d/squeezelite restart
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
}
###################
function sqr {
    /etc/init.d/networkaudiod stop
    /etc/init.d/mpd stop
    /etc/init.d/upmpdcli stop
    /etc/init.d/roonbridge stop
    /etc/init.d/roonserver stop
    /etc/init.d/squeezelite-R2 stop
    /etc/init.d/hqplayerd stop
    /etc/init.d/squeezelite restart
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
}
#####################################
function sqrestart {
    /etc/init.d/squeezelite restart
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
}
##################################
function sqstop {
    /etc/init.d/squeezelite stop
}
##################################
function sqc2 {
    nano /etc/conf.d/squeezelite-R2
    /etc/init.d/squeezelite-R2 restart
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
}
###################
function sqr2 {
    /etc/init.d/networkaudiod stop
    /etc/init.d/mpd stop
    /etc/init.d/upmpdcli stop
    /etc/init.d/roonbridge stop
    /etc/init.d/roonserver stop
    /etc/init.d/logitechmediaserver stop
    /etc/init.d/squeezelite stop
    /etc/init.d/hqplayerd stop
    /etc/init.d/squeezelite-R2 restart
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
}
#####################################
function sqrestart2 {
    /etc/init.d/squeezelite-R2 restart
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
}
##################################
function sqstop2 {
    /etc/init.d/squeezelite-R2 stop
}
##################################
function mpdc {
    nano /etc/mpd.conf
    /etc/init.d/mpd restart
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
}
###################
function mpdr {
    /etc/init.d/networkaudiod stop
    /etc/init.d/roonbridge stop
    /etc/init.d/roonserver stop
    /etc/init.d/logitechmediaserver stop
    /etc/init.d/squeezelite-R2 stop
    /etc/init.d/squeezelite stop
    /etc/init.d/hqplayerd stop
    /etc/init.d/mpd restart
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
}
##############################
function mpdrestart {
    /etc/init.d/mpd restart
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
}
###########################
function mpdstop {
    /etc/init.d/mpd stop
    /etc/init.d/upmpdcli stop
}
##############################
function nadr {
    /etc/init.d/mpd stop
    /etc/init.d/upmpdcli stop
    /etc/init.d/roonbridge stop
    /etc/init.d/roonserver stop
    /etc/init.d/logitechmediaserver stop
    /etc/init.d/squeezelite-R2 stop
    /etc/init.d/squeezelite stop
    /etc/init.d/hqplayerd stop
    /etc/init.d/networkaudiod restart
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
}
################################
function nadrestart {
    /etc/init.d/networkaudiod restart
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
}
################################
function nadstop {
    /etc/init.d/networkaudiod stop
}
################################
function roonr {
    /etc/init.d/mpd stop
    /etc/init.d/upmpdcli stop
    /etc/init.d/roonserver stop
    /etc/init.d/logitechmediaserver stop
    /etc/init.d/squeezelite-R2 stop
    /etc/init.d/squeezelite stop
    /etc/init.d/networkaudiod stop
    /etc/init.d/hqplayerd stop
    /etc/init.d/roonbridge restart
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
}
#################################
function roonrestart {
    /etc/init.d/roonbridge restart
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
}
################################
function roonstop {
    /etc/init.d/roonbridge stop
}
################################
function rtirqconf {
    /opt/.gentooplayer/script/rtirqconf.sh
}
########################
function ipstatic {
    /opt/.gentooplayer/script/ipstatic.sh
}
######################
function sqconfig {
    /opt/.gentooplayer/script/sqconfig.sh
}
#####################
function kernelinstall {
    /opt/.gentooplayer/script/kernelinstall.sh
}
###############################
function grubconf {
    /opt/.gentooplayer/script/grubconf.sh
}
####################################
function rtirqc {
    nano /etc/conf.d/rtirq
    /etc/init.d/rtirq restart
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
}
###################################
function rtirqadd {
    rc-update add rtirq default
}
#############################
function rtirqremove {
    rc-update delete rtirq default
}
############################
function mpdadd {
    rc-update add mpd default
}
###########################
function mpdremove {
    rc-update delete mpd default
}
#############################
function sqadd {
    rc-update add squeezelite default
}
############################
function sqadd2 {
    rc-update add squeezelite-R2 default
}
############################
function sqremove {
    rc-update delete squeezelite default
}
#################################
function sqremove2 {
    rc-update delete squeezelite-R2 default
}
#################################
function nadadd {
    rc-update add networkaudiod default
}
#################################
function nadremove {
    rc-update delete networkaudiod default
}
####################################
function lmsadd {
    rc-update add logitechmediaserver default
}
####################################
function lmsremove {
    rc-update delete logitechmediaserver default
}
#########################################
function lmsrestart {
    /etc/init.d/logitechmediaserver restart
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
}
######################################
function lmsstop {
    /etc/init.d/logitechmediaserver stop
}
######################################
function roonadd {
    rc-update add roonbridge default
}
########################################
function roonremove {
    rc-update delete roonbridge default
}
##########################################
function roonsadd {
    rc-update add roonserver default
}
########################################
function roonsremove {
    rc-update delete roonserver default
}
#####################################
function roonsrestart {
    /etc/init.d/roonserver restart
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
}
################################
function roonserverstop {
    /etc/init.d/roonserver stop
}
##################################
function playerstop {
    /etc/init.d/squeezelite-R2 stop
    /etc/init.d/squeezelite stop
    /etc/init.d/mpd stop
    /etc/init.d/upmpdcli stop
    /etc/init.d/networkaudiod stop
    /etc/init.d/roonbridge stop
    /etc/init.d/hqplayerd stop
}
######################################
function serverstop {
    /etc/init.d/logitechmediaserver stop
    /etc/init.d/roonserver stop
}
##########################################
function testsetting {
    /opt/.gentooplayer/script/testsetting.sh
}
##############################
function testsetting1 {
    /opt/.gentooplayer/script/testsetting1.sh
}
##############################
function normalsetting {
    /opt/.gentooplayer/script/normalsetting.sh
}
##############################
function normalsetting1 {
    /opt/.gentooplayer/script/normalsetting1.sh
}
###############################
#function xfceinstall {
#/opt/.gentooplayer/script/xfceinstall.sh
#}
##################################
function vncinstall {
    /opt/.gentooplayer/script/vncinstall.sh
}
################################
function ricompila {
    /opt/.gentooplayer/script/ricompila.sh
}
################################
#function affinity {
#/opt/.gentooplayer/script/affinity.sh
#}
################################
#function prio {
#/opt/.gentooplayer/script/prio.sh
#}
################################
#function nices {
#/opt/.gentooplayer/script/nice.sh
#}
################################
function shutd {
    shutdown -h now
}
###############################
function mountfs {
    /opt/.gentooplayer/script/mountfs.sh
}
######################
function cmdset {
    /opt/.gentooplayer/script/cmdset.sh
}
######################
function swappoff {
    rc-update delete swap boot
}
######################
function selectdac {
    /opt/.gentooplayer/script/scelta_dac.sh
}
######################
function selectkernel {
    /opt/.gentooplayer/script/selectkernel.sh
}
#######################
function trimadd {
    /opt/.gentooplayer/script/trim.sh
}
######################
function home {
    clear
    . /etc/profile
}
#######################
function cpu-info {
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-cpuinfo
}
######################
function cpu-governor {
    /opt/.gentooplayer/script/cpu-governor.sh
}
######################
function cpu-governor-add {
    /opt/.gentooplayer/script/cpugovernoradd.sh
}
######################
function cpu-governor-remove {
    /opt/.gentooplayer/script/cpugovernoremove.sh
}
######################
function process-tool {
    /opt/.gentooplayer/script/process_tool.sh
}
######################
function process-tool-add {
    /opt/.gentooplayer/script/processtooladd.sh
}
######################
function process-tool-remove {
    /opt/.gentooplayer/script/processtoolremove.sh
}
######################
function irq-affinity {
    /opt/.gentooplayer/script/irq-affinity.sh
}
######################
function irqadd {
    /opt/.gentooplayer/script/irqadd.sh
}
######################
function irqremove {
    /opt/.gentooplayer/script/irqremove.sh
}
######################
function cloudshell {
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-cloudshell 1
}
######################
function mtu-test {
    /opt/.gentooplayer/GentooPlayer/gentooplayer/func/dietpi-optimal_mtu
}
######################
function players-commands {
    /opt/.gentooplayer/script/players-commands.sh
}
######################
function system-commands {
    /opt/.gentooplayer/script/system-commands.sh
}
######################
function console-off {
    /opt/.gentooplayer/script/console.sh
}
######################
function ssh-off {
    rc-update delete sshd default
}
############################
function buffer {
    /opt/.gentooplayer/script/buffer.sh
}
######################
function confset {
    /opt/.gentooplayer/script/confset.sh
}
######################
function twk {
    /opt/.gentooplayer/script/twk.sh
}
######################
function gp-update {
    /opt/.gentooplayer/script/gp-update.sh
}
######################
function alsa-up {
    /opt/.gentooplayer/script/alsa-up.sh
}
######################
function alsa-dw {
    /opt/.gentooplayer/script/alsa-dw.sh
}
######################
function hqr {
    /etc/init.d/networkaudiod stop
    /etc/init.d/mpd stop
    /etc/init.d/roonbridge stop
    /etc/init.d/roonserver stop
    /etc/init.d/squeezelite-R2 stop
    /etc/init.d/squeezelite stop
    /etc/init.d/hqplayerd restart
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
}
#####################################
function hqrestart {
    /etc/init.d/hqplayerd restart
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
}
##################################
function hqstop {
    /etc/init.d/hqplayerd stop
}
##################################
function hqdadd {
    rc-update add hqplayerd default
}
###########################
function hdremove {
    rc-update delete hqplayerd default
}
######################
function gp-menu {
    /opt/.gentooplayer/script/menu.sh
}
######################
function ramsystem {
    /opt/.gentooplayer/script/ramsystem.sh
}
######################
function upmrestart {
    /etc/init.d/upmpdcli restart
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
}
######################
function upmstop {
    /etc/init.d/upmpdcli stop
}
######################
function upmadd {
    rc-update add upmpdcli default
}
######################
function upmremove {
    rc-update delete upmpdcli default
}
######################
function upmc {
    nano /etc/upmpdcli.conf
    /etc/init.d/upmpdcli restart
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
}
######################
function bubblerestart {
    /etc/init.d/bubbleupnp restart
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
}
######################
function bubblestop {
    /etc/init.d/bubbleupnp stop
}
######################
function bubbleadd {
    rc-update add bubbleupnp default
}
######################
function bubbleremove {
    rc-update delete bubbleupnp default
}
######################
function moveroondatabase {
    /opt/.gentooplayer/script/moveroondatabase.sh
}
##########################
function wificonfig {
    /opt/.gentooplayer/script/wificonfig.sh
}
##########################
function ravenna {
    /opt/.gentooplayer/script/ravenna.sh
}
##########################
function process-restart {
    /opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1
}
##########################
function selectprofile {
    /opt/.gentooplayer/script/selectprofile.sh
}
##########################
function alsaswitching {
    /opt/.gentooplayer/script/alsasw.sh
}
##########################
function backuprestore {
    /opt/.gentooplayer/script/backups.sh
}
##########################
function webstop {
    /etc/init.d/web stop
}
##########################
function webrestart {
    /etc/init.d/web restart
}
##########################
function webadd {
    rc-update add web
}
##########################
function webremove {
    rc-update del web
}
##########################
function kernelupsw {
    /opt/.gentooplayer/script/kernelsw.sh
}
