#!/bin/bash
mpc -h ~/.config/mpd/socket idleloop | while read idle
do
    pkill -RTMIN+1 i3blocks
done

