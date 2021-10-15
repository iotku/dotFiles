#!/bin/sh
# Don't automatically turn off display
revert() {
    xset s off
    xset -dpms
    xset s noblank
}

# Set 5s display timeout
enable() {
    xset +dpms dpms 5 5 5
    xset s blank # Make sure screen doesn't flash white
}

enable
trap revert HUP INT TERM EXIT
i3lock -n -f -c 000000
revert
