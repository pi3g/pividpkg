#!/bin/bash

set -e

VER="0.10.12"
PKG=nodejs_"$VER"_armhf.deb

cd node
wget http://nodejs.org/dist/v"$VER"/node-v"$VER"-linux-arm-pi.tar.gz
tar xf node-v"$VER"-linux-arm-pi.tar.gz
rm node-v"$VER"-linux-arm-pi.tar.gz
mv node-v"$VER"-linux-arm-pi usr
rm usr/LICENSE usr/README.md usr/ChangeLog 
find usr -type f -printf 'usr/%P ' | xargs md5sum > DEBIAN/md5sums
cd ..
dpkg -b node $PKG

# clean up
rm -r node/usr
rm node/DEBIAN/md5sums
