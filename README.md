# ArchLinux-install
## RU
#### Прочитайте скрипт перед использованием и при необходимости отредактируйте его.
Для начала сделайте установочный диск так, как он описан здесь:
```
   https://wiki.archlinux.org/index.php/USB_flash_installation_medium
```
Затем загрузитесь с этого диска и как-нибудь подключитесь к интернету:
```
   https://wiki.archlinux.org/index.php/Network_configuration
   https://wiki.archlinux.org/index.php/Network_configuration/Ethernet
```
После успешного подключения, пишем:
```bash
 pacman -Sy
 curl -Lo base https://git.io/JUCyJ
 #ИЛИ#
 curl -OL https://raw.githubusercontent.com/iamm3chanic/ArchLinux-install/master/RU/base
 chmod +x base
 ./base
```

В этом скрипте в любой версии есть две папки - RU и EN.
Для вашего удобства:
- раздел диска по-вашему в cfdisk (master, version1, version3)
- раздел диска по-моему (version2) //временно на исправлении багов...
- версия без ЛВМ для тех, кто неуверен в себе (version1) :)
- шифрование ПОСЛЕ создания логического объёма и монтирования (version3)
- шифрование ПЕРЕД созданием логического объёма и монтированием (dev)
- поддержка UEFI и Legacy
- шифрованный LVM
- 7 DM на выбор (Plasma,Xfce,Gnome 3,Lxde,Deepin,Mate,Lxqt,i3 ( с или без DM ))
- приложения для загрузки сразу после настройки системы
- папка с чистыми командами, он же чек-лист
### TODO
+ создание шифрованного контейнера перед созданием логического объёма
+ various cryptsetup
### Полезные ссылки
- [Arch Wiki LVM](https://wiki.archlinux.org/index.php/LVM)
- [Статья Alex Creio](https://creio.github.io/arch-lvm-luks/)
- [Статья на хабре](https://habr.com/ru/post/420081/)
- [Моя статья](https://vc.ru/dev/159008-kak-ustanovit-arch-linux-lvm-ustranyaem-populyarnye-oshibki)
### Благодарность:
- Помощник, основа: github.com/poruncov
- Тестировщик, бро: github.com/frutitutitut (github.com/dd1xt5r)

## EN
#### Read the script before using and edit if necessary. 
To start with, make an insallation disk as it is described here:
```
   https://wiki.archlinux.org/index.php/USB_flash_installation_medium
```
Then boot from this disk and connect to the Internet somehow:
```
   https://wiki.archlinux.org/index.php/Network_configuration
   https://wiki.archlinux.org/index.php/Network_configuration/Ethernet
```
After successful connection, write:
```bash
 pacman -Sy
 curl -Lo base  https://git.io/JUCyO
 #OR#
 curl -OL https://raw.githubusercontent.com/iamm3chanic/ArchLinux-install/master/EN/base
 chmod +x base
 ./base
```

In this script, in any version there are two folders - Russian and English.
For your comfort: 
- partition of disk in your way in cfdisk (master, version1, version3 branch)
- partition of disk in my way(version2 branch)     //temporary improving bugs...
- version without LVM for those who are unsure of themselves (version1) :)
- encryption AFTER logical volume creation and mounting (version 3)
- encryption BEFORE creating a logical volume and mounting (dev)
- UEFI and Legacy support
- encrypted LVM
- 7 DM's to choose (Plasma,Xfce,Gnome 3,Lxde,Deepin,Mate,Lxqt,i3 ( with or without DM ))
- apps to download right after configuring system
- folder with only raw commads, aka check-list
### TODO
+ creating an encrypted container before creating a logical volume
+ various cryptsetup
### Useful links
- [Arch Wiki LVM](https://wiki.archlinux.org/index.php/LVM)
- [Alex Creio article](https://creio.github.io/arch-lvm-luks/)
- [Habr article](https://habr.com/ru/post/420081/)
- [My article](https://vc.ru/dev/159008-kak-ustanovit-arch-linux-lvm-ustranyaem-populyarnye-oshibki)
### Thanks a lot:
- Helper&Base: github.com/poruncov 
- Tester&Bro: github.com/frutitutitut (github.com/dd1xt5r)

