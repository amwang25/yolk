#!/bin/bash


echo "uid = ywang" >/etc/rsyncd.conf
echo "gid = ywang" >>/etc/rsyncd.conf
echo "log file = /var/log/rsyncd.log" >>/etc/rsyncd.conf
echo "pid file = /var/run/rsyncd.pid" >>/etc/rsyncd.conf
echo "address = 127.0.0.1" >>/etc/rsyncd.conf
echo >>/etc/rsyncd.conf
 
for x in {1..5}; do
	key="[account60${x}2]"
	echo >>/etc/rsyncd.conf
	echo "$key" >>/etc/rsyncd.conf
	echo "max connections = 25" >>/etc/rsyncd.conf
	echo "path = /srv/${x}/node/" >>/etc/rsyncd.conf
	echo "read only = false" >>/etc/rsyncd.conf
	echo "lock file = /var/lock/${key}.lock" >>/etc/rsyncd.conf
done

 
for x in {1..5}; do
	key="[container60${x}1]"
	echo >>/etc/rsyncd.conf
	echo "$key" >>/etc/rsyncd.conf
	echo "max connections = 25" >>/etc/rsyncd.conf
	echo "path = /srv/${x}/node/" >>/etc/rsyncd.conf
	echo "read only = false" >>/etc/rsyncd.conf
	echo "lock file = /var/lock/${key}.lock" >>/etc/rsyncd.conf
done

 
for x in {1..5}; do
	key="[object60${x}0]"
	echo >>/etc/rsyncd.conf
	echo "$key" >>/etc/rsyncd.conf
	echo "max connections = 25" >>/etc/rsyncd.conf
	echo "path = /srv/${x}/node/" >>/etc/rsyncd.conf
	echo "read only = false" >>/etc/rsyncd.conf
	echo "lock file = /var/lock/${key}.lock" >>/etc/rsyncd.conf
done

# FIXME 
# edit /etc/default/rsync, and change "RSYNC_ENABLE=true"
#
# service rsync restart
