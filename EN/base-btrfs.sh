#!/bin/bash
echo " Congratulations, you have chosen the btrfs file system.
I strongly recommend studying ArchWiki before start: https://wiki.archlinux.org/index.php/Btrfs
Ready to start? "
while 
    read -n1 -p  "
    1 - yes
    
    0 - no: " hello # sends right after the keypress
    echo ''
    [[ "$hello" =~ [^10] ]]
do
    :
done
 if [[ $hello == 1 ]]; then
  clear
  echo "Welcome to ArchLinux"
  elif [[ $hello == 0 ]]; then
   exit   
fi
###
echo ""
echo "
This step will help you avoid problems with keys of

Pacman, if you are using a non-recent ArchLinux image to install! "

echo ""
echo " Update the keys?  "
while 
    read -n1 -p  "
    1 - yes
    
    0 - no: " x_key 
    echo ''
    [[ "$x_key" =~ [^10] ]]
do
    :
done
if [[ $x_key == 1 ]]; then
  clear
  pacman-key --init 
  pacman-key --populate
  pacman-key --refresh-keys --keyserver keys.gnupg.net 
  pacman -Syy
  elif [[ $x_key == 0 ]]; then
   echo " Updating skipped "   
fi
##
clear
echo " Here you can choose which mode the ArchLinux installation image is running in"
echo " If you booted to Uefi then 1 if legacy then 2 "
echo " legacy Mode only for mbr partition table, Uefi for Gpt partition table"
echo   ""
echo "#################################################"
echo "#########  Output example of efibootmbr    ######"
echo "####                                        #####"
echo "####            this means                  #####"
echo "####                                        #####"
echo "####             !!UEFI!!                   #####"     	
echo "####                                        #####"
echo "####  BootOrder: 0003,0001,2001,2002,2003   #####"
echo "####  Boot0000* USB HDD: Generic Flash Disk #####"
echo "####  Boot0001* Windows Boot Manager	  #####"
echo "#################################################"
echo ""
echo "#################################################"
echo "########  Output example of efibootmbr     ######"
echo "####                                         ####"
echo "####           this means                    ####"       
echo "####                                         ####" 
echo "####            !!LEGACY!!                   ####" 
echo "####                                         ####" 
echo "####       EFI variables are not             ####"	
echo "####     supported on this system.           ####"
echo "#################################################"
echo ""
efibootmgr
echo ""
echo " UEFI( no grub ) or Grub-legacy? "
while 
    read -n1 -p  "
    1 - UEFI
    
    2 - GRUB-legacy
    
    0 - exit " menu # sends right after the keypress
#    echo ''
[[ "$menu" =~ [^120] ]]
do
    : 
done
if [[ $menu == 1 ]]; then
clear
###################################################
################часть первая#######################
pacman -Sy --noconfirm
echo ""
lsblk -f
echo " Here you can remove boot from the old system, the Windows boot loader files are not affected."
echo " if you need to completely clear the boot partition, skip this step, then the installation will suggest formatting the boot partition "
echo " when installing dual boot, the partition does not need to be formatted! "
echo ""
echo 'delete the old linux loader?'
while 
    read -n1 -p  "
    1 - delete old loader
    
    0 -(skip) - this stage can be skipped if the installation is performed for the first time or you have several OSes  " boots 
    echo ''
    [[ "$boots" =~ [^10] ]]
do
    :
done
if [[ $boots == 1 ]]; then
  clear
 lsblk -f
  echo ""
read -p "Point BOOT part ( ex. sda2, nvme0n1p3 ):" bootd
mount /dev/$bootd /mnt
cd /mnt
ls | grep -v EFI | xargs rm -rfv
cd /mnt/EFI
ls | grep -v Boot | grep -v Microsoft | xargs rm -rfv
cd /root
umount /mnt
  elif [[ $boots == 0 ]]; then
   echo " clearing the boot partition is skipped, later you can format it! "   
fi
#
pacman -Sy --noconfirm
##############################
clear
echo ""
echo " Choose 1 , if you haven't partitioned the disk before and you don't have partitions for ArchLinux "
echo ""
echo 'Need partition?'
while 
    read -n1 -p  "
    1 - yes
    
    0 - no: " cfdis # sends right after the keypress
    echo ''
    [[ "$cfdis" =~ [^10] ]]
do
    :
done
 if [[ $cfdis == 1 ]]; then
   clear
 lsblk -f
  echo "The disk will now be marked up."
  echo " Create 3 sections: sda1 , type EFI system"
  echo "                    sda2 , type linux 82 solaris"
  echo "                    sda3 , type linux 83"
  echo "       be accurate, on sda3 there will be"
  echo "       2 parts, united by LVM"
  read -p "POINT YOUR DISK (ex. sda , nvme0n1) : " cfd
cfdisk /dev/$cfd
echo ""
clear
elif [[ $cfdis == 0 ]]; then
   echo ""
   clear
   echo 'partition skipped.'   
fi
#
  clear
  lsblk -f
  echo ""
 
############ swap   ####################################################
 clear
 lsblk -f
 
  read -p "Point SWAP part(ex. sda2, nvme0n1p2):" swaps
  mkswap /dev/$swaps -L swap
  swapon /dev/$swaps
  
################  home     ############################################################ 
clear
echo ""
echo " Starting to create a logical volume."
echo ""
lsblk -f
read -p "Point LVM part(ex. sda3, nvme0n1p3):" home
 
pvcreate /dev/$home
vgcreate vg_arch /dev/$home
read -p "How many GB giving to root?:
 ! Write a number and letter G, example: 15G !" nor
lvcreate -L $nor -n root vg_arch
lvcreate -l 100%FREE -n home vg_arch
clear
echo "output of PVDISPLAY:"
pvdisplay
read -n 1 -s -r -p "Press any key to continue"
clear
echo "output of VGDISPLAY:"
vgdisplay
read -n 1 -s -r -p "Press any key to continue"
clear
echo "output of LVDISPLAY:"
lvdisplay
read -n 1 -s -r -p "Press any key to continue"

############ mount ################
# mkfs.ext2 /dev/sda1 #did above
 mkfs.btrfs /dev/vg_arch/root
 mkfs.btrfs /dev/vg_arch/home

  mount /dev/vg_arch/root /mnt/
  mkdir /mnt/home
  mount /dev/vg_arch/home /mnt/home/
########## boot  ########
 clear
 lsblk -f
  echo ""
echo 'format BOOT?'
while 
    read -n1 -p  "
    1 - yes
    
    0 - no: " boots # sends right after the keypress
    echo ''
    [[ "$boots" =~ [^10] ]]
do
    :
done
 if [[ $boots == 1 ]]; then
  read -p "Point BOOT part(ex. sda1, nvme0n1p1):" bootdd
  mkfs.fat -F32 /dev/$bootdd
  mkdir /mnt/boot
  mount /dev/$bootdd /mnt/boot
  elif [[ $boots == 0 ]]; then
  read -p "Point BOOT part(ex. sda1, nvme0n1p1):" bootdd
 mkdir /mnt/boot
mount /dev/$bootdd /mnt/boot
fi


 ###############################################################
 clear
echo 'Add part  Windows (ntfs/fat32)?'
while 
    read -n1 -p  "
    1 - yes
    
    0 - no: " wind # sends right after the keypress
    echo ''
    [[ "$wind" =~ [^10] ]]
do
    :
done
if [[ $wind == 0 ]]; then
  echo 'skipped'
  elif [[ $wind == 1 ]]; then
  echo "#####################################################################################"
echo ""
  echo 'Add disk "C" Windows?'
while 
    read -n1 -p  "
    1 - yes
    
    0 - no: " diskC # sends right after the keypress
    echo ''
    [[ "$diskC" =~ [^10] ]]
do
    :
done
if [[ $diskC == 0 ]]; then
  echo 'skipped'
  elif [[ $diskC == 1 ]]; then
   clear
 lsblk -f
  echo ""
  read -p " Point disk "C" part (ex. sda4, nvme0n1p4 ) : " diskCc
  mkdir /mnt/C 
  mount /dev/$diskCc /mnt/C
  fi
############### disk D ##############
echo 'Add disk "D" Windows?'
while 
    read -n1 -p  "
    1 - yes
    
    0 - no: " diskD # sends right after the keypress
    echo ''
    [[ "$diskD" =~ [^10] ]]
do
    :
done
if [[ $diskD == 1 ]]; then
 clear
 lsblk -f
  echo ""
  read -p " Point disk "D" part (ex. sda5 , nvme0n1p5) : " diskDd
  mkdir /mnt/D 
  mount /dev/$diskDd /mnt/D
  elif [[ $diskD == 0 ]]; then
  echo 'skipped'
  fi
###### disk E ########
echo 'Add disk "E" Windows?'
while 
    read -n1 -p  "
    1 - yes
    
    0 - no: " diskE  # sends right after the keypress
    echo ''
    [[ "$diskE" =~ [^10] ]]
do
    :
done
 if [[ $diskE == 1 ]]; then
  clear
 lsblk -f
  echo ""
  read -p " Point disk "E" part (ex. sda6 , nvme0n1p6) : " diskDe
  mkdir /mnt/E 
  mount /dev/$diskDe /mnt/E
  elif [[ $diskE == 0 ]]; then
  echo 'skipped'
  fi 
  fi
################################################################################### 
 # смена зеркал  
echo ""
echo " This stage can be skipped if you are not sure of your choice! "
echo " "
echo 'Changing mirrors (reflector) to increase the speed of loading packages?'
while 
    read -n1 -p  "
    1 - yes
    
    0 - no: " zerkala # sends right after the keypress
    echo ' '
    [[ "$zerkala" =~ [^10] ]]
do
    :
done
   if [[ $zerkala == 1 ]]; then
pacman -S reflector --noconfirm
reflector --verbose -l 50 -p https --sort rate --save /etc/pacman.d/mirrorlist
reflector --verbose -l 15 --sort rate --save /etc/pacman.d/mirrorlist
clear
  elif [[ $zerkala == 0 ]]; then
  clear
  echo 'skipped changing mirrors.'   
fi
pacman -Sy --noconfirm 
######
clear 
 echo "If you used wi-Fi (wifi-menu) to connect to the Internet, then "1" "
echo ""
echo " If you have a wifi module and you are not using it now, but will use it later for "
echo " exceptions to errors in the operation of the system I recommend "1" "
echo ""
echo 'Installing the base system, will you use wifi?'
while 
    read -n1 -p  "
    1 - yes
    
    2 - no: " x_pacstrap  # sends right after the keypress
    echo ''
    [[ "$x_pacstrap" =~ [^12] ]]
do
    :
done
 if [[ $x_pacstrap == 1 ]]; then
  clear
 pacstrap /mnt base base-devel linux linux-headers dhcpcd  which inetutils netctl wget networkmanager network-manager-applet mkinitcpio git dkms grub efibootmgr nano vi linux-firmware wpa_supplicant dialog
 genfstab -p -U /mnt >> /mnt/etc/fstab
 elif [[ $x_pacstrap == 2 ]]; then
  clear
  pacstrap /mnt base base-devel linux linux-headers dhcpcd which inetutils netctl wget nano vi linux-firmware efibootmgr grub mkinitcpio git dkms
  genfstab -p -U /mnt >> /mnt/etc/fstab
  fi 
##################################################
clear
echo "If you are installing using Wi fi then I recommend "1" "
echo ""
echo "if wired Internet then "2" "
echo ""
echo ' wi-fi or dhcpcd ?'
while 
    read -n1 -p  "1 - wi-fi, 2 - dhcpcd: " int # sends right after the keypress
    echo ''
    [[ "$int" =~ [^12] ]]
do
    :
done
if [[ $int == 1 ]]; then

  wget -P /mnt https://raw.githubusercontent.com/iamm3chanic/ArchLinux-install/master/EN/chroot
  chmod +x /mnt/chroot.sh 
  echo 'Congrats, the first stage is ready! '
  echo 'ARCH-LINUX chroot' 
  echo "1. check the Internet to continue the installation in chroot" 
  echo "2. command to start ./chroot "
  arch-chroot /mnt      
echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"
umount -R /mnt
reboot    
  elif [[ $int == 2 ]]; then
  arch-chroot /mnt sh -c "$(curl -fsSL https://raw.githubusercontent.com/iamm3chanic/ArchLinux-install/master/EN/chroot)"
echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"
umount -R /mnt
reboot  

fi
#####################################
###############часть вторая##########
elif [[ $menu == 2 ]]; then 
clear
echo "Welcome to installing ArchLinux GRUB-Legacy mode "
lsblk -f
echo ""
echo "Select "1" if you have not previously partitioned the disk and do not have partitions for ArchLinux "
echo " it is Better to choose 1, to put the LVM correctly!"
echo ""
echo 'Need disk partition?'
while 
   read -n1 -p  "
   1 - yes
    
   0 - no: " cfdis # sends right after the keypress
    echo ''
    [[ "$cfdis" =~ [^10] ]]
do
   :
done
 if [[ $cfdis == 1 ]]; then
  clear
 lsblk -f
  echo ""
  echo "The disk will now be marked up."
  echo " Create 3 sections: sda1 , flag boot type linux 83"
  echo "                    sda2 , type linux 82 solaris"
  echo "                    sda3 , type linux 83"
  echo "       be accurate, on sda3 there will be"
  echo "       2 parts, united by LVM"
  read -p "POINT YOUR DISK (ex. sda , nvme0n1) : " cfd
cfdisk /dev/$cfd
elif [[ $cfdis == 0 ]]; then
echo 'skipped partition.'   
fi
#
 clear
 lsblk -f
  echo ""
  
############ swap   ####################################################
 clear
 lsblk -f
 
  read -p "Point SWAP part (ex. sda2, nvme0n1p2):" swaps
  mkswap /dev/$swaps -L swap
  swapon /dev/$swaps
  
################  home     ############################################################ 
clear
echo ""
echo " Starting to create a logical volume."
echo ""
lsblk -f
read -p "Point LVM part (ex. sda3, nvme0n1p3):" home


pvcreate /dev/$home
vgcreate vg_arch /dev/$home
read -p "How many GB giving to root?:
        ! Write a number and letter G, example: 15G !" nor
lvcreate -L $nor -n root vg_arch
lvcreate -l 100%FREE -n home vg_arch
clear
echo "output of PVDISPLAY:"
pvdisplay
read -n 1 -s -r -p "Press any key to continue"
clear
echo "output of VGDISPLAY:"
vgdisplay
read -n 1 -s -r -p "Press any key to continue"
clear
echo "output of LVDISPLAY:"
lvdisplay
read -n 1 -s -r -p "Press any key to continue"

############ mount ################
 mkfs.btrfs /dev/vg_arch/root
 mkfs.btrfs /dev/vg_arch/home
 
  mount /dev/vg_arch/root /mnt/
  mkdir /mnt/home
  mount /dev/vg_arch/home /mnt/home/
#########################
########## boot  ########
echo ' add and format BOOT?'
echo " If you are installing and you already have a boot partition from the previous system "
echo " then you need to format it "1", if you have a boot partition not moved to another partition then "
echo " this stage can be skipped "2" "
while 
    read -n1 -p  "
    1-format and mount on a separate partition

    2-skip if there is no boot section : " boots 
    echo ''
    [[ "$boots" =~ [^12] ]]
do
    :
done
 if [[ $boots == 1 ]]; then
  read -p "Point BOOT part (ex. sda1, nvme0n1p1):" bootdd
  mkfs.ext2  /dev/$bootdd -L boot
  mkdir /mnt/boot
  mount /dev/$bootdd /mnt/boot
  elif [[ $boots == 2 ]]; then
 echo " skipped "
fi   


 
###################  раздел  ###############################################################
clear
echo 'Add part  Windows (ntfs/fat32)?'
while 
    read -n1 -p  "
    1 - yes
    
    0 - no: " wind # sends right after the keypress
    echo ''
    [[ "$wind" =~ [^10] ]]
do
    :
done
if [[ $wind == 0 ]]; then
  echo 'skipped'
  elif [[ $wind == 1 ]]; then
  echo "#####################################################################################"
echo ""
  echo 'Add disk "C" Windows?'
while 
    read -n1 -p  "
    1 - yes
    
    0 - no: " diskC # sends right after the keypress
    echo ''
    [[ "$diskC" =~ [^10] ]]
do
    :
done
if [[ $diskC == 0 ]]; then
  echo 'skipped'
  elif [[ $diskC == 1 ]]; then
   clear
 lsblk -f
  echo ""
  read -p " Point disk "C" part (ex. sda4, nvme0n1p4 ) : " diskCc
  mkdir /mnt/C 
  mount /dev/$diskCc /mnt/C
  fi
############### disk D ##############
echo 'Add disk "D" Windows?'
while 
    read -n1 -p  "
    1 - yes
    
    0 - no: " diskD # sends right after the keypress
    echo ''
    [[ "$diskD" =~ [^10] ]]
do
    :
done
if [[ $diskD == 1 ]]; then
 clear
 lsblk -f
  echo ""
  read -p " Point disk "D" part (ex. sda5 , nvme0n1p5) : " diskDd
  mkdir /mnt/D 
  mount /dev/$diskDd /mnt/D
  elif [[ $diskD == 0 ]]; then
  echo 'skipped'
  fi
###### disk E ########
echo 'Add disk "E" Windows?'
while 
    read -n1 -p  "
    1 - yes
    
    0 - no: " diskE  # sends right after the keypress
    echo ''
    [[ "$diskE" =~ [^10] ]]
do
    :
done
 if [[ $diskE == 1 ]]; then
  clear
 lsblk -f
  echo ""
  read -p " Point disk "E" part (ex. sda6 , nvme0n1p6) : " diskDe
  mkdir /mnt/E 
  mount /dev/$diskDe /mnt/E
  elif [[ $diskE == 0 ]]; then
  echo 'skipped'
  fi 
  fi
# смена зеркал  
echo ""
echo "This stage can be skipped if you are not sure of your choice! "
echo " "
echo 'Changing mirrors (reflector) to increase the speed of loading packages?'
while 
    read -n1 -p  "
    1 - yes
    
    0 - no: " zerkala # sends right after the keypress
    echo ' '
    [[ "$zerkala" =~ [^10] ]]
do
    :
done
   if [[ $zerkala == 1 ]]; then
pacman -S reflector --noconfirm
reflector --verbose -l 50 -p https --sort rate --save /etc/pacman.d/mirrorlist
reflector --verbose -l 15 --sort rate --save /etc/pacman.d/mirrorlist
clear
  elif [[ $zerkala == 0 ]]; then
  clear
   echo 'skippedchanging mirrors'   
fi
pacman -Sy --noconfirm
 ################################################################################### 
clear
echo ""
echo "If you used wi-Fi (wifi-menu) to connect to the Internet, then "1" "
echo ""
echo " If you have a wifi module and you are not using it now, but will use it later for "
echo " exceptions to errors in the operation of the system recommend "1" "
echo ""
echo 'Installing the base system, will you use wifi?'
while 
    read -n1 -p  "
    1 - yes
    
    2 - no: " x_pacstrap  # sends right after the keypress
    echo ''
    [[ "$x_pacstrap" =~ [^12] ]]
do
    :
done
 if [[ $x_pacstrap == 1 ]]; then
  clear
  pacstrap /mnt base base-devel linux linux-headers dhcpcd  which inetutils netctl wget networkmanager network-manager-applet mkinitcpio git dkms grub efibootmgr nano vi linux-firmware wpa_supplicant dialog
  genfstab -pU /mnt >> /mnt/etc/fstab
elif [[ $x_pacstrap == 2 ]]; then
  clear
  pacstrap /mnt base base-devel linux linux-headers dhcpcd which inetutils netctl wget nano vi linux-firmware efibootmgr grub mkinitcpio git dkms
  genfstab -pU /mnt >> /mnt/etc/fstab
fi 
 clear
###############################
clear
echo "If you are installing using Wi fi then I recommend "1" "
echo ""
echo "if wired Internet then "2" "
echo ""
echo ' wi-fi or dhcpcd ?'
while 
    read -n1 -p  "1 - wi-fi, 2 - dhcpcd: " int # sends right after the keypress
    echo ''
    [[ "$int" =~ [^12] ]]
do
    :
done
if [[ $int == 1 ]]; then

  wget -P /mnt https://raw.githubusercontent.com/iamm3chanic/ArchLinux-install/master/EN/chroot
  chmod +x /mnt/chroot.sh 
  echo 'Congrats, the first stage is ready! ' 
  echo 'ARCH-LINUX chroot' 
  echo '1. check the Internet to continue the installation in chroot' 
  echo '2. command to start ./chroot '
  arch-chroot /mnt      
echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"
umount -R /mnt
reboot    
  elif [[ $int == 2 ]]; then
  arch-chroot /mnt sh -c "$(curl -fsSL https://raw.githubusercontent.com/iamm3chanic/ArchLinux-install/master/EN/chroot)"
echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"
umount -R /mnt
reboot  
fi

##############################################
elif [[ $menu == 0 ]]; then
exit
fi
