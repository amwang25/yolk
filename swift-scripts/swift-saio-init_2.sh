#!/bin/bash

# loopback device for storage

rm -fr /srv

mkdir /srv
dd if=/dev/zero of=/srv/swift-disk bs=1024 count=0 seek=100000
mkfs.xfs -f -i size=1024 /srv/swift-disk
echo "/srv/swift-disk /mnt/sdb1 xfs loop,noatime,nodiratime,nobarrier,logbufs=8 0 0" >>/etc/fstab
mkdir -p /mnt/sdb1
mount /mnt/sdb1
chown -R ywang:ywang /mnt/sdb1/

for x in {1..5}; do
	mkdir -p /mnt/sdb1/$x
	ln -f -s /mnt/sdb1/$x /srv/$x
	mkdir -p /srv/$x/node/sdb$x
	chown -R ywang:ywang /srv/$x/
done

mkdir -p /etc/swift/object-server /etc/swift/container-server /etc/swift/account-server 

mkdir -p /var/run/swift
chown -R ywang:ywang /var/run/swift /etc/swift

echo "mkdir /var/run/swift" >>/etc/rc.local
echo "chown ywang:ywang /var/run/swift" >>/etc/rc.local


