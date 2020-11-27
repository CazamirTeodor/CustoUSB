#!/bin/bash

#-------------------------
# i386 stretch / amd64 buster
#-------------------------

if [ $# -ne 2 ]

	then
	 
	echo "Nu au fost introduse argumentele necesare "
	exit 1
fi

	sudo debootstrap --arch=$1 --variant=minbase $2 LIVE_BOOT/chroot http://ftp.us.debian.org/debian/

