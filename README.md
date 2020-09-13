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
- раздел диска по-вашему в cfdisk (master, version1)
- раздел диска по-моему (version2) //временно на исправлении багов...
- поддержка UEFI и Legacy
- шифрованный LVM
- 7 DM на выбор (Plasma,Xfce,Gnome 3,Lxde,Deepin,Mate,Lxqt,i3 ( с или без DM ))
- приложения для загрузки сразу после настройки системы
- папка с чистыми командами, он же чек-лист
### TODO
+ various cryptsetup
+ no LVM version
### Благодарность:
- Помощник, основа: github.com/poruncov
- Тестировщик, бро: github.com/frutitutitut | github.com/dd1xt5r

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
- partition of disk in your way in cfdisk (master, version1 branch)
- partition of disk in my way(version2 branch)     //temporary improving bugs...
- UEFI and Legacy support
- encrypted LVM
- 7 DM's to choose (Plasma,Xfce,Gnome 3,Lxde,Deepin,Mate,Lxqt,i3 ( with or without DM ))
- apps to download right after configuring system
- folder with only raw commads, aka check-list
### TODO
+ various cryptsetup
+ no LVM version
### Thanks a lot:
- Helper&Base: github.com/poruncov
- Tester&Bro: github.com/frutitutitut | github.com/dd1xt5r

