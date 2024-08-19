#!/bin/bash

####################################################################
# 切到国内镜像源
####################################################################
NEW_MIRROR="Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/\$repo/os/\$arch"
# 备份原始的 mirrorlist 文件
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
# 在文件顶部插入新的镜像源
sudo echo "$NEW_MIRROR" | sudo tee /etc/pacman.d/mirrorlist
# 保留原始 mirrorlist 文件的其他内容
sudo sed -i '1,1d' /etc/pacman.d/mirrorlist.backup
sudo cat /etc/pacman.d/mirrorlist.backup >> /etc/pacman.d/mirrorlist
# 删除备份文件
sudo rm /etc/pacman.d/mirrorlist.backup
echo "Mirror source has been changed to Tsinghua University."
# 更新软件包数据库
sudo pacman -Syu --noconfirm

####################################################################
# 软件安装
####################################################################
# flatpak
sudo pacman -S --noconfirm --needed flatpak
# fuse for running of appimage
sudo pacman -S --noconfirm --needed fuse2
# lazygit
sudo pacman -S --noconfirm --needed lazygit
# neovim
sudo pacman -S --noconfirm --needed neovim
# openssh
sudo pacman -S --noconfirm --needed openssh
# python
sudo pacman -S --noconfirm --needed python
# ripgrep: support live_grep in telescope.nvim
sudo pacman -S --noconfirm --needed ripgrep
# xclip
sudo pacman -S --noconfirm --needed xclip
# gcc
sudo pacman -S --noconfirm --needed gcc
# gdb
sudo pacman -S --noconfirm --needed gdb
# cmake
echo "Installing cmake..."
sudo pacman -S --noconfirm --needed cmake
# unzip
echo "----------------------------------------"
echo "Installing unzip..."
sudo pacman -S --noconfirm --needed unzip

####################################################################
# git
####################################################################
# use delta as pager
sudo pacman -S --noconfirm --needed git-delta

####################################################################
# init ssh-key
####################################################################
if [ ! -f ~/.ssh/id_rsa ]; then
	echo "Please enter your email address: "
	read email
	if [ -z "$email" ]; then
		echo "Email address cannot be empty. Exiting."
		exit 1
	fi
	ssh-keygen -t rsa -b 4096 -C "$email"
	echo "SSH key generation completed for email: $email"
else
	echo "SSH key already exists."
fi


####################################################################
# Dotfiles configuration
####################################################################
if [ ! -d ~/.dotfiles ]; then
	echo "Cloneing dotfile configs..."
	git clone git@github.com:SuperXia123/dotfiles.git ~/.dotfiles --recurse-submodules
else
	echo "Dotfiles exists."
fi
~/.dotfiles/install

####################################################################
# Repositories
####################################################################
if [ ! -d ~/Repositories ]; then
  mkdir ~/Repositories
fi
cd ~/Repositories
if [ ! -d ~/Repositories/Playground ]; then
	echo "Cloneing Playground..."
  git clone git@github.com:SuperXia123/Playground.git
else
	echo "Playground exists."
fi

####################################################################
# OH MY ZSH
####################################################################
# zsh
echo "----------------------------------------"
echo "Installing zsh..."
sudo pacman -S --noconfirm --needed zsh
# oh-my-zsh
echo "Installing oh-my-zsh..."
echo $(which zsh) | sudo tee -a /etc/shells
chsh -s $(which zsh)
# install oh-my-zsh
# 克隆oh-my-zsh仓库
git clone https://gitee.com/mirrors/oh-my-zsh.git ~/.oh-my-zsh
# 使用oh-my-zsh的模板.zshrc文件
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
# plugin auto-suggestions
git clone https://gitee.com/Greenplumwine/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
if ! grep -q 'zsh-autosuggestions' ~/.zshrc; then
    sed -i '/^plugins=(/ s/)/ zsh-autosuggestions)/' ~/.zshrc
fi
# plugin zsh-syntax-highlighting
git clone https://gitee.com/Greenplumwine/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if ! grep -q 'zsh-syntax-highlighting' ~/.zshrc; then
    sed -i '/^plugins=(/ s/)/ zsh-syntax-highlighting)/' ~/.zshrc
fi
# zsh-z
git clone https://gitee.com/huyifeng0829/zsh-z.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
if ! grep -q 'zsh-z' ~/.zshrc; then
    sed -i '/^plugins=(/ s/)/ zsh-z)/' ~/.zshrc
fi

