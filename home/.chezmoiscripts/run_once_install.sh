#!/bin/sh

arch_install()
{
    sudo pacman -Syu
    sudo pacman -S --needed makepkg git base-devel kitty bat lsd zsh ripgrep fzf glow zsh-syntax-highlighting zsh-autosuggestions

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

install_yay()
{
    mkdir /tmp/yay
    cd /tmp/yay
    curl -OJ 'https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yay'
    makepkg -si
    cd -
    rm -rf /tmp/yay
    yay --version
}

debian_install()
{
    sudo apt update
    sudo apt upgrade
    sudo apt install wget git zsh ripgrep fzf kitty \
    zsh-syntax-highlighting zsh-autosuggestions

    # set zsh as default shell
    sudo chsh -s $(which zsh)

    # enable key bindings and auto-completion
    sudo apt-cache show fzf

    # install neovim
    wget https://github.com/neovim/neovim/releases/download/v0.7.0/nvim-linux64.deb
    sudo apt install ./nvim-linux64.deb
    rm nvim-linux64.deb

    # install lsd
    wget https://github.com/Peltoche/lsd/releases/download/0.22.0/lsd_0.22.0_amd64.deb
    sudo dpkg -i lsd_0.22.0_amd64.deb
    rm lsd_0.22.0_amd64.deb

    # install bat
    wget https://github.com/sharkdp/bat/releases/download/v0.21.0/bat_0.21.0_amd64.deb
    sudo dpkg -i bat_0.21.0_amd64.deb
    rm bat_0.21.0_amd64.deb

    # install glow
    wget https://github.com/charmbracelet/glow/releases/download/v1.4.1/glow_1.4.1_linux_amd64.deb
    sudo dpkg -i glow_1.4.1_linux_amd64.deb
    rm glow_1.4.1_linux_amd64.deb
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

if [ "$ID" = "arch" ]; then
   echo "This is Arch!"
   arch_install
elif [ "$ID_LIKE" = "debian" ] || [ "$ID" = "ubuntu" ]; then
   echo "This is Debian!"
   debian_install
else
   echo "No arch or debian"
fi
