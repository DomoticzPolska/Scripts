#!/bin/bash

# Sprawdzanie czy Domoticz działa poprawnie (odpowiada po http jsonem) i jak nie, to restart usługi.
# Uwzględniony jest brak internetu aby nie restartować niepotrzebnie usługi z tego powodu.
# Należy ten skrypt uruchamiać cyklicznie (CRON) na urządzeniu, na którym działa Domoticz (RPI).

# pobieramy lokalne IP aby go użyć w CURL
LOCALIP=$(hostname -I | cut -d' ' -f1)

# sprawdzamy status domoticza - czy odpowiada JSONem
status=$(curl -k -s "https://$LOCALIP/json.htm?type=command&param=getconfig" | jq -r '.status')

# sprawdzamy czy RPI ma internet
check_internet=$(ping -q -w1 -c1 google.com &>/dev/null && echo online || echo offline)

# sprawdzamy warunki i jeśli są spełnione to restartujemy usługę.
if [ "OK" != $status ] && [ "offline" != $check_internet ] ; then
    /etc/init.d/domoticz.sh restart
fi
