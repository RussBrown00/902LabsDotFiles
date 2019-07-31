#!/bin/bash

PCT=$(pmset -g batt | grep [0-9]* | awk 'match($0, /[0-9]*\%/) {
    print substr($0, RSTART, RLENGTH)
}')

LEFT=$(pmset -g batt | grep [0-9]* | awk 'match($0, /[0-9]*\:[0-9]*/) {
    print substr($0, RSTART, RLENGTH)
}')

POWER=$(pmset -g batt | grep [0-9]* | awk 'match($0, /true$/) {
    print substr($0, RSTART, RLENGTH)
}')

if [ -z "$POWER" ]; then
	echo "♥ $PCT, $LEFT remaining "
else
	echo "♥ $PCT "
fi
