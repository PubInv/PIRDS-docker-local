#!/bin/bash

#From here: https://docs.docker.com/config/containers/multi-service_container/
service apache2 start
# We want the pirds_logger to log to /data, which
# is a volume, leaving the files accessible to the outside
cd /data
/var/www/cgi-bin/pirds_logger -D 6111 > debug_log.out 2> debug_log.err
