FROM ubuntu
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install apache2 -y
RUN apt-get install apache2-utils -y
RUN apt-get install -y coreutils
RUN apt-get install -y emacs
RUN apt-get install -y less
RUN apt-get install -y build-essential
RUN apt-get install -y net-tools
RUN apt-get install -y iputils-ping
RUN a2dissite 000-default.conf
RUN mkdir /var/www/cgi-bin
RUN rm /var/www/html/index.html
COPY httpd.conf /etc/apache2/sites-available/pirdslogger.org.conf
RUN mkdir /pirds_build
WORKDIR /pirds_build
RUN mkdir pirds_library
COPY pirds_library/* pirds_library/
WORKDIR /pirds_build/pirds_library
# RUN rm PIRDS.o
RUN touch PIRDS.cpp
RUN make
RUN cp PIRDS.o /pirds_build/PIRDS.o
COPY logger_src/*.h /pirds_build/
COPY logger_src/*.c /pirds_build/
COPY logger_src/0Logfile.192.168.1.169.test_file_name.20200627181744 /pirds_build/pirds_library/
COPY logger_src/Makefile /pirds_build
WORKDIR /pirds_build
RUN make
RUN a2ensite pirdslogger.org.conf
RUN a2enmod cgi
RUN cp pirds_logger /var/www/cgi-bin
RUN cp pirds_webcgi /var/www/cgi-bin
COPY logger_src/0Logfile.* /data
COPY logger_src/favicon.ico /var/www/html
RUN cp /var/www/cgi-bin/pirds_webcgi /var/www/cgi-bin/index.cgi
COPY breath_plot.html /var/www/html
COPY my_wrapper_script.sh /var/www/cgi-bin/my_wrapper_script.sh

WORKDIR /var/www
RUN chown -R www-data:www-data *

# Here we run the logger itself...
WORKDIR /var/www/cgi-bin
# CMD ["apache2ctl","-D","FOREGROUND"]
# NOTE: This does not seem to work!
# You have to use:
# docker run -d --name logger -p 8081:80 -p 6111:6111/udp pirds-logger
# (That is: -p 8081:80 -p 6111:6111/udp)
# to expose these ports

EXPOSE 80
EXPOSE 6111/udp

# Finally, we set an environment variable to say where
# the data files will be for pirds_webcgi

CMD ./my_wrapper_script.sh
