#!/bin/bash

mkdir -p ~/bin
git clone https://github.com/openstack/swift.git

cd ~/swift; sudo python setup.py develop

echo "SWIFT_TEST_CONFIG_FILE=/etc/swift/func_test.conf" >>~/.bashrc
echo "PATH=${PATH}:~/bin" >>~/.bashrc

. ~/.bashrc


