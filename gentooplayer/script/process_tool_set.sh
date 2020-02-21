#!/bin/bash
cpu=$(cat /proc/cpuinfo | grep processor | wc -l |  awk '{print $1-1}')


cat > /etc/default/.dietpi-process_tool <<EOF
##########  set here:

##########  nice level ################################################
##########  anice_save[$]=value #######################################
#######################################################################
### values 19 -20
### Negative values have a higher priority (eg: -10)
### Positive values have a lower priority (eg: 15)
### The default value is 0
########################################################################

############ CPU affinity ##############################################
############ aaffinity_save[$]='numerocpu' #############################
########################################################################
### di default l affinity is safe to all the cpu
### the interval goes from cpu 0 to cpumax
###change this range to a single CPU
### es. 2 - avoid CPU 0 - the kernel generally uses it
#########################################################################

############# Schedule Policy ###########################################
############# schedule_policy_save[$]='Tipodi_shedular' #################
#########################################################################
### SCHED_OTHER    : Normal (Default)
### SCHED_FIFO     : First In, First Out (Real-time, time-critical)
### SCHED_RR       : Round Robin (Real-time, time-critical)
### SCHED_BATCH    : Batch style execution
### SCHED_IDLE     : Background Jobs (Very low priority)
### SCHED_DEADLINE : Background Jobs (Very low priority)
##########################################################################

#############  Schedule Priority #########################################
#############  aschedule_priority_save[$]='valore_priority' ##############
##########################################################################
### Valori da 1 a 99
### Lower values are low priority
### Higher values are high priority
### va impostato solo con SCHED_FIFO e SCHED_RR
##########################################################################



######### Mpd #########################
aname_save[0]='bin/mpd'
anice_save[0]=0
aaffinity_save[0]='0-$cpu'
aschedule_policy_save[0]='SCHED_OTHER'
aschedule_priority_save[0]='0'

######### ssh #########################
aname_save[1]='sshd'
anice_save[1]=0
aaffinity_save[1]='0-$cpu'
aschedule_policy_save[1]='SCHED_OTHER'
aschedule_priority_save[1]='0'

######### RoonBridge #################
aname_save[2]='RoonBridge'
anice_save[2]=0
aaffinity_save[2]='0-$cpu'
aschedule_policy_save[2]='SCHED_OTHER'
aschedule_priority_save[2]='0'

aname_save[3]='RoonBridgeHelper'
anice_save[3]=0
aaffinity_save[3]='0-$cpu'
aschedule_policy_save[3]='SCHED_OTHER'
aschedule_priority_save[3]='0'

######### RoonBridge e Server ###########
aname_save[4]='RAATServer'
anice_save[4]=0
aaffinity_save[4]='0-$cpu'
aschedule_policy_save[4]='SCHED_OTHER'
aschedule_priority_save[4]='0'

########## RoonServer ###################
aname_save[5]='RoonAppliance'
anice_save[5]=0
aaffinity_save[5]='0-$cpu'
aschedule_policy_save[5]='SCHED_OTHER'
aschedule_priority_save[5]='0'

aname_save[6]='RoonServer'
anice_save[6]=0
aaffinity_save[6]='0-$cpu'
aschedule_policy_save[6]='SCHED_OTHER'
aschedule_priority_save[6]='0'

########## Squeezelite ################
aname_save[7]='squeezelite'
anice_save[7]=0
aaffinity_save[7]='0-$cpu'
aschedule_policy_save[7]='SCHED_OTHER'
aschedule_priority_save[7]='0'

######### Squeezelite-R" #############
aname_save[8]='squeezelite-R2'
anice_save[8]=0
aaffinity_save[8]='0-$cpu'
aschedule_policy_save[8]='SCHED_OTHER'
aschedule_priority_save[8]='0'

######### LMS #######################
aname_save[9]='slimserver.pl'
anice_save[9]=0
aaffinity_save[9]='0-$cpu'
aschedule_policy_save[9]='SCHED_OTHER'
aschedule_priority_save[9]='0'

########## networkaudiod NAD ##########
aname_save[10]='networkaudiod'
anice_save[10]=0
aaffinity_save[10]='0-$cpu'
aschedule_policy_save[10]='SCHED_OTHER'
aschedule_priority_save[10]='0'

########## LMS ##########
aname_save[11]='logitechmediaserver'
anice_save[11]=0
aaffinity_save[11]='0-$cpu'
aschedule_policy_save[11]='SCHED_OTHER'
aschedule_priority_save[11]='0'

########## HQplayerDesktop ##########
aname_save[12]='hqplayer'
anice_save[12]=0
aaffinity_save[12]='0-$cpu'
aschedule_policy_save[12]='SCHED_OTHER'
aschedule_priority_save[12]='0'

########## HQplayerEmbedded ##########
aname_save[13]='hqplayerd'
anice_save[13]=0
aaffinity_save[13]='0-$cpu'
aschedule_policy_save[13]='SCHED_OTHER'
aschedule_priority_save[13]='0'



########## Merging Ravenna start##########
#aname_save[13]='ravenna_start'
#anice_save[13]=0
#aaffinity_save[13]='0-$cpu'
#aschedule_policy_save[13]='SCHED_OTHER'
#aschedule_priority_save[13]='0'

########## Merging Ravenna##########
aname_save[14]='Merging_RAVENNA'
anice_save[14]=0
aaffinity_save[14]='0-$cpu'
aschedule_policy_save[14]='SCHED_OTHER'
aschedule_priority_save[14]='0'
EOF
