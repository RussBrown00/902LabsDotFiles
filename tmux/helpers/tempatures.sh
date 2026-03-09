#!/bin/bash

echo "CPU: $(echo "scale=1;((9/5) * $(smctemp -c)) + 32" | bc)°F | GPU: $(echo "scale=1;((9/5) * $(smctemp -g)) + 32" | bc)°F"
