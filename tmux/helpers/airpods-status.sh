#!/bin/bash

AIRPODS=$(blueutil --paired | grep AirPods)

if [ -z "$AIRPODS" ]; then
	echo "Airpods Not-Paired"
else
	NOT=$(echo $AIRPODS | grep "not connected")

	if [ -z "$NOT" ]; then
		echo "Airpods Connected"
	else
		echo "Airpods Disconnected"
	fi
fi
