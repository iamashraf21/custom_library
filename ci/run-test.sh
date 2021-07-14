#!/bin/bash
echo "Starting the shell script"
# Exit immediately if a command exits with a non-zero status.
set -e
# Enable the globstar shell option
shopt -s globstar

echo "compiling examples"

arduino-cli core search Moteino

arduino-cli core install Moteino:samd

arduino-cli lib install micro-ecc
arduino-cli lib install AUnit

ls -l /dev/ttyACM0
usermod -a -G dialout $USER
chmod a+rw /dev/ttyACM0
#cd ../examples/ecc_test
#arduino-cli compile -b Moteino:samd:moteino_m0 -e
echo "compiling Aunit testcases"
cd ../test
arduino-cli compile -b Moteino:samd:moteino_m0 -e
arduino-cli upload -p /dev/ttyACM0 -b Moteino:samd:moteino_m0

sleep 5
python SerialRead.py

