#!/bin/bash

set -e

git clone https://github.com/pi3g/pivid pividgit
mkdir -p pivid/usr/share/pivid
cp pividgit/node/* pivid/usr/share/pivid
cd pivid/usr/share/pivid
npm install express
npm install jquery
cd ../../..
find usr -type f -printf 'usr/%P ' | xargs md5sum > DEBIAN/md5sums
cd ..
dpkg -b pivid pivid_0.0.1.deb
rm -rf pividgit
rm pivid/DEBIAN/md5sums
rm -r pivid/usr/share
