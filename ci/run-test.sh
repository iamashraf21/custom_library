#!/bin/bash
echo "Starting the shell script"
# Exit immediately if a command exits with a non-zero status.
set -e
# Enable the globstar shell option
shopt -s globstar

echo "compiling examples"
cd ../examples/ecc_test
arduino-cli compile -b Seeeduino:samd:zero -e

echo "compiling Aunit testcases"
cd ../../test
arduino-cli compile -b Seeeduino:samd:zero -e
arduino-cli upload -p /dev/ttyACM0 -b Seeeduino:samd:zero

sleep 5
python SerialRead.py

