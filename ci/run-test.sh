#!/bin/bash
echo "Starting the shell script"
# Exit immediately if a command exits with a non-zero status.
set -e
# Enable the globstar shell option
shopt -s globstar


cd ../test

arduino-cli compile -b Moteino:samd:moteino_m0 -e
arduino-cli upload -p /dev/ttyACM0 -b Moteino:samd:moteino_m0

sleep 5
python SerialRead.py

