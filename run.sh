#!/bin/bash

echo "Checking basic files ..."
if [ ! -e /usr/share/bochs/keymaps/x11-pc-us.map ]; then
	echo "/usr/share/bochs/keymaps/x11-pc-us.map does not exist."
	exit 1
else
	file /usr/share/bochs/keymaps/x11-pc-us.map
fi

if [ ! -e /usr/share/bochs/BIOS-bochs-latest ]; then
	echo " /usr/share/bochs/BIOS-bochs-latest does not exist."
	exit 1
else
	file /usr/share/bochs/BIOS-bochs-latest
fi

if [ ! -e /usr/share/bochs/VGABIOS-lgpl-latest ]; then
	echo "/usr/share/bochs/VGABIOS-lgpl-latest does not exist."
	exit 1
else
	file /usr/share/bochs/VGABIOS-lgpl-latest
fi
echo "Check Completed."
sleep 2

echo "Starting ..."
bochs -f .bochsrc
