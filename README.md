# ⚙ Dotfiles
A setup helper for my Linux desktop
# How to?
* [Add User to Sudoers](#add-user-to-sudoers)
* [Boot splash screen](#change-boot-splash-screen)
* [Add contrib and non-free](#add-contrib-and-non-free)
* [Adjust System Clock](#adjust-system-clock)
* [File Sharing With Samba](#file-sharing)
* [Check Sha256sum](#check-sha256sum)
* [Run application with dedicated gpu](#run-with-dedicated-gpu)
# Add User to Sudoers
1. ```su -``` switches to root user
2. ```usermod -aG sudo <username>```
3. double check with ```groups <username>```
4. logout then login

# Change boot splash screen
edit ```/etc/default/grub```
```
# /etc/default/grub

GRUB_TIMEOUT=0
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
```
and run
```sudo update-grub```
# Add contrib and non-free
edit ```/etc/apt/sources.list```<br>
add ```contrib``` and ```non-free``` and ```non-free-firmware```
# Adjust System Clock
```
timedatectl set-local-rtc 1 --adjust-system-clock
```
# File Sharing
- install
```
sudo apt install -y samba
```
- create a folder where you wanna share files<br>
- edit ```/etc/samba/smb.conf``` and add this
```
[sambashare]
   comment = Share Folder
   path = <folder-location>
   browseable = yes
   read only = no
```
- restart the service
```
sudo service smbd restart
```
- allow samba in firewall
```
sudo ufw allow samba
```
- add password to the user (existing user)
```
sudo smbpasswd -a username
```
- To connect to samba
```
smb://<ip-address>/
```
***shared files will be available in sambashare***
# Check Sha256sum
```
echo '<sha256sum> <filename>' | sha256sum -c
# or
sha256sum -c <filename.sha256>
```
# Run with dedicated gpu
```
DRI_PRIME=1 <application>
```
