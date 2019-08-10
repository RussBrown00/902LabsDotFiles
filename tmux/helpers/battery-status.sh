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

if [ "$LEFT" == "0:00" ]; then
	echo "♥ $PCT "
else
	echo "♥ $PCT, $LEFT Remaining "
fi
