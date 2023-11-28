# ⚙ Dotfiles
A setup helper for my Linux desktop
# How to?
* [Add User to Sudoers](#add-user-to-sudoers)
* [Boot splash screen](#change-boot-splash-screen)
* [Add contrib and non-free](#add-contrib-and-non-free)
* [Adjust System Clock](#Adjust-System-Clock)

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
add ```contrib``` and ```non-free```
# Adjust System Clock
```timedatectl set-local-rtc 1 --adjust-system-clock```
