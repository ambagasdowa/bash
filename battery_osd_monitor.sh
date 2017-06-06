#!/bin/bash

while true
do
    battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`

if [ $battery_level -ge 100 ]; then
	if [ `acpi -a | awk '{print $3}'` = "on-line" ];then
		# notify-send "Battery charging above 99%. Please unplug your AC adapter!" "Charging: ${battery_level}%"
    echo "Battery charging above 100%. Please unplug your AC adapter!" "Charging: ${battery_level}%" | osd_cat -A right -p top -f -adobe-helvetica-*-*-*-*-16-*-*-*-*-*-*-* -c green -s 5
	fi
    elif [ $battery_level -le 15 ];then
	if [ `acpi -a | awk '{print $3}'` = "off-line" ];then
      # notify-send "Battery is lower 15%. Need to charging! Please plug your AC adapter." "Uncharging: ${battery_level}%"
      echo "Battery is lower 15%. Need to charging! Please plug your AC adapter." "Uncharging: ${battery_level}%" | osd_cat -A right -p top -f -adobe-helvetica-*-*-*-*-16-*-*-*-*-*-*-* -c green -s 7
		fi
fi
   sleep 10
done
