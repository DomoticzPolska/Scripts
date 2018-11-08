#!/bin/bash

# Skrypt pobiera dane JSON z urządzenia Domoticz (przycisku, temperatury itp.) 
# a następnie pobiera daną "Data", przypisuje ją do zmiennej "data" a następnie 
# wyświetla na ekran poleceniem "echo".
# 
# Do poprawnego działania skryptu należy zainstalować narzędzia: curl oraz jq.

# id urządzenia w Domoticz
IDX=5

# pobranie IP naszego Raspberry lub inego komputera, na którym uruchamiamy skrypt
# można pominąć ten krok i zapisać na sztywno IP w poleceniu następnym zamiast $LOCALIP
LOCALIP=$(hostname -I | cut -d' ' -f1)

# Pobranie JSONa za pomocą curla i przekazanie go do narzędzie jq w celu pobrania 
# konkrentej wartości z JSONa.
data=$(curl -k -s "https://$LOCALIP/json.htm?type=devices&rid=$IDX" | jq -r '.result[] | .Data')

# Wyświetlenie zmiennej "data" na ekran.
echo $data
