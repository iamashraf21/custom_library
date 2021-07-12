FROM ubuntu:latest

FROM python:3

RUN apt-get update 

RUN apt-get install curl

ADD myscript.py /

RUN python -m pip install pyserial

CMD [ "python", "./myscript.py" ]

RUN curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh

CMD ["arduino-cli", "core", "update-index"]

