#!/bin/sh

# DiscoPWM ver. 0.1a
# By Duke Nukem, May 2020

# variables
smoko="usleep 200000"
send="telnet 192.168.42.1"
pwmpath="/sys/class/pwm/"

source /data/lib/ftp/uavpal/conf/buttons #user config file

b291a='*type 1 (EV_KEY), code 291 (BTN_TOP), value 1*'
b291z='*type 1 (EV_KEY), code 291 (BTN_TOP), value 0*'
b292a='*type 1 (EV_KEY), code 292 (BTN_TOP2), value 1*'
b292z='*type 1 (EV_KEY), code 292 (BTN_TOP2), value 0*'
b293a='*type 1 (EV_KEY), code 293 (BTN_PINKIE), value 1*'
b293z='*type 1 (EV_KEY), code 293 (BTN_PINKIE), value 0*'
b294a='*type 1 (EV_KEY), code 294 (BTN_BASE), value 1*'
b294z='*type 1 (EV_KEY), code 294 (BTN_BASE), value 0*'
b298a='*type 1 (EV_KEY), code 298 (BTN_BASE5), value 1*'
b298z='*type 1 (EV_KEY), code 298 (BTN_BASE5), value 0*'
b299a='*type 1 (EV_KEY), code 299 (BTN_BASE6), value 1*'
b299z='*type 1 (EV_KEY), code 299 (BTN_BASE6), value 0*'

act_serv() # This function is activated whenever an assigned button is pressed
{
# get user defined values from config file
	eval b000a=$"$b000"act
	eval b000p=$"$b000"pwm
	eval b000z=$"$b000"zero 
	eval b000c=$"$b000"code

# Send servo actuation and code commands to Disco
	( echo "echo $b000a > $pwmpath$b000p/duty_ns" && $smoko ) | $send &>/dev/null  # Command sent to servo
	( eval echo "$b000c" && $smoko ) | $send &>/dev/null	#code sent to Disco
}

zero_serv() #Function activated when assigned button is released
{
	( echo "echo $b000z > $pwmpath$b000p/duty_ns" && $smoko ) | $send &>/dev/null
}

#Button event listener
evtest /dev/input/event0 | while read line; do
	case $line in
		$b292a) b000="b292"; act_serv ;; 
		$b292z) b000="b292"; zero_serv ;;
		$b293a) b000="b293"; act_serv ;;
		$b293z) b000="b293"; zero_serv ;;
		$b294a) b000="b294"; act_serv ;;
		$b294z) b000="b294"; zero_serv ;;
		$b298a) b000="b298"; act_serv ;;
		$b298z) b000="b298"; zero_serv ;;
		$b299a) b000="b299"; act_serv ;;
		$b299z) b000="b299"; zero_serv ;;
	esac
done

