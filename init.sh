#!/bin/bash

genSshKey()
{
    read -p "Enter your email: " email
    read -p "Enter output file name: " filename
    ssh-keygen -t ed25519 -C $email -f ~/.ssh/$filename
    eval "$(ssh-agent -s)"
    ssh-add --apple-use-keychain ~/.ssh/$filename
    pbcopy < ~/.ssh/$filename.pub
    echo -e "Public ssh key already on clipboard\n"
}

windowManagerSetup()
{
    brew install koekeishiya/formulae/skhd
    skhd --start-service
   
    brew install koekeishiya/formulae/yabai
    yabai --start-service
    
    stow yabai
    stow skhd
}


zsh4humans()
{
if command -v curl >/dev/null 2>&1; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
else
  sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
fi
}

# setup ssh keys
read -p "Setup GitHub 🐱 ssh key? (y/n) " yn

case $yn in 
	[yY] ) genSshKey ;;
    * ) echo -e "Nothing to do\n"
esac

# Install brew
read -p "Install brew 🍺? (y/n) " yn

case $yn in 
	[yY] ) /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" ;;
    * ) echo -e "Nothing to do\n"
esac

# Core utils
brew install coreutils curl git
brew install asdf stow gotop

# Stow .config files
stow zsh
stow git
stow kitty
stow bat
stow glow
stow macchina

# Install kitty terminal
brew install --cask kitty

# Fonts
brew tap homebrew/cask-fonts
brew install --cask font-fira-mono-nerd-font
brew install --cask font-fira-code-nerd-font
brew install --cask font-jetbrains-mono-nerd-font

# Install window manager
read -p "Install window manager 🪟? (y/n) " yn
case $yn in 
	[yY] ) windowManagerSetup ;;
    * ) echo -e "Nothing to do\n"
esac

case $yn in 
	[yY] ) bash <(curl -L https://nixos.org/nix/install) --daemon ;;
    * ) echo -e "Nothing to do\n"
esac

. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'

# Neovim
nix-env -iA nixpkgs.neovim \
  nixpkgs.tree-sitter \
  nixpkgs.ripgrep \
  nixpkgs.lazygit \
  nixpkgs.gdu \
  nixpkgs.bottom

# Astronvim https://astronvim.com
git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
# Add custom conf ~/.config/nvim/lua/user
stow nvim 

# Utils
nix-env -iA \
  nixpkgs.bat \
  nixpkgs.lsd \
  nixpkgs.glow \
  nixpkgs.macchina

bat cache --build

# Dev
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf plugin-add python https://github.com/asdf-community/asdf-python.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add kubectl https://github.com/asdf-community/asdf-kubectl.git
asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git

nix-env -iA nixpkgs.colima nixpkgs.minikube nixpkgs.docker-client

# zsh4humans
read -p "Setup zsh4humans 🧑‍💻? (y/n) " yn

case $yn in 
	[yY] ) zsh4humans ;;
    * ) echo -e "Nothing to do\n"
esac
