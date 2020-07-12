# ArchLinux-install
##EN
#### Be careful - the script might have some inacurracies.
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
 pacman -Syu wget
 wget https://raw.githubusercontent.com/iamm3chanic/ArchLinux-install/master/RU/base
 chmod +x base
 ./base
```
In this script, in any version there are two folders - Russian and English.
For your comfort: 
- partition of disk in your way(version1 branch)
- partition of disk in my way(version2 branch)
- 7 DM's to choose (Plasma,Xfce,Gnome 3,Lxde,Deepin,Mate,Lxqt,i3 ( with or without DM ))
- apps to download right after configuring system
### Thanks a lot:
- Helper&Base: github.com/poruncov
- Tester&Bro: github.com/frutitutitut

##RU
#### Будьте внимательны - в скрипте могут быть неточности.
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
 pacman -Syu wget
 wget https://raw.githubusercontent.com/iamm3chanic/ArchLinux-install/master/RU/base
 chmod +x base
 ./base
```
В этом скрипте в любой версии есть две папки - RU и EN.
Для вашего удобства:
- раздел диска по-вашему (version1)
- раздел диска по-моему (version2)
- 7 DM на выбор (Plasma,Xfce,Gnome 3,Lxde,Deepin,Mate,Lxqt,i3 ( с или без DM ))
- приложения для загрузки сразу после настройки системы
### Благодарность:
- Помощник, основа: github.com/poruncov
- Тестировщик, бро: github.com/frutitutitut
