# ArchLinux-install
## EN
#### Be careful - the script might have some inacurracies.
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
 pacman -Syyu wget
 wget https://raw.githubusercontent.com/iamm3chanic/ArchLinux-install/master/EN/base
 chmod +x base
 ./base
```
Probably it could fail to download other part of script to /mnt, so after the end of script "base", if see no file named "chroot", do this:
```bash
 pacman -Syyu wget
 wget https://raw.githubusercontent.com/iamm3chanic/ArchLinux-install/master/EN/chroot
 chmod +x chroot
 ./chroot
```
In this script, in any version there are two folders - Russian and English.
For your comfort: 
- partition of disk in your way(version1 branch)
- partition of disk in my way(version2 branch)
- 7 DM's to choose (Plasma,Xfce,Gnome 3,Lxde,Deepin,Mate,Lxqt,i3 ( with or without DM ))
- apps to download right after configuring system
- folder with only raw commads, aka check-list
### Thanks a lot:
- Helper&Base: github.com/poruncov
- Tester&Bro: github.com/frutitutitut

## RU
#### Будьте внимательны - в скрипте могут быть неточности.
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
 pacman -Syyu wget
 wget https://raw.githubusercontent.com/iamm3chanic/ArchLinux-install/master/RU/base
 chmod +x base
 ./base
```
Вероятно, не получится другую часть скрипта в /mnt, поэтому после окончания работы скрипта "base", если не видите файла с именем "chroot", сделайте это:
```bash
 pacman -Syyu wget
 wget https://raw.githubusercontent.com/iamm3chanic/ArchLinux-install/master/RU/chroot
 chmod +x chroot
 ./chroot
```
В этом скрипте в любой версии есть две папки - RU и EN.
Для вашего удобства:
- раздел диска по-вашему (version1)
- раздел диска по-моему (version2)
- 7 DM на выбор (Plasma,Xfce,Gnome 3,Lxde,Deepin,Mate,Lxqt,i3 ( с или без DM ))
- приложения для загрузки сразу после настройки системы
- папка с чистыми командами, он же чек-лист
### Благодарность:
- Помощник, основа: github.com/poruncov
- Тестировщик, бро: github.com/frutitutitut
