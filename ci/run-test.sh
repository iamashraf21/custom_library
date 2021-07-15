#!/bin/bash
echo "Starting the shell script"
# Exit immediately if a command exits with a non-zero status.
set -e
# Enable the globstar shell option
shopt -s globstar

echo "compiling examples"

#arduino-cli core search Moteino
whoami
ls -l /dev/ttyACM0
sudo usermod -a -G dialout docker
#sudo chmod a+rw /dev/ttyACM0
ls -l /dev/ttyACM0
#cd ../examples/ecc_test
#arduino-cli compile -b Moteino:samd:moteino_m0 -e
echo "compiling Aunit testcases"
sudo cp -r ../lib/AUnit /root/Arduino/libraries/
cd ../test
arduino-cli lib install micro-ecc
sudo ls -l /root/Arduino/libraries
arduino-cli core install Moteino:samd
arduino-cli compile -b Moteino:samd:moteino_m0 -e

ls -l /dev/ttyACM0
arduino-cli upload -p /dev/ttyACM0 -b Moteino:samd:moteino_m0

sleep 5
python SerialRead.py

