#!/bin/bash

BATPATH=/sys/class/power_supply/BAT1
BAT_FULL=$BATPATH/energy_full
BAT_NOW=$BATPATH/energy_now

bf=$(cat $BAT_FULL)
bn=$(cat $BAT_NOW)

if [ $(( 100 * $bn / $bf )) -lt 15 ]
then
	echo "Battery level: $(( 100 * $bn / $bf ))"
else
	dunstify -u critical "Warning: low battery\!" -i /usr/share/icons/HighContrast/16x16/status/battery-caution.png
fi
