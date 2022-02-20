#!/bin/sh
# Don't automatically turn off display
enable() {
    sleep 2
 #   xset s on
    xset s blank # Make sure screen doesn't flash white
    xset +dpms dpms 5 5 5 # Set 5s display timeout
    xset dpms force standby
}

enable &
i3lock -n -f -c 000000
xset dpms 0 0 0
xset r rate 250 50
