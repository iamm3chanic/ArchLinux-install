#!/bin/bash
#bash
#####
echo " готовы приступить?  "
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " hello # sends right after the keypress
    echo ''
    [[ "$hello" =~ [^10] ]]
do
    :
done
 if [[ $hello == 1 ]]; then
  clear
  echo "Добро пожаловать в установку ArchLinux"
  elif [[ $hello == 0 ]]; then
   exit   
fi
###
echo ""
echo "
Данный этап поможет вам избежать проблем с ключами 

Pacmаn, если используете не свежий образ ArchLinux для установки! "

echo ""
echo " Обновим ключи?  "
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " x_key 
    echo ''
    [[ "$x_key" =~ [^10] ]]
do
    :
done
if [[ $x_key == 1 ]]; then
  clear
  pacman-key --refresh-keys 
  elif [[ $x_key == 0 ]]; then
   echo " Обновление ключей пропущено "   
fi
##
clear
echo " Здесь выбирайте то каким режимом запущен установочный образ ArchLinux"
echo " Если вы загрузились в Uefi тогда "1" если legacy тогда "2" "
echo " Режим legacy только для mbr-таблицы разделов, Uefi для Gpt- таблицы разделов" 
echo   ""
echo "#################################################"
echo "#########  Пример вывода efibootmbr    ##########"
echo "####                                        #####"
echo "####      Если вы видите похожий список     #####"
echo "####     это означает что вы загрузились    #####"
echo "####             в режиме !!!UEFI!!!        #####"     	
echo "####                                        #####"
echo "####  BootOrder: 0003,0001,2001,2002,2003   #####"
echo "####  Boot0000* USB HDD: Generic Flash Disk #####"
echo "####  Boot0001* Windows Boot Manager	  #####"
echo "#################################################"
echo ""
echo "#################################################"
echo "########  Пример вывода efibootmbr     ##########"
echo "####                                         ####"
echo "####     Eсли вы увидите сообщение           ####"       
echo "####       такого содержания:                ####" 
echo "####       EFI variables are not             ####"	
echo "####     supported on this system.           ####"
echo "####                                         ####"
echo "#### <<<  Значит у вас legacy    >>>         ####"  
echo "#################################################"
echo ""
efibootmgr
echo ""
echo " UEFI( no grub ) или Grub-legacy? "
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
echo " Здесь вы можете удалить boot от старой системы, файлы Windows загрузчика не затрагиваются."
echo " если вам необходимо полность очистить boot раздел, то пропустите этот этап, далее установка предложит отформатировать boot раздел "
echo " При установке дуал бут раздел не нужно форматировать! "
echo ""
echo 'удалим старый загрузчик linux?'
while 
    read -n1 -p  "
    1 - удалим старый загрузчкик линукс 
    
    0 -(пропустить) - данный этап можно пропустить если установка производиться первый раз или несколько OS  " boots 
    echo ''
    [[ "$boots" =~ [^10] ]]
do
    :
done
if [[ $boots == 1 ]]; then
  clear
 lsblk -f
  echo ""
read -p "Укажите boot раздел ( например sda2, nvme0n1p3 ):" bootd
mount /dev/$bootd /mnt
cd /mnt
ls | grep -v EFI | xargs rm -rfv
cd /mnt/EFI
ls | grep -v Boot | grep -v Microsoft | xargs rm -rfv
cd /root
umount /mnt
  elif [[ $boots == 0 ]]; then
   echo " очистка boot раздела пропущена, далее вы сможете его отформатировать! "   
fi
#
pacman -Sy --noconfirm
##############################
clear
echo ""
echo " Выбирайте "1 ", если ранее не производилась разметка диска и у вас нет разделов для ArchLinux "
echo ""
echo 'Нужна разметка диска?'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " cfdis # sends right after the keypress
    echo ''
    [[ "$cfdis" =~ [^10] ]]
do
    :
done
 if [[ $cfdis == 1 ]]; then
   clear
 lsblk -f
  echo "Сейчас будет провдиться разметка диска."
  echo "Создайте 3 раздела: sda1 с флагом boot тип linux 83;"
  echo "                    sda2 тип linux 82 solaris"
  echo "                    sda3 тип linux 83"
  echo "       будьте внимательны, на sda3 потом появятся"
  echo "       2 раздела, объединенные ЛВМ"
  read -p "Укажите диск (например sda или nvme0n1) : " cfd
cfdisk /dev/$cfd
echo ""
clear
elif [[ $cfdis == 0 ]]; then
   echo ""
   clear
   echo 'разметка пропущена.'   
fi
#
  clear
  lsblk -f
  echo ""
 
########## boot  ########
 clear
 lsblk -f
  echo ""
echo 'форматируем BOOT?'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " boots # sends right after the keypress
    echo ''
    [[ "$boots" =~ [^10] ]]
do
    :
done
 if [[ $boots == 1 ]]; then
  read -p "Укажите BOOT раздел(например sda1, nvme0n1p1):" bootd
  mkfs.fat -F32 /dev/$bootd
  mkdir /mnt/boot
  mount /dev/$bootd /mnt/boot
  elif [[ $boots == 0 ]]; then
 read -p "Укажите BOOT раздел(например sda1, nvme0n1p1):" bootd 
 mkdir /mnt/boot
mount /dev/$bootd /mnt/boot
fi
############ swap   ####################################################
 clear
 lsblk -f
 
  read -p "Укажите swap раздел(например sda2, nvme0n1p2):" swaps
  mkswap /dev/$swaps -L swap
  swapon /dev/$swaps
  
################  home     ############################################################ 
clear
echo ""
echo " Приступаем к созданию логического объема."
echo ""
lsblk -f
read -p "Укажите ЛВМ раздел(например sda3, nvme0n1p3):" home
  cryptsetup -y luksFormat --type luks2 /dev/$home
  cryptsetup open /dev/$home cryptlvm
pvcreate /dev/$home
vgcreate vg_arch /dev/$home
read -p "Сколько гигaбайт отдаем под root?:" nor
lvcreate -L $nor G -n root vg_arch
lvcreate -l 100%FREE -n home vg_arch
clear
echo "Вот вывод PVDISPLAY:"
pvdisplay
read -n 1 -s -r -p "Press any key to continue"
clear
echo "Вот вывод VGDISPLAY:"
vgdisplay
read -n 1 -s -r -p "Press any key to continue"
clear
echo "Вот вывод LVDISPLAY:"
lvdisplay
read -n 1 -s -r -p "Press any key to continue"

############ mount ################
 mkfs.f2fs /dev/vg_arch/root
 mkfs.f2fs /dev/vg_arch/home

  mount /dev/vg_arch/root /mnt/
  mkdir /mnt/home
  mount /dev/vg_arch/home /mnt/home/
  

 clear
echo 'Добавим разделы  Windows (ntfs/fat32)?'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " wind # sends right after the keypress
    echo ''
    [[ "$wind" =~ [^10] ]]
do
    :
done
if [[ $wind == 0 ]]; then
  echo 'пропущено'
  elif [[ $wind == 1 ]]; then
  echo "#####################################################################################"
echo ""
  echo 'Добавим раздел диск "C" Windows?'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " diskC # sends right after the keypress
    echo ''
    [[ "$diskC" =~ [^10] ]]
do
    :
done
if [[ $diskC == 0 ]]; then
  echo 'пропущено'
  elif [[ $diskC == 1 ]]; then
   clear
 lsblk -f
  echo ""
  read -p " Укажите диск "C" раздел(sda/sdb 1.2.3.4 (sda4 например) ) : " diskCc
  mkdir /mnt/C 
  mount /dev/$diskCc /mnt/C
  fi
############### disk D ##############
echo 'Добавим раздел диск "D" Windows?'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " diskD # sends right after the keypress
    echo ''
    [[ "$diskD" =~ [^10] ]]
do
    :
done
if [[ $diskD == 1 ]]; then
 clear
 lsblk -f
  echo ""
  read -p " Укажите диск "D" раздел(sda/sdb 1.2.3.4 (sda5 например)) : " diskDd
  mkdir /mnt/D 
  mount /dev/$diskDd /mnt/D
  elif [[ $diskD == 0 ]]; then
  echo 'пропущено'
  fi
###### disk E ########
echo 'Добавим раздел диск "E" Windows?'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " diskE  # sends right after the keypress
    echo ''
    [[ "$diskE" =~ [^10] ]]
do
    :
done
 if [[ $diskE == 1 ]]; then
  clear
 lsblk -f
  echo ""
  read -p " Укажите диск "E" раздел(sda/sdb 1.2.3.4 (sda5 например)) : " diskDe
  mkdir /mnt/E 
  mount /dev/$diskDe /mnt/E
  elif [[ $diskE == 0 ]]; then
  echo 'пропущено'
  fi 
  fi
################################################################################### 
 # смена зеркал  
echo ""
echo " Данный этап можно пропустить если не уверены в своем выборе!!! " 
echo " "
echo 'Сменим зеркала (reflector) для увеличения скорости загрузки пакетов?'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " zerkala # sends right after the keypress
    echo ' '
    [[ "$zerkala" =~ [^10] ]]
do
    :
done
   if [[ $zerkala == 1 ]]; then
pacman -S reflector --noconfirm
reflector --verbose -l 50 -p http --sort rate --save /etc/pacman.d/mirrorlist
reflector --verbose -l 15 --sort rate --save /etc/pacman.d/mirrorlist
clear
  elif [[ $zerkala == 0 ]]; then
  clear
  echo 'смена зеркал пропущена.'   
fi
pacman -Sy --noconfirm 
######
clear 
 echo "Если для подключения к интернету использовали wifi (wifi-menu) тогда "1" "
 echo ""
 echo " Если у вас есть wifi модуль и вы сейчас его не используете, но будете использовать потом то для "
 echo " исключения ошибок в работе системы рекомендую "1" " 
 echo ""
 echo 'Установка базовой системы, будете ли вы использовать wifi?'
while 
    read -n1 -p  "
    1 - да
    
    2 - нет: " x_pacstrap  # sends right after the keypress
    echo ''
    [[ "$x_pacstrap" =~ [^12] ]]
do
    :
done
 if [[ $x_pacstrap == 1 ]]; then
  clear
 pacstrap /mnt base base-devel linux linux-headers dhcpcd  inetutils wget networkmanager network-manager-applet mkinitcpio git grub efibootmgr nano vi linux-firmware wpa_supplicant dialog
 genfstab -p -U /mnt >> /mnt/etc/fstab
 elif [[ $x_pacstrap == 2 ]]; then
  clear
  pacstrap /mnt base base-devel linux linux-headers dhcpcd inetutils wget nano vi linux-firmware efibootmgr grub mkinitcpio git
  genfstab -p -U /mnt >> /mnt/etc/fstab
  fi 
##################################################
clear
echo "Если вы производите установку используя Wifi тогда рекомендую  "1" "
echo ""
echo "если проводной интернет тогда "2" " 
echo ""
echo 'wifi или dhcpcd ?'
while 
    read -n1 -p  "1 - wifi, 2 - dhcpcd: " int # sends right after the keypress
    echo ''
    [[ "$int" =~ [^12] ]]
do
    :
done
if [[ $int == 1 ]]; then

  curl -LO https://raw.githubusercontent.com/iamm3chanic/ArchLinux-install/master/RU/chroot
  mv chroot /mnt
  chmod +x /mnt/chroot
  echo 'первый этап готов ' 
  echo 'ARCH-LINUX chroot' 
  echo '1. проверь  интернет для продолжения установки в черуте || 2.команда для запуска ./chroot ' 
  arch-chroot /mnt  /bin/bash
echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"
read -n 1 -s -r -p "Press any key to continue"
umount -a
reboot    
  elif [[ $int == 2 ]]; then
  arch-chroot /mnt sh -c "$(curl -fsSL https://raw.githubusercontent.com/iamm3chanic/ArchLinux-install/master/RU/chroot)"
echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"
read -n 1 -s -r -p "Press any key to continue"
umount -a
reboot  

fi
#####################################
###############часть вторая##########
elif [[ $menu == 2 ]]; then 
clear
echo "Добро пожаловать в установку ArchLinux режим GRUB-Legacy "
lsblk -f
echo ""
echo " Выбирайте "1", если ранее не производилась разметка диска и у вас нет разделов для ArchLinux "
echo " Лучше выбрать 1, чтоб правильно поставить ЛВМ!"
echo ""
echo 'Нужна разметка диска?'
while 
   read -n1 -p  "
   1 - да
    
   0 - нет: " cfdis # sends right after the keypress
    echo ''
    [[ "$cfdis" =~ [^10] ]]
do
   :
done
 if [[ $cfdis == 1 ]]; then
  clear
 lsblk -f
  echo ""
  echo "Сейчас будет провдиться разметка диска."
  echo "Создайте 3 раздела: sda1 с флагом boot тип linux 83;"
  echo "                    sda2 тип linux 82 solaris"
  echo "                    sda3 тип linux 83"
  echo "       будьте внимательны, на sda3 потом появятся"
  echo "       2 раздела, объединенные ЛВМ"
read -p " Укажите диск (например, sda или nvme0n1) " cfd
cfdisk /dev/$cfd
elif [[ $cfdis == 0 ]]; then
echo 'разметка пропущена.'   
fi
#
 clear
 lsblk -f
  echo ""
#read -p "Укажите ROOT раздел( например,):" root
#echo ""
#mkfs.ext4 /dev/$root -L root
#mount /dev/$root /mnt    
#UUUUUUUUUUUUUUUUUUUUUUUUUU

##############################
########## boot  ########
echo ' добавим и отформатируем BOOT?'
echo " Если производиться установка, и у вас уже имеется бут раздел от предыдущей системы "
echo " тогда вам необходимо его форматировать "1", если у вас бут раздел не вынесен на другой раздел тогда "
echo " этот этап можно пропустить "2" "
while 
    read -n1 -p  "
    1 - форматировать и монтировать на отдельный раздел
    
    2 - пропустить если бут раздела нет : " boots 
    echo ''
    [[ "$boots" =~ [^12] ]]
do
    :
done
 if [[ $boots == 1 ]]; then
  read -p "Укажите BOOT раздел(например sda1, nvme0n1p1):" bootd
  mkfs.ext2  /dev/$bootd -L boot
  mkdir /mnt/boot
  mount /dev/$bootd /mnt/boot
  elif [[ $boots == 2 ]]; then
 echo " идем дальше "
fi   

############ swap   ####################################################
 clear
 lsblk -f
 
  read -p "Укажите swap раздел(например sda2, nvme0n1p2):" swaps
  mkswap /dev/$swaps -L swap
  swapon /dev/$swaps
  
################  home     ############################################################ 
clear
echo ""
echo " Приступаем к созданию логического объема."
echo ""
lsblk -f
read -p "Укажите ЛВМ раздел(например sda3, nvme0n1p3):" home
   cryptsetup -y luksFormat --type luks2 /dev/$home
   cryptsetup open /dev/$home cryptlvm
pvcreate /dev/$home
vgcreate vg_arch /dev/$home
read -p "Сколько гигaбайт отдаем под root?:" nor
lvcreate -L $nor G -n root vg_arch
lvcreate -l 100%FREE -n home vg_arch
clear
echo "Вот вывод PVDISPLAY:"
pvdisplay
read -n 1 -s -r -p "Press any key to continue"
clear
echo "Вот вывод VGDISPLAY:"
vgdisplay
read -n 1 -s -r -p "Press any key to continue"
clear
echo "Вот вывод LVDISPLAY:"
lvdisplay
read -n 1 -s -r -p "Press any key to continue"

############ mount ################
 mkfs.f2fs /dev/vg_arch/root
 mkfs.f2fs /dev/vg_arch/home

  mount /dev/vg_arch/root /mnt/
  mkdir /mnt/home
  mount /dev/vg_arch/home /mnt/home/
  


###################  раздел  ###############################################################
 clear
echo 'Добавим разделы  Windows (ntfs/fat32)?'
while 
    read -n1 -p  "
    1 - да
    0 - нет: " wind # sends right after the keypress
    echo ''
    [[ "$wind" =~ [^10] ]]
do
    :
done
if [[ $wind == 0 ]]; then
  echo 'пропущено'
  elif [[ $wind == 1 ]]; then
  echo "#####################################################################################"
echo ""
echo 'Добавим раздел диск "C" Windows?'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " diskC # sends right after the keypress
    echo ''
    [[ "$diskC" =~ [^10] ]]
do
    :
done
if [[ $diskC == 0 ]]; then
  echo 'пропущено'
  elif [[ $diskC == 1 ]]; then
   clear
 lsblk -f
  echo ""
  read -p " Укажите диск "C" раздел(sda/sdb 1.2.3.4 (sda4 например) ) : " diskCc
  mkdir /mnt/C 
  mount /dev/$diskCc /mnt/C
  fi
############### disk D ##############
echo 'Добавим раздел диск "D" Windows?'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " diskD # sends right after the keypress
    echo ''
    [[ "$diskD" =~ [^10] ]]
do
    :
done
if [[ $diskD == 1 ]]; then
   clear
 lsblk -f
  echo ""
  read -p " Укажите диск "D" раздел(sda/sdb 1.2.3.4 (sda5 например)) : " diskDd
  mkdir /mnt/D 
  mount /dev/$diskDd /mnt/D
  elif [[ $diskD == 0 ]]; then
  echo 'пропущено'
  fi
###### disk E ########
echo 'Добавим раздел диск "E" Windows?'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " diskE  # sends right after the keypress
    echo ''
    [[ "$diskE" =~ [^10] ]]
do
    :
done
 if [[ $diskE == 1 ]]; then
   clear
 lsblk -f
  echo ""
  read -p " Укажите диск "E" раздел(sda/sdb 1.2.3.4 (sda5 например)) : " diskDe
  mkdir /mnt/E 
  mount /dev/$diskDe /mnt/E
  elif [[ $diskE == 0 ]]; then
  echo 'пропущено'
  fi 
  fi
# смена зеркал  
echo ""
echo " Данный этап можно пропустить если не уверены в своем выборе! " 
echo " "
echo 'Сменим зеркала (reflector) для увеличения скорости загрузки пакетов?'
while 
    read -n1 -p  "
    1 - да
    
    0 - нет: " zerkala # sends right after the keypress
    echo ' '
    [[ "$zerkala" =~ [^10] ]]
do
    :
done
   if [[ $zerkala == 1 ]]; then
pacman -S reflector --noconfirm
reflector --verbose -l 50 -p http --sort rate --save /etc/pacman.d/mirrorlist
reflector --verbose -l 15 --sort rate --save /etc/pacman.d/mirrorlist
clear
  elif [[ $zerkala == 0 ]]; then
  clear
   echo 'смена зеркал пропущена.'   
fi
pacman -Sy --noconfirm
 ################################################################################### 
clear
echo ""
 echo " Если у вас есть wifi модуль и вы сейчас его не используете, то для "
 echo " исключения ошибок в работе системы рекомендую "1" " 
 echo ""
 echo 'Установка базовой системы, будете ли вы использовать wifi?'
while 
    read -n1 -p  "
    1 - да
    
    2 - нет: " x_pacstrap  # sends right after the keypress
    echo ''
    [[ "$x_pacstrap" =~ [^12] ]]
do
    :
done
 if [[ $x_pacstrap == 1 ]]; then
  clear
  pacstrap /mnt base base-devel linux linux-headers dhcpcd inetutils wget networkmanager network-manager-applet mkinitcpio git grub efibootmgr nano vi linux-firmware wpa_supplicant dialog
  genfstab -pU /mnt >> /mnt/etc/fstab
elif [[ $x_pacstrap == 2 ]]; then
  clear
 pacstrap /mnt base base-devel linux linux-headers dhcpcd inetutils wget nano vi linux-firmware efibootmgr grub mkinitcpio git
  genfstab -pU /mnt >> /mnt/etc/fstab
fi 
 clear
###############################
clear
echo "Если вы производите установку используя Wifi тогда рекомендую  "1" "
echo ""
echo "если проводной интернет тогда "2" " 
echo ""
echo 'wifi или dhcpcd ?'
while 
    read -n1 -p  "1 - wifi, 2 - dhcpcd: " int # sends right after the keypress
    echo ''
    [[ "$int" =~ [^12] ]]
do
    :
done
if [[ $int == 1 ]]; then

  curl -LO https://raw.githubusercontent.com/iamm3chanic/ArchLinux-install/master/RU/chroot
  mv chroot /mnt
  chmod +x /mnt/chroot
  echo 'первый этап готов ' 
  echo 'ARCH-LINUX chroot' 
  echo '1. проверь  интернет для продолжения установки в черуте || 2.команда для запуска ./chroot ' 
  arch-chroot /mnt /bin/bash   
echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"
read -n 1 -s -r -p "Press any key to continue"
umount -a
reboot    
  elif [[ $int == 2 ]]; then
  arch-chroot /mnt sh -c "$(curl -fsSL https://raw.githubusercontent.com/iamm3chanic/ArchLinux-install/master/RU/chroot)"
echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"
read -n 1 -s -r -p "Press any key to continue"
umount -a
reboot  
fi

##############################################
elif [[ $menu == 0 ]]; then
exit
fi
