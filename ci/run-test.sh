#!/bin/bash
echo "Starting the shell script"
# Exit immediately if a command exits with a non-zero status.
set -e
# Enable the globstar shell option
shopt -s globstar

echo "compiling examples"
whoami

pwd

cd ../examples/ecc_test
arduino-cli compile -b Moteino:samd:moteino_m0 -e 
#sudo cp -r /__w/15/s/AUnit ~/Arduino/libraries/
ls -l ~/Arduino/libraries

cd ../../test

arduino-cli compile -b Moteino:samd:moteino_m0 -e
arduino-cli upload -p /dev/ttyACM0 -b Moteino:samd:moteino_m0

sleep 5
python SerialRead.py

