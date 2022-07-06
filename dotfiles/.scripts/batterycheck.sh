#!/bin/bash
#
# low battery warning
#

THRESHOLD=20
BATTERY=/sys/class/power_supply/BAT1
CHARGING=$(cat /sys/class/power_supply/BAT1/online)

if [[ CHARGING -eq "1" ]]; then
    echo "Charging, stopping early..."
    exit 0
fi

REM=`grep "POWER_SUPPLY_ENERGY_NOW" $BATTERY/uevent | awk -F= '{ print $2 }'`
FULL=`grep "POWER_SUPLY_ENERGY_FULL_DESIGN" $BATTERY/uevent | awk -F= '{ print $2 }'`
PERCENT=`echo $(( $REM * 100 / $FULL ))`

if [ $PERCENT -le "$THRESHOLD" ]; then
    echo "Low battery ($PERCENT% - threshold: $THRESHOLD)"
    notify-send "Battery low!" -u critical
else
    echo "Battery sufficiently charged ($PERCENT%)"
fi
