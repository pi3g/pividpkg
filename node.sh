#!/bin/bash

set -e

cd node
wget http://nodejs.org/dist/v0.10.12/node-v0.10.12-linux-arm-pi.tar.gz
tar xf node-v0.10.12-linux-arm-pi.tar.gz
rm node-v0.10.12-linux-arm-pi.tar.gz
mv node-v0.10.12-linux-arm-pi usr
rm usr/LICENSE usr/README.md usr/ChangeLog 
find usr -type f -printf 'usr/%P ' | xargs md5sum > DEBIAN/md5sums
cd ..
dpkg -b node nodejs_0.10.12_armhf.deb
rm -r node/usr
rm node/DEBIAN/md5sums
