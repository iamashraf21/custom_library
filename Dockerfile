FROM ubuntu:latest

FROM python:3

RUN apt-get update 

RUN apt-get install curl

ADD myscript.py /

RUN python -m pip install pyserial

RUN curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh

RUN echo "# arduino-cli.yaml \n\
board_manager: \n\
  additional_urls: \n\
    - https://files.seeedstudio.com/arduino/package_seeeduino_boards_index.json" > arduino-cli.yaml

RUN cat arduino-cli.yaml

RUN arduino-cli core update-index

RUN arduino-cli core search samd
