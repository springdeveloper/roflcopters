#!/bin/sh

repo=~/roflcopters/branches/ubersearch
webapp=/var/lib/tomcat5.5/webapps
context=/etc/tomcat5.5/Catalina/localhost/GatorMail.xml

sudo /etc/init.d/tomcat5.5 stop && \
rm -r ${repo}/build/ && \
sudo rm -f $context && \
ant clean && \
ant && \
sudo cp ${repo}/build/war/GatorMail.war ${webapp}/ && \
sudo rm -r ${webapp}/GatorMail/ && \
sudo /etc/init.d/tomcat5.5 start 
