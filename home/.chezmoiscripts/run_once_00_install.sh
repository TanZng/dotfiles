#!/bin/sh

arch_install()
{
    sudo pacman -Syu
    sudo pacman -S --needed makepkg git base-devel p7zip kitty bat lsd zsh ripgrep fzf rofi rofi-emoji glow zsh-syntax-highlighting zsh-autosuggestions

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

    # Install gtk, cursors and icons
    get_catppuccin_theme
}

install_yay()
{
    # install yay
    printf 'Install yay (y/n)? '
    read answer
    if [ "$answer" != "${answer#[Yy]}" ]; then
        mkdir /tmp/yay
        cd /tmp/yay
        curl -OJ 'https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yay'
        makepkg -si
        cd -
        rm -rf /tmp/yay
        yay --version
    fi
}

debian_install()
{
    sudo apt update
    sudo apt upgrade
    sudo apt install wget git p7zip-full p7zip-rar zsh ripgrep fzf kitty \
    zsh-syntax-highlighting zsh-autosuggestions autoconf automake libtool-bin libtool rofi rofi-dev

    # set zsh as default shell
    sudo chsh -s $(which zsh)

    # enable key bindings and auto-completion
    sudo apt-cache show fzf

    # install neovim
    printf 'Install Neovim (y/n)? '
    read answer
    if [ "$answer" != "${answer#[Yy]}" ]; then
        wget https://github.com/neovim/neovim/releases/download/v0.7.0/nvim-linux64.deb
        sudo apt install ./nvim-linux64.deb
        rm nvim-linux64.deb
    fi

    # install lsd
    printf 'Install lsd (y/n)? '
    read answer
    if [ "$answer" != "${answer#[Yy]}" ]; then
        wget https://github.com/Peltoche/lsd/releases/download/0.22.0/lsd_0.22.0_amd64.deb
        sudo dpkg -i lsd_0.22.0_amd64.deb
        rm lsd_0.22.0_amd64.deb
    fi

    # install bat
    printf 'Install bat (y/n)? '
    read answer
    if [ "$answer" != "${answer#[Yy]}" ]; then
        wget https://github.com/sharkdp/bat/releases/download/v0.21.0/bat_0.21.0_amd64.deb
        sudo dpkg -i bat_0.21.0_amd64.deb
        rm bat_0.21.0_amd64.deb
    fi

    # install glow
    printf 'Install glow (y/n)? '
    read answer
    if [ "$answer" != "${answer#[Yy]}" ]; then
        wget https://github.com/charmbracelet/glow/releases/download/v1.4.1/glow_1.4.1_linux_amd64.deb
        sudo dpkg -i glow_1.4.1_linux_amd64.deb
        rm glow_1.4.1_linux_amd64.deb
    fi

    # install gtk, cursors and icons
    get_catppuccin_theme

    # install fonts
    get_fonts

    # install rofi plugins
    get_rofi_plugins
}

get_catppuccin_theme()
{
    printf 'Install Catppuccin blue mocha gtk theme (y/n)? '
    read answer
    if [ "$answer" != "${answer#[Yy]}" ]; then
        # Install cursors
        sudo mkdir -p /usr/share/icons/
        cd /usr/share/icons/
        sudo git clone https://github.com/catppuccin/cursors.git
        sudo unzip './cursors/cursors/Catppuccin-Mocha-*.zip'
        sudo rm -rf ./cursors

        # Install icons and patch folders in mocha-blue color
        sudo wget -qO- https://git.io/papirus-icon-theme-install | sudo sh
        sudo git clone https://github.com/catppuccin/papirus-folders.git
        sudo cp -r ./papirus-folders/src/* /usr/share/icons/Papirus
        ./papirus-folders/papirus-folders -C cat-mocha-blue --theme Papirus-Dark
        cd -

        # Install GTK theme
        sudo mkdir -p /usr/share/themes/
        sudo mkdir -p ~/.themes
        cd /usr/share/themes/
        sudo wget https://github.com/catppuccin/gtk/releases/download/update_23_02_2022/Catppuccin-blue.zip
        sudo unzip 'Catppuccin-blue.zip'
        sudo unzip 'Catppuccin-blue.zip' -d ~/.themes
        sudo rm Catppuccin-blue.zip
        cd -
    fi
}

get_fonts(){
    printf 'Install fonts (y/n)? '
    read answer
    if [ "$answer" != "${answer#[Yy]}" ]; then
        mkdir -p ~/.fonts
        cd ~/.fonts
        
        wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
        unzip FiraCode.zip -d FiraCode/
        rm -rf FiraCode.zip

        wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
        unzip JetBrainsMono.zip -d JetBrainsMono/
        rm -rf JetBrainsMono.zip

        cd -
    fi
}

get_rofi_plugins(){
    # Get rofi-emoji
    printf 'Install rofi-emoji (y/n)? '
    read answer
        if [ "$answer" != "${answer#[Yy]}" ]; then
        git clone https://github.com/Mange/rofi-emoji.git
        cd rofi-emoji
        autoreconf -i
        mkdir build
        cd build/
        ../configure
        make
        sudo make install
        cd ..
        cd ..
        rm -rf rofi-emoji/
        cd
   fi
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
   echo "This is Arch! "
   arch_install
elif [ "$ID_LIKE" = "debian" ] || [ "$ID" = "ubuntu" ]; then
   echo "This is Debian! "
   debian_install
else
   echo "No arch or debian"
fi
