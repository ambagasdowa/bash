#!/bin/bash
# install xosd-bin on debian
#echo 'Initializing battery-monitor ...' | aosd_cat -p 6 -R green
echo 'Initializing battery-monitor ...' | osd_cat -A center -p bottom -f -*-*-bold-*-*-*-36-120-*-*-*-*-*-* -cgreen -s 5

while true
do
 #   battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
   # battery_level=`acpitool --battery | grep 'All batteries' | cut -d':' -f 2 | cut -f 1 -d '.'`
    battery_level=`acpitool --battery | grep 'Remaining capacity' | cut -d':' -f 2 | cut -f 2 -d ',' | cut -f 1 -d '.'`
    #remain=`acpitool --battery | grep 'All batteries' | cut -d',' -f 2`
    remain=`acpitool --battery | grep 'Remaining capacity' | cut -d',' -f 3`
    chck=$(expr length "$battery_level") # when acpi -b is null is because no battery detect or installed 

#    echo $battery_level;
#    echo $remain;
#    echo $chck;


if [ $chck != 0 ]; then
  if [ $battery_level -eq 100 ]; then
  	if [ `acpi -a | awk '{print $3}'` = "on-line" ];then
  		# notify-send "Battery charging above 99%. Please unplug your AC adapter!" "Charging: ${battery_level}%"
          echo "Battery charging above 100%. Please unplug your AC adapter!" "Charging: ${battery_level}%" | aosd_cat -p 6 -R green
  	fi
  elif [ $battery_level -le 10 ];then
  	if [ `acpi -a | awk '{print $3}'` = "off-line" ];then
        if [ $battery_level -le 10 -a  $battery_level -ge 6 ] ; then
          # notify-send "Battery is lower 15%. Need to charging! Please plug your AC adapter." "Uncharging: ${battery_level}%"
          echo "Battery is lower 10%. Need to charging! Please plug your AC adapter." "Uncharging: ${battery_level}% Time: ${remain}" | aosd_cat -p 6 -R orange
        elif [ $battery_level -le 5  -a  $battery_level -ge 3  ]; then
          #statements
          echo "Battery is lower than 5%. Need to charging! Please plug your AC adapter." "Uncharging: ${battery_level}% Time: ${remain}" | aosd_cat  -p 6 -R yellow
        elif [ $battery_level -lt 2 ]; then
          #statements
          echo "Battery is lower than 2%. Need to charging! Please plug your AC adapter." "Uncharging: ${battery_level}% Time: ${remain}" | aosd_cat -p 6 -R red
        fi
  	fi
  fi
fi
   sleep 10
done
