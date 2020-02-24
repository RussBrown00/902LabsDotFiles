#!/bin/bash

BLUEUTILPATH=$(echo $(which blueutil) | grep "not found")
AIRPODS=$(blueutil --paired | grep AirPods)

if [ -z "$AIRPODS" ]; then
	if [ ! -z BLUEUTILPATH ]; then
		echo "blueutil not installed."
	else
		echo "Airpods Not-Paired"
	fi
else
	NOT=$(echo $AIRPODS | grep "not connected")

	if [ -z "$NOT" ]; then
		echo "Airpods Connected"
	else
		echo "Airpods Disconnected"
	fi
fi
