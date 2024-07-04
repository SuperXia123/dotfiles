#!/usr/bin/zsh

cd ~/Softwares/neovim
rm -rf ./nvim.back || true
mv nvim nvim.back

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
mv ./nvim.appimage ./nvim

chmod u+x ./nvim
