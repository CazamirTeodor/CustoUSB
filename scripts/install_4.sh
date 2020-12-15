#!/bin/bash

#-------------------------
	# aruments = list of packets

	##slim -> interface for ubuntu
	##lxde -> interface for debian

	#network-manager net-tools wireless-tools wpagui curl openssh-server openssh-client blackbox xserver-xorg-core xserver-xorg xinit xterm screenfetch screen lxterminal gedit
#-------------------------


if [ $# -eq 0 ]

	then 

	echo "Nu au fost introduse argumentele necesare "
	exit 1

else

	sudo touch executa.sh
	sudo touch set.txt

	echo "1" >> set.txt

	echo "#!/bin/bash

	apt-get update
	apt-get install --no-install-recommends $* -y < set.txt && apt clean

	" >> executa.sh


	sudo chmod +x executa.sh
	cat executa.sh 
	sudo mv executa.sh set.txt LIVE_BOOT/chroot
	

	sudo chroot LIVE_BOOT/chroot bash -c /executa.sh $1


fi


