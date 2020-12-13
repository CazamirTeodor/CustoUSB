#!/bin/bash


#df 
#sudo umount /dev/sdb1
#sudo mkfs.vfat -F 32 /dev/sdb1
#sudo fdisk -l
#sudo mkdir /media/LIVE_USB
#sudo mount -t vfat /dev/sdb1 /media/LIVE_USB -o uid=1000
sudo dd bs=4M if=LIVE_BOOT/debian-custom.iso of=/dev/sdb status=progress && sync
