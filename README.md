# ⚙ Dotfiles
A setup helper for my Linux desktop
# How to?
* [Add User to Sudoers](#add-user-to-sudoers)
* [Boot splash screen](#change-boot-splash-screen)
* [Add contrib and non-free](#add-contrib-and-non-free)

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

### TODO: create installation script
* Install [zsh autosuggestion](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)
* Install [zsh syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)
* Install [zsh autocomplete](https://github.com/marlonrichert/zsh-autocomplete)
