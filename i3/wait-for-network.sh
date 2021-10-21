#!/bin/bash 
INTERFACE="enp37s0"
IP_RANGE="10.0.0"
while true
    do 
        if [[ $(ip addr | grep "$IP_RANGE" | grep "$INTERFACE") ==  "" ]] 
        then 
            sleep 1
        else 
            eval "$*" 2>&1 # What could go wrong?
            exit 0
        fi
    done
