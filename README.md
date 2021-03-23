# Introduction

This repo allows you to build a docker image file which, when running, supports both interactice and long-term logging of Public Invention Respiration Data Standard (PIRDS) data.

This is part of a Public Invention Respiration ecosystem, and requires some understanding of that system, though it is desigend to be usable as a completely
independent component. 

However, the most obvious use of this repo is to make a local, possibly long-term, data log of respiraiton data produced by the [VentMon](https://github.com/PubInv/ventmon-ventilator-inline-test-monitor) Inline Tester-Monitor, possibly because you are evaluating a mechanical ventilation device.
The easiest way to use that device is to use the Public Invention public data lake at [ventmon.coslabs.com](http://ventmon.coslabs.com/), where data is 
logged if you enable the Ethernet or WiFi features of the VentMon T0.4.  Although you can figure all the components in this docker image separately, our
hope is that this makes configuration simpler for those who main want data log files.

# The System

The image below roughly depicts how a running system works.

![VentMon Docker Ecosystem](https://user-images.githubusercontent.com/5296671/111052632-25087d80-8422-11eb-8d85-7e72af57ff4f.png)

# Usage

This repo creates a Docker image file. You will want to install Docker. In theory, this will allow you to run the result image on a Windows machine,
as well as a GNU/Linux or a Mac.

You probably don't want to use this unless use are runninig serialserver.js for the purpose of transmitting PIRDS data on a serial port to a PIRDS logger listening 
to UDP. (In this case, the PIRDS logger will be running *inside* your Docker image.)

[serialerver.js](https://github.com/PubInv/vent-display/blob/master/serialserver.js) 
can be found in the [VentDisplay](https://github.com/PubInv/vent-display) repo.


>  docker build --tag pirds-logger .
>
>  docker run -d --name logger -p 8081:80 -p 6111:6111/udp  -v \`pwd\`/logger_src/data:/data   pirds-logger
>  


# A Note on Freshness

In order to make docker images, all of the sources files form three repos [PIRDS library](https://github.com/PubInv/PIRDS-respiration-data-standard),
[PIRDS logger](https://github.com/PubInv/PIRDS-logger), and [VentDisplay](https://github.com/PubInv/vent-display) are copied here. This means that
this image is likely to be stable and usable. However, those repos are all under active devleopement; there may be features there which are not 
necessarily reflected in this repo.


