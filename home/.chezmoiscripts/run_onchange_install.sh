#!/bin/sh

arch_install()
{
    sudo pacman -Syu
    sudo pacman -S --needed makepkg git base-devel \
    kitty bat lsd zsh ripgrep \
    zsh-syntax-highlighting zsh-autosuggestions \
    fzf

    # Install if not root profile
    if [ "$EUID" -ne 0 ]
    then 
        install_yay
        yay -Syu
        yay -S --needed nerd-fonts-fira-code nerd-fonts-jetbrains-mono \
        ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols \
        ttf-font-awesome ttf-font-awesome-5 \
        ttf-weather-icons 
    else
        echo "You are root"
    fi
}

install_yay(){
    mkdir /tmp/yay
    cd /tmp/yay
    curl -OJ 'https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yay'
    makepkg -si
    cd -
    rm -rf /tmp/yay
    yay --version
}

###
# Main body of script starts here
###
if [ -f "/etc/os-release" ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    ID=$ID
    ID_LIKE=$ID_LIKE
fi

if [ $ID == "arch" ]
then
   echo "This is Arch!"
   arch_install
elif [ $ID_LIKE == "debian" ] || [ $ID == "ubuntu" ]
then
   echo "This is Debian!"
else
   echo "No arch or debian"
fi
