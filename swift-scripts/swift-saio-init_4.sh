#!/bin/bash

echo "setting up syslog ..."


cp 10-swift.conf /etc/rsyslog.d/

# FIXME 
# Edit /etc/rsyslog.conf, change "$PrivDropToGroup syslog" to "$PrivDropToGroup adm"
#

mkdir -p /var/log/swift/hourly
chown -R syslog.adm /var/log/swift
service rsyslog restart

