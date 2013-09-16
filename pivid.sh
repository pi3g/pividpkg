#!/bin/bash

set -e

git clone https://github.com/pi3g/pivid pividgit
VER="$(node pividgit/node/server.js -v)"
echo "Version: $VER"
sed -i "/^Version/s/ .*$/ $VER/" pivid/DEBIAN/control
mkdir -p pivid/usr/share/pivid
cp -r pividgit/node/* pividgit/replace.user.js pivid/usr/share/pivid
mkdir -p pivid/etc/init.d/
cp pividgit/init.sh pivid/etc/init.d/pivid
cd pivid/usr/share/pivid
npm install express
npm install jquery
cd ../../..
find usr -type f -printf 'usr/%P ' | xargs md5sum > DEBIAN/md5sums
cd ..
dpkg -b pivid "pivid_${VER}_armhf.deb"

# clean up
rm -rf pividgit
sed -i "/^Version/s/ .*$/ 0.0.0/" pivid/DEBIAN/control
rm pivid/DEBIAN/md5sums
rm -r pivid/usr/share
rm -r pivid/etc/
