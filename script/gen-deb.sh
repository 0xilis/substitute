#!/bin/bash
set -e
debroot=out/debroot
version="$(git describe --always --dirty | sed 's/-/+/g')"
rm -rf $debroot
mkdir -p $debroot
mkdir -p $debroot/var/jb/usr/share/doc/substitute
cp doc/installed-README.txt $debroot/var/jb/usr/share/doc/README.txt
cp substrate/lgpl-3.0.tar.xz $debroot/var/jb/usr/share/doc/
mkdir -p $debroot/var/jb/usr/lib
cp out/libsubstitute.dylib $debroot/var/jb/usr/lib/libsubstitute.0.dylib
ln -s libsubstitute.0.dylib $debroot/var/jb/usr/lib/libsubstitute.dylib
mkdir -p $debroot/var/jb/usr/include/substitute
cp lib/substitute.h $debroot/var/jb/usr/include/substitute/
cp substrate/substrate.h $debroot/var/jb/usr/include/substitute/
mkdir -p $debroot/var/jb/Library/Substitute/DynamicLibraries
cp darwin-bootstrap/safemode-ui-hook.plist out/safemode-ui-hook.dylib $debroot/var/jb/Library/Substitute/DynamicLibraries/
mkdir -p $debroot/var/jb/Library/Substitute/Helpers
cp out/{posixspawn-hook.dylib,bundle-loader.dylib,unrestrict,inject-into-launchd,substituted} $debroot/var/jb/Library/Substitute/Helpers/
mkdir -p $debroot/var/jb/etc/rc.d
ln -s /Library/Substitute/Helpers/inject-into-launchd $debroot/var/jb/etc/rc.d/substitute
mkdir -p $debroot/var/jb/Library/LaunchDaemons
cp darwin-bootstrap/com.ex.substituted.plist $debroot/var/jb/Library/LaunchDaemons/
mkdir -p $debroot/var/jb/Applications/SafetyDance.app
cp -a out/SafetyDance.app/{*.png,Info.plist,SafetyDance} $debroot/var/jb/Applications/SafetyDance.app/
cp -a darwin-bootstrap/DEBIAN $debroot/var/jb/
sed "s#{VERSION}#$version#g" darwin-bootstrap/DEBIAN/control > $debroot/var/jb/DEBIAN/control
#... add bootstrap stuff
# yay, old forks and deprecated compression
rm -f out/*.deb
fakeroot dpkg-deb -Zlzma -b $debroot out/com.ex.substitute-$version.deb
