#!/bin/bash

# Przykładowy czujnik /sys/devices/w1_bus_master1/28-0000078deab8/w1_slave

TEMP=`cat /sys/devices/w1_bus_master1/28-0000078deab8/w1_slave | grep t= | cut -d "=" -f 2`
echo "Odczyt: $TEMP °C"
temp=`echo "scale=2; $TEMP/1000" | bc`
echo "Temperatura w pokoju Wiki: $temp °C"
echo " "

echo "Wysylam dane do Domoticza."
echo " "
#W Domoticzu tworzymy wirtulany czujnik temperatury 
#Odczytujemy jego idx w tym przypadku jest to 56

curl "http://192.168.100.121:80/json.htm?=command&param=udevice&idx=56&nvalue=0&svalue=$temp"

# Jeżeli skrypt działa poprawnie dodajmey do crona wpis aby odczyt był robiony co 5min 
# aby edytować crona wykonujemy polecenie crontab -e i dodajemy wpis
# */5 * * * * /home/pi/ds18b20.sh >/dev/null 2>&1 gdzie */5 * * * * to uruchomienie skrptu co 5 min 
# wychodzimy zapisijąć ctr x.
