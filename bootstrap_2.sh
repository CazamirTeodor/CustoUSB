#!/bin/bash



if [ $# -ne 2 ]

	then
	 
	echo "Nu au fost introduse argumentele necesare "
	exit 1
fi

 	# i386 stretch / amd64 buster
	sudo debootstrap --arch=$1 --variant=minbase $2 LIVE_BOOT/chroot http://ftp.us.debian.org/debian/

