#!/bin/sh

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

[ $? -eq 0 ] && printf "\nNvim Packer update successful" || printf "\nNvim Packer update failed"
