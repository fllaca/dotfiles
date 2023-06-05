#!/bin/bash

script_dir=$(cd $(dirname $0) && pwd)
source ${script_dir}/common.sh

info "Installing Debian Packages"
# Neovim sources
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install -y \
	git \
	curl \
	xclip \
	vim \
	build-essential \
	cmake \
	python3-dev \
	tmux \
	neovim \
	zsh \
	fzf

