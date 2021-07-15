#!/bin/bash
echo "Starting the shell script"
# Exit immediately if a command exits with a non-zero status.
set -e
# Enable the globstar shell option
shopt -s globstar

echo "compiling examples"

#arduino-cli core search Moteino
whoami
sudo usermod -a -G dialout docker
#cd ../examples/ecc_test
#arduino-cli compile -b Moteino:samd:moteino_m0 -e
echo "compiling Aunit testcases"

mkdir ~/Arduino
mkdir ~/Arduino/libraries

sudo cp -r ../lib/AUnit ~/Arduino/libraries/
cd ../test

sudo ls -l ~/Arduino/libraries/AUnit/

#arduino-cli core install Moteino:samd
arduino-cli compile -b Moteino:samd:moteino_m0 -e
arduino-cli upload -p /dev/ttyACM0 -b Moteino:samd:moteino_m0

sleep 5
python SerialRead.py

