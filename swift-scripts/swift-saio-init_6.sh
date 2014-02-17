#!/bin/bash

# create /etc/swift/proxy-server.conf

cat <<EOF >/etc/swift/proxy-server.conf
[DEFAULT]
bind_port = 8080
user = ywang
log_facility = LOG_LOCAL1

[pipeline:main]
pipeline = healthcheck cache tempauth proxy-server

[app:proxy-server]
use = egg:swift#proxy
allow_account_management = true
account_autocreate = true

[filter:tempauth]
use = egg:swift#tempauth
user_admin_admin = admin .admin .reseller_admin
user_test_tester = testing .admin
user_test2_tester2 = testing2 .admin
user_test_tester3 = testing3

[filter:healthcheck]
use = egg:swift#healthcheck

[filter:cache]
use = egg:swift#memcache

EOF

cat <<EOF >/etc/swift/swift.conf
[swift-hash]
swift_hash_path_suffix = openstack

EOF

for x in {1..5}; do
cat <<EOF >/etc/swift/account-server/${x}.conf
[DEFAULT]
devices = /srv/${x}/node
mount_check = false
bind_port = 60${x}2
user = ywang
log_facility = LOG_LOCAL$((x+1))
	
[pipeline:main]
pipeline = account-server

[app:account-server]
use = egg:swift#account

[account-replicator]
vm_test_mode = yes

[account_auditor]

[account_reaper]

EOF
done

for x in {1..5}; do
cat <<EOF >/etc/swift/container-server/${x}.conf
[DEFAULT]
devices = /srv/${x}/node
mount_check = false
bind_port = 60${x}1
user = ywang
log_facility = LOG_LOCAL$((x+1))

[pipeline:main]
pipeline = container-server

[app:container-server]
use = egg:swift#container

[container-replicator]
vm_test_mode = yes

[container-updater]

[container-auditor]

[container-sync]

EOF

done

for x in {1..5}; do
cat <<EOF >/etc/swift/object-server/${x}.conf
[DEFAULT]
devices = /srv/${x}/node
mount_check = false
bind_port = 60${x}0
user = ywang
log_facility = LOG_LOCAL$((x+1))

[pipeline:main]
pipeline = object-server

[app:object-server]
use = egg:swift#object

[object-replicator]
vm_test_mode = yes

[object-updater]

[object-auditor]

EOF

done

