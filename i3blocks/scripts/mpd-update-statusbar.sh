#!/bin/bash
SIGNAL=1
while :
do 
    idle=$(mpc idle 2>&1)
    if [[ "$idle" == "MPD error: Connection refused" ]]; then
        break
    fi
    pkill -SIGRTMIN+$SIGNAL i3blocks
done
