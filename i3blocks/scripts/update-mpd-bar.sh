#!/bin/bash
mpc idleloop | while read idle
do
    pkill -RTMIN+1 i3blocks
done

