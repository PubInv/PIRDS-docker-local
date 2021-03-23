# Introduction

This is a first attempt at making a Docker file which does the
same thing that the VentMon public data lake does, but
keeping everything local and allowing a PIRDS log file to
be retained after the docker image is closed.

>  docker build --tag pirds-logger .
>  docker run -d --name logger -p 8081:80 -p 6111:6111/udp  -v \`pwd\`/logger_src/data:/data   pirds-logger
