# ArchLinux-install
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
 pacman -Sy wget
 wget https://raw.githubusercontent.com/iamm3chanic/ArchLinux-install/master/RU/base
 chmod +x base
 ./base
```
### Thanks a lot:
- Helper: github.com/poruncov
- Tester&Bro: github.com/frutitutitut
