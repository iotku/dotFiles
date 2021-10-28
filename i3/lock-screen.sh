#!/bin/sh
# Don't automatically turn off display
revert() {
    xset s off -dpms
}

enable() {
    xset s on
    xset s blank # Make sure screen doesn't flash white
    xset dpms force standby
    xset +dpms dpms 5 5 5 # Set 5s display timeout
}

trap revert HUP INT TERM 
enable &
i3lock -n -f -c 000000
revert
