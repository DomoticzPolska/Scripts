#!/bin/bash

# Sprawdzanie czy Domoticz działa porprawnie i jak nie to restart usługi
# autor: Gabriel Zima
# requirement tools install: sudo apt install curl jq

LOCALIP=$(hostname -I | cut -d' ' -f1)
echo -e "1. Check Domoticz status...... \c"
status=$(curl -k -s --max-time 5 "https://$LOCALIP/json.htm?type=command&param=getconfig" | jq -r '.status')
echo $status
echo -e "2. Check internet available... \c"
check_internet=$(ping -q -w1 -c1 google.com &>/dev/null && echo online || echo offline)
echo $check_internet
if [ "status OK" != "status $status" ] && [ "offline" != $check_internet ] ; then
	/etc/init.d/domoticz.sh restart
fi
