#!/bin/bash

# Get value from Domoticz device JSON data and parse value from JSON.
# required instalation tools: curl, jq

# device idx
IDX=5

# get local IP (rpi IP)
LOCALIP=$(hostname -I | cut -d' ' -f1)

# get JSON from device and parse data key (| jq -r ...)
data=$(curl -k -s "http://$LOCALIP/json.htm?type=devices&rid=$IDX" | jq -r '.result[] | .Data')

# print value "data"
echo $data