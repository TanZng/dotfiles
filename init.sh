#!/bin/bash

genSshKey()
{
    read -p "Enter your email: " email
    read -p "Enter output file name: " filename
    ssh-keygen -t ed25519 -C $email -f $filename
    eval "$(ssh-agent -s)"
    pbcopy < "~/.ssh/${filename}.pub"
    echo -e "Public ssh key already on clipboard\n"
}

# zsh4humans
if command -v curl >/dev/null 2>&1; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
else
  sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
fi

# setup ssh keys
read -p "Setup GitHub 🐱 ssh key? (y/n) " yn

case $yn in 
	[yY] ) genSshKey ;;
    * ) echo -e "Nothing to do\n"
esac

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Core utils
brew install coreutils curl git
brew install asdf

# Install kitty terminal
brew install --cask kitty

# Fonts
brew install --cask font-fira-mono-nerd-font
brew install --cask font-fira-code-nerd-font
brew install --cask font-jetbrains-mono-nerd-font

# Install nix pkg manager
sh <(curl -L https://nixos.org/nix/install)

nix-env -iA nixpkgs.stow

# Neovim
nix-env -iA \ 
  nixpkgs.neovim \
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

brew install gotop

# Dev
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf plugin-add python https://github.com/asdf-community/asdf-python.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add kubectl https://github.com/asdf-community/asdf-kubectl.git
asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git

nix-env -iA nixpkgs.colima nixpkgs.minikube nixpkgs.docker-client

# Stow .config files
stow zsh
stow git
stow kitty
stow bat
stow glow
stow yabai
stow macchina

