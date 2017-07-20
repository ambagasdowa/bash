#!/bin/bash

while true
do
    battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
    chck=$(expr length "$battery_level") # when acpi -b is null is because no battery detect or installed 
if [ $chck != 0 ]; then
  if [ $battery_level -eq 100 ]; then
  	if [ `acpi -a | awk '{print $3}'` = "on-line" ];then
  		# notify-send "Battery charging above 99%. Please unplug your AC adapter!" "Charging: ${battery_level}%"
      echo "Battery charging above 100%. Please unplug your AC adapter!" "Charging: ${battery_level}%" | osd_cat -A right -p top -f -adobe-helvetica-*-*-*-*-16-*-*-*-*-*-*-* -c green -s 5
  	fi
  elif [ $battery_level -le 15 ];then
  	if [ `acpi -a | awk '{print $3}'` = "off-line" ];then
        if [ $battery_level -le 15 -a  $battery_level -ge 10 ] ; then
          # notify-send "Battery is lower 15%. Need to charging! Please plug your AC adapter." "Uncharging: ${battery_level}%"
          echo "Battery is lower 15%. Need to charging! Please plug your AC adapter." "Uncharging: ${battery_level}%" | osd_cat -A right -p top -f -adobe-helvetica-*-*-*-*-16-*-*-*-*-*-*-* -c orange -s 7
        elif [ $battery_level -le 9  -a  $battery_level -ge 6  ]; then
          #statements
          echo "Battery is lower than 10%. Need to charging! Please plug your AC adapter." "Uncharging: ${battery_level}%" | osd_cat -A right -p top -f -adobe-helvetica-*-*-*-*-16-*-*-*-*-*-*-* -c yellow -s 7
        elif [ $battery_level -lt 5 ]; then
          #statements
          echo "Battery is lower than 5%. Need to charging! Please plug your AC adapter." "Uncharging: ${battery_level}%" | osd_cat -A right -p top -f -adobe-helvetica-*-*-*-*-16-*-*-*-*-*-*-* -c red -s 7
        fi
  	fi
  fi
fi
   sleep 10
done
