#!/bin/bash
docker stop logger
docker build --tag pirds-logger .
docker run -d --rm --name logger -p 8081:80 -p 6111:6111/udp -v `pwd`/logger_src/data:/data pirds-logger
node serialserver.js --uaddress=127.0.0.1 --sport=/dev/ttyACM0 --uport=6111
