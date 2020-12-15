#!/bin/bash

#--------------
# 1 argument
# parola
#--------------

if [ $# -eq 0 ]

	then 

	echo "Nu au fost introduse argumentele necesare "
	exit 1

else

	sudo touch executa.sh

	echo "#!/bin/bash
	
	echo \"root:$1\" | chpasswd

	" >> executa.sh

	sudo chmod +x executa.sh
	sudo cat executa.sh
	sudo mv executa.sh LIVE_BOOT/chroot
	
	sudo chroot LIVE_BOOT/chroot bash -c /executa.sh $1
	sudo rm LIVE_BOOT/chroot/executa.sh
	

fi


