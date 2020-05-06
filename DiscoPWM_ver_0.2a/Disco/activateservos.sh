#!/bin/sh

# DiscoPWM ver. 0.1a
# By Duke Nukem, May 2020
#
# This startup script activates servo rails 2-5 on CHUCK and sets default values

cd /sys/class/pwm

echo 1 > pwm_3/run

for pwm in 1 2 5 6; do
	echo $pwm > export
	echo 10000000 > pwm_$pwm/period_ns
	echo 1500000 > pwm_$pwm/duty_ns
	echo 1 > pwm_$pwm/run
done
