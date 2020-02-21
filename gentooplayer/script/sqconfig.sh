#!/bin/bash

#############################################################################
#Easy Audio Setup: semi-automated installation and configuration of
# LMS+Squeezelite audio systems on Debian GNU/Linux OS.
#
# Copyright 2015,2016 Paolo 'UnixMan' Saggese <pms@audiofaidate.org>
# Released under the terms of the GNU General Public License, see:
# http://www.gnu.org/copyleft/gpl.html

# definizione delle funzioni
##############################################################################

function fail() {
    echo -e "\nFatal ERROR: $1\n\nAborted."
    exit $(false)
}

##############################################################################

function pausa() {
    echo
    read -s -p 'Press "Enter" to continue...'
    clear
    echo
}

##############################################################################

function run_as_root() {
    [ "$(whoami)" == "root" ] || {
        echo -e '\a\nATTENZIONE: questo script deve essere eseguito dal "SuperUser" (utente root).'
        exec su -c "$0"
    }
}

##############################################################################

function setup_workdir() {
    # setup delThe directory di lavoro
    myName=$(basename "$0")
    myWorkdir="/var/tmp/$myName.$(date '+%F.%H-%M-%S')"
    [ ! -e "$myWorkdir" ] && mkdir "$myWorkdir"
    cd "$myWorkdir" || fail "impossibile accedere alThe directory di lavoro: $myWorkdir"
}

function run_alsamixer() {
    # esegue alsamixer per la verifica delle impostazioni
    clear
    echo
    cat <<-EOAMIX | less
  (use the arrow keys and PgUp / PgDn to scroll the text.
  Press the "q" key to exit this viewer).

  "Alsamixer" will now be launched, an interface to the ALSA "mixer".

  Verify that the audio output device settings are
  correct; in particular, check that the volumes are not placed
  to zero and that the output (s) are not muted (it must not be present
  an "M" below the volume bar). Use:

  * the "F6" key to choose the output device to act on
  (the one you have chosen is preselected);

  * the "arrow" keys left / right to move between the cursors;

  * the "arrow" keys up / down to change the value of the cursors;

  * the 'm' key to activate / deactivate the "mute";

  * the "Esc" key to exit alsamixer.

	EOAMIX
    alsamixer $(test -v myCDev && echo "-c $myCard")
}
function select_outupt_dev() {
    # verifica della disponibilità e selezione del dispositivo di uscita
    myCard=""
    while [ "$myCard" == "" ]
    do
        clear
        IFS=$'\n'
        outDev=($(aplay -l |awk '/^card / { print $0 }') "My device is not in the list")
        unset IFS
        maxCardNum=$[ ${#outDev[@]}-1 ]
        if [ $maxCardNum -le 0 ]
        then
            echo -e '\n\a\nTTENTION: the system has not recognized any audio interface!\n'
            pausa
            myCard=-1 # fake
        else
            echo -e '\nList of audio output devices recognized by the system;\nselect the output device that you intend to use:\n'
            for (( i = 0 ; i < ${#outDev[@]} ; i++ ))
            do
                echo -e "$i) \t${outDev[$i]}";
            done
            echo
            read -p 'Type the corresponding number and press enter: ' SceltaDispositivo
            echo
            if [[ "$SceltaDispositivo" =~ ^[0-9]+$ ]] && [ "$SceltaDispositivo" -lt $maxCardNum ]
            then
                myCard=$(echo "${outDev[$SceltaDispositivo]}" |sed -r 's/card\s+([0-9]+).*/\1/')
                myCDev=$(echo "${outDev[$SceltaDispositivo]}" |sed -r 's/.*device\s+([0-9]+).*/\1/')
                echo -e "Choice made: '$(echo ${outDev[$SceltaDispositivo]})' (hw:$myCard,$myCDev)\n"
                read -s -N1 -p 'Confirm and proceed? (y/N)'
                if [ "$REPLY" == "y" ]
                then
                    myCardName=$(cat /proc/asound/card$myCard/id)
                    myOutputDev="hw:CARD=$myCardName,DEV=$myCDev"
                    #test_output_dev || myCard=""
                else
                    myCard=""
                fi
        elif [[ "$SceltaDispositivo" =~ ^[0-9]+$ ]] && [ "$SceltaDispositivo" -eq $maxCardNum ]
            then
                myCard=-1
            else
                echo -e "\a\nErrore: type a number between 0 and $maxCardNum."
                pausa
            fi
        fi
        if [ $myCard != "" ] && [ $myCard -lt 0 ]
        then
            cat <<-AUDIOHWM | less
      (use the arrow keys and PgUp / PgDn to scroll the text.
    Press the "q" key to exit this viewer).

    If the audio output device you want to use has not been
    recognized by the system, first check that it is switched on and
    is connected correctly.

    WARNING: some devices may require one to be followed
    precise ignition and / or connection sequence. If this does not come
    respected the interface may not work correctly and / or not
    be recognized at all by the system.

    Unfortunately, this (possible) sequence changes from one device to another:
    there is no general rule valid for everyone.
    E.g. some devices must be turned on before they are connected
    to the computer, while for others the opposite is true - they must be turned on
    only after they have been connected.
    It is also possible that in some cases the device must be switched on
    and / or connected only after the system has completed the boot sequence,
    while in others the opposite may be true (the device must be
    connected and switched on before startup, when the computer is switched off), etc.

    It is advisable to immediately carry out all the necessary checks; so far as
    it is necessary to restart the system, once the sequence has been completed
    start you will have to manually restart this script in order to complete the
    configuration.

    If despite all your device is not recognized,
    it is possible that it is not supported by the running kernel.

    In some cases the problem can be solved trivially by using one
    latest version of the kernel, which contains the most updated ALSA drivers:
    then try rebooting the system with a newer kernel, then
    start this script again.

    In other cases it may be necessary to install "drivers" (modules
    of the kernel) additional, not included directly in the kernel but provided
    separately from the hardware manufacturer or third parties.
    In this case unfortunately it is not possible to manage the thing automatically
    and you will have to intervene manually.
    This done, however, you can run this script again to complete
    the configuration.

    Finally, unfortunately there are some devices that, by choice of theirs
    same manufacturers, they are not and can not be supported by systems
    other than expected (usually certain versions of Windows
    and / or MacOS). In that case there is very little to do ... if not get rid of it
    and replace them with others that work well with Linux.

    (use the arrow keys and PgUp / PgDn to scroll the text.) Press
    the "q" key to exit this viewer).

	AUDIOHWM
            clear
            echo
            read -s -N1 -p 'Check again if the interface has been recognized? (y/N)'
            echo
            if [ "$REPLY" != "N" ]; then
                myCard=""
            else
                cat <<-AUDIOHW3

      You can choose whether to proceed with the installation of the basic setup only,
      then reboot the system and start the script again to try again
      recognition of the audio output device with the new kernel o
      end the automatic procedure here.

	AUDIOHW3
                read -s -N1 -p 'Proceed with the installation of the basic setup only? (y/N)'
                echo
                if [ "$REPLY" == "s" ]; then
                    TipoSistema="custom"
                else
                    echo -e '\nAbortive procedure as required. Bye.\n'
                    exit 1
                fi
            fi
        fi
    done
}

function select_sample_rate() {
    declare -a rates=(	\
            '44100'		\
            '48000'		\
            '88200'		\
            '96000'		\
            '176400'	\
            '192000'	\
            '352800'	\
            '384000'	\
            '705600'	\
            '768000'	\
        )
    # no existing hardware support for '705600' and '768000'.
    if [ "$1" == "" ]; then
        local prompt='Select a sample rate:'
    else
        local prompt="$1"
    fi
    sample_rate=""
    while [ "$sample_rate" == "" ]
    do
        clear
        echo -e "\n$prompt\n"
        for (( i = 0 ; i < ${#rates[@]} ; i++ ))
        do
            echo -e "$i) \t${rates[$i]}";
        done
        echo
        read -p 'Type the corresponding number and press enter: ' choice
        echo
        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -lt ${#rates[@]} ]; then
            sample_rate="${rates[$choice]}"
            echo -e "Choice made: '$sample_rate'\n"
            read -s -N1 -p 'Confirm and proceed? (y/N)'
            clear
            echo
            [ "$REPLY" != "y" ] && sample_rate=""
        else
            echo -e "\a\nErrore: type a number between 0 and $[ ${#rates[@]}-1 ]."
            pausa
        fi
    done
}
function select_buffer() {
    declare -a ram=(	\
            '262144'		\
            '524888'		\
            '1048576'		\
        )
    if [ "$1" == "" ]; then
        local prompt='Impostazione buffer, selezionare in base alla quantitá di RAM presente sul sistema, 0-1GB, 1-2GB, 2-4GB:'
    else
        local prompt="$1"
    fi
    buffer=""
    while [ "$buffer" == "" ]
    do
        clear
        echo -e "\n$prompt\n"
        for (( i = 0 ; i < ${#ram[@]} ; i++ ))
        do
            echo -e "$i) \t${ram[$i]}";
        done
        echo
        read -p 'Type the corresponding number and press enter: ' choice
        echo
        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -lt ${#ram[@]} ]; then
            buffer="${ram[$choice]}"
            echo -e "Choice made: '$buffer'\n"
            read -s -N1 -p 'Confirm and proceed? (y/N)'
            clear
            echo
            [ "$REPLY" != "y" ] && buffer=""
        else
            echo -e "\a\nErrore: type a number between 0 and $[ ${#ram[@]}-1 ]."
            pausa
        fi
    done
}

function select_sample_rate_range() {
    # selezione dei sample-rate supportati dal dispositivo di uscita
    #
    ratesRange=""
    while [ "$ratesRange" == "" ]
    do
        clear
        cat <<-EOSRR | less

  (use the arrow keys and PgUp / PgDn to scroll the text.
  Press the "q" key to exit this viewer).

  You will now have to select the sampling frequencies of the
  digital audio streams ("sample-rate") that are directly supported
  from your audio output device.

  The actual limits of the system as a whole should be indicated: if
  use a system consisting of a separate interface + DAC, each with
  its own limits, the values ​​to be indicated are given by the subset of the
  sample-rates supported by both the interface and the DAC.

  For example, if you have a USB interface that supports all sample-rates a
  starting from 44.1 up to 384 kHz, but the connected DAC arrives only
  up to 192 kHz, the max limit to be specified is 192 kHz.
  If, on the other hand, a DAC able to arrive is connected to the same interface
  up to 768 kHz, the limit would be placed by the interface. Therefore in this
  in case the max. value to be specified would be 384 kHz.

  If you have any particular reason to want to do it, nothing forbids
  specify more restrictive limits than those imposed by
  your hardware. For example, if your system is able to manage
  streams up to 384 kHz but it works / sounds better up to 192 kHz, nothing
  forbids to set this value as an upper limit.

  Obviously the opposite is not true: set the limits to values ​​that
  exceed the maximum and / or are less than the minimum allowed by yours
  hardware is an error that leads to failure of the system.

  N.B .: regardless of the limits set, the system will be in any case
  can handle incoming audio streams with any sample rate that
  is supported by the software (LMS and squeezelite). If these exceed i
  physical limits of your hardware or anyway those set here, the
  software will automatically resample these streams in a way
  to make them compatible (make them fall within the limits).

  In fact, a possible reason for wanting to set more limits
  restrictive compared to what is allowed by the hardware is just that
  to "force" the resampling of incoming audio streams.

  For example, if your hardware supports audio streams up to 96 kHz and
  set this value as both a lower and a higher limit,
  the result will be that all incoming flows will be resampled
  just at this frequency ("upsampling" or a
  "downsampling", depending on whether the input flow is frequent
  sampling rate that is less than or greater than that required).

  Another commonly used possibility is to set the
  lower and upper limit to the frequencies corresponding to the maximums
  multiple integers supported by the hardware of the two "basic" frequencies,
  44.1 and 48 kHz, e.g. 176.4 and 192 kHz, or 352.8 and 384 kHz, etc.

  In this way it is possible to obtain a "synchronous resampling" of the
  incoming flows, that is to say that they are always resampled
  at most multiple integer (supported) of their base frequency.

  If instead you want (as far as possible) to avoid resampling
  (at least on the "player"), correctly indicate the actual limits
  minimum and maximum imposed by your hardware.

  (use the arrow keys and PgUp / PgDn to scroll the text.
  Press the "q" key to exit this viewer).

	EOSRR
        clear
        select_sample_rate 'Select the MAXIMUM sampling rate supported:'
        maxRate=$sample_rate
        select_sample_rate 'Select the MINIMUM sampling rate supported:'
        minRate=$sample_rate
        if [ $maxRate -eq $minRate ]; then
            ratesRange="$minRate"
        elif [ $maxRate -lt $minRate ]; then
            ratesRange="$maxRate-$minRate"
        else
            ratesRange="$minRate-$maxRate"
        fi
        echo -e "\nSelected sampling frequency range: '$ratesRange'\n"
        read -s -N1 -p 'Confirm and proceed? (y/N)'
        clear
        echo
        [ "$REPLY" != "y" ] && ratesRange=""
    done
}
run_as_root
#setup_workdir
run_alsamixer
select_outupt_dev
#select_sample_rate
select_sample_rate_range
#select_buffer
###dsd###
dsd='$dsd'
###########


cat > /etc/conf.d/squeezelite-R2 <<EOF
# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# /etc/conf.d/squeezelite-R2: configuration for /etc/init.d/squeezelite-R2

# Switches to pass to Squeezelite-R2. See 'squeezelite-R2 -h' for
# a description of the possible switches.
#
# Example setting the server IP, the ALSA output device, the player name
# and visualiser support:
# SL_OPTS="-s 192.168.1.56 -o sysdefault -n $HOSTNAME -v"
#
# Example seleting pulse output:
# export PULSE_SERVER=localhost
# SL_OPTS="-s 192.168.1.56 -o pulse -n $HOSTNAME -v"
#for more information on the various configuration options visit http://marcoc1712.it/?page_id=139
#
#
####### DSD ##############
#remove the comment (#) in front of the line to be used as parameter dsd and comment (#) the others.
#default is in use dop (without comment #)
dsd='-D'         #dop
#dsd='-D :u32be' #native
#dsd='-D :u32le' #native
#dsd='-D :u16be' #native
#dsd='-D :u16le' #native
#dsd='-D :u8'    #native
######### ende DSD ############################
#
SL_OPTS="-C 1 $dsd -o $myOutputDev -r $ratesRange -a 499:3::0 -n GentooPlayer-R2 -m 00:e0:4s:78:d1:46"
EOF




cat > /etc/conf.d/squeezelite <<EOF
# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# /etc/conf.d/squeezelite: configuration for /etc/init.d/squeezelite

# Switches to pass to Squeezelite. See 'squeezelite' for
# a description of the possible switches.
#
# Example setting the server IP, the ALSA output device, the player name
# and visualiser support:
# SL_OPTS="-s 192.168.1.56 -o sysdefault -n $HOSTNAME -v"
#
# Example seleting pulse output:
# export PULSE_SERVER=localhost
# SL_OPTS="-s 192.168.1.56 -o pulse -n $HOSTNAME -v"
#for more information on the various configuration options visit http://marcoc1712.it/?page_id=139
#
#
####### DSD ##############
#remove the comment (#) in front of the line to be used as parameter dsd and comment (#) the others.
#default is in use dop (without comment #)
dsd='-D'         #dop
#dsd='-D :u32be' #native
#dsd='-D :u32le' #native
#dsd='-D :u16be' #native
#dsd='-D :u16le' #native
#dsd='-D :u8'    #native
######### ende DSD ############################
#
SL_OPTS="-C 1 -W $dsd -o $myOutputDev -r $ratesRange -a 499:3::0 -n GentooPlayer -m 00:f0:4c:68:d1:47"
EOF





cat > /etc/mpd.conf <<EOF
# An example configuration file for MPD.
# Read the user manual for documentation: http://www.musicpd.org/doc/user/
# Files and directories #######################################################
music_directory			"/var/lib/mpd/music"
playlist_directory		"/var/lib/mpd/playlists"
db_file			"/var/lib/mpd/database"
log_file			"/var/lib/mpd/log"
pid_file			"/var/lib/mpd/pid"
state_file			"/var/lib/mpd/state"
#
# General music daemon options ################################################
user				"mpd"
bind_to_address		"any"
#
# Input #######################################################################
#

input {
        plugin "curl"
        enabled	"yes"
#       proxy "proxy.isp.com:8080"
#       proxy_user "user"
#       proxy_password "password"
}

#
###############################################################################

# Audio Output ################################################################
#
audio_output {
  type "alsa"
  name "no resample"
	device "$myOutputDev"
	#priority "RR:49"
 	enabled "yes"
#    use_mmap  "yes"
#    buffer_time     "2097152"
#    eriod_time     "524288"
}


##########Audio Output Resempler############

#######Use libsamplerate#############

##type	The interpolator type. See below for a list of known types.
##Best Sinc Interpolator or 0	Band limited sinc interpolation, best quality, 97dB SNR, 96% BW.
##Medium Sinc Interpolator or 1	Band limited sinc interpolation, medium quality, 97dB SNR, 90% BW.
##Fastest Sinc Interpolator or 2	Band limited sinc interpolation, fastest, 97dB SNR, 80% BW.
##ZOH Sinc Interpolator or 3	Zero order hold interpolator, very fast, very poor quality with audible distortions.
##Linear Interpolator or 4	Linear interpolator, very fast, poor quality.

######uncomment to use#############
#resampler {
#plugin "libsamplerate"
#type "1"
#}

#audio_output {
#name "librate192"
#type "alsa"
#device "$myOutputDev"
#format "192000:32:2"
#auto_resample "no"
#auto_format "no"
#enabled "yes"
# #use_mmap  "yes"
#}

#audio_output {
#name "librate384"
#type "alsa"
#device "$myOutputDev"
#format "384000:32:2"
#auto_resample "no"
#auto_format "no"
#enabled "yes"
# #use_mmap  "yes"
#}

########Fine uncomment resample libsamplerate################

###########Use Soxr###########################################
##quality	The libsoxr quality setting. Valid values see below.
##threads	The number of libsoxr threads. 0 means automatic. The default is 1 which disables multi-threading.
##Valid quality values for libsoxr:
##very high
##high (the default)
##medium
##low
##quick


######uncomment to use#############
#resampler {
#plugin "soxr"
#quality "very high"
#threads "0"
#}

#audio_output {
#name "Soxr192"
#type "alsa"
#device "$myOutputDev"
#format "192000:32:2"
#auto_resample "no"
#auto_format "no"
#enabled "yes"
# #use_mmap  "yes"
#}

#audio_output {
#name "Soxr384"
#type "alsa"
#device "$myOutputDev"
#format "384000:32:2"
#auto_resample "no"
#auto_format "no"
#enabled "yes"
# #use_mmap  "yes"
#}

########Fine uncomment resample Soxr################

# An example of a httpd output (built-in HTTP streaming server):
#
#audio_output {
#        type             "httpd"
#        name            "cb"
#        encoder       "vorbis"
#        port             "8000"
#        quality         "4"
##     bitrate         "320"
##     format          "44100:16:2"
#}
#
#




#######################################
#     MIXER

# mixer_type   "hardware"
# mixer_type   "software"
mixer_type   "none"


#######################################
#     BUFFER

# audio_buffer_size  "2048"
# buffer_before_play  "10%"
#audio_buffer_size  "98304"
#buffer_before_play  "25%"

audio_buffer_size  "16384"
#buffer_before_play  "25%"

#buffer_time     "2097152"
#period_time     "524288"


#id3v1_encoding   "UTF-8"
filesystem_charset  "UTF-8"

EOF

echo -e "You want to start mpd? y/n"
read start
if [ "$start" = "y" ]; then
    /etc/init.d/mpd restart
fi

echo
echo
echo -e "You want to start squeezelite-R2? y/n"
read start
if [ "$start" = "y" ]; then
    /etc/init.d/squeezelite-R2 restart
fi

echo
echo
echo -e "You want to start squeezelite standard? y/n"
read start
if [ "$start" = "y" ]; then
    /etc/init.d/squeezelite restart
fi

/opt/.gentooplayer/GentooPlayer/gentooplayer/dietpi-process_tool 1 &>/dev/null
