#!/bin/bash

set -e

script_dir=$(cd $(dirname $0) && pwd)
source ${script_dir}/common.sh

VIM_PLUGIN_LIST="\
	scrooloose/nerdtree \
	SirVer/ultisnips \
	honza/vim-snippets \
	ervandew/supertab \
	airblade/vim-gitgutter \
	Xuyuanp/nerdtree-git-plugin \
	scrooloose/nerdcommenter \
	tomlion/vim-solidity \
	scrooloose/nerdtree-project-plugin \
	hashivim/vim-hashicorp-tools \
	neoclide/coc.nvim \
	junegunn/fzf \
	junegunn/fzf.vim
	"
VIM_PLUGINS_FOLDER=$HOME/.vim/bundle

function _pathogen_install() {
	mkdir -p ${HOME}/.vim/autoload ${VIM_PLUGINS_FOLDER} && \
	curl -LSso ${HOME}/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
}

function _git_clone() {
	local repo_url=$1
	local repo_folder=$2
	if pushd ${repo_folder}; then
		git pull
		popd
	else
		git clone ${repo_url} ${repo_folder}
	fi
}

function main() {
	# Install Pathogen
	info "Installing Pathogen"
	_pathogen_install

	# Download Plugins
	info "Installing Vim Plugins:"
	info "-----------------------"
	for plugin in ${VIM_PLUGIN_LIST}; do
		info "Cloning ${plugin}"
		local plugin_name=$(last_path_segment $plugin)
		_git_clone "https://github.com/${plugin}.git" "${VIM_PLUGINS_FOLDER}/${plugin_name}"
	done
}

# Entrypoint
main

