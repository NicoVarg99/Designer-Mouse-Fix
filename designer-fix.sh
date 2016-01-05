#!/bin/bash

##################################
#        !!  WARNING !!          #
# ONLY SUITABLE FOR UBUNTU 15.10 #
##################################

# Make sure only root can run this script
if [ $(id -u) -ne 0 ]; then
	echo "This script must be run as root." >&2
	exit 1
fi


#Comment out the only non-commented line in file /lib/udev/rules.d/50-bluetooth-hci-auto-poweron.rules
fl=/lib/udev/rules.d/50-bluetooth-hci-auto-poweron.rules
mv $fl $fl.old
sed 's/^/#/' $fl.old > $fl
rm -f $fl.old


#Uncomment lines [Policy] and AutoEnable=true (originaly there is =false, change it) in /etc/bluetooth/main.conf
fl=/etc/bluetooth/main.conf
mv $fl $fl.old
sed 's/\#\[Policy\]/\[Policy\]/g' $fl.old > $fl
rm -f $fl.old

mv $fl $fl.old
sed 's/AutoEnable=false/AutoEnable=true/g' $fl.old > $fl
rm -f $fl.old

mv $fl $fl.old
sed 's/\#AutoEnable=true/AutoEnable=true/g' $fl.old > $fl
rm -f $fl.old


echo "Now reboot your system."
echo "After the reboot, search and pair your mouse. If the cursor is not moving, try pairing again."
