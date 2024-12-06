#!/bin/bash

set -e

# Set the battery threshold percentage
THRESHOLD=50

# Get the current battery percentage
BATTERY_LEVEL=$(upower -i $(upower -e | grep battery) | grep percentage | awk '{print $2}' | sed 's/%//')

# Check if the battery level is below the threshold
if [ "$BATTERY_LEVEL" -le "$THRESHOLD" ]; then
	systemctl poweroff
fi
