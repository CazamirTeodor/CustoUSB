#!/bin/bash

#-------------------------
# amd64		focal 	http://ubuntu.osuosl.org/ubuntu/  
# amd64 	buster 	http://debian.osuosl.org/debian/
#-------------------------

if [ $# -ne 3 ]

	then
	 
	echo "Nu au fost introduse argumentele necesare "
	exit 1
fi

	sudo debootstrap --arch=$1 --variant=minbase $2 LIVE_BOOT/chroot $3

