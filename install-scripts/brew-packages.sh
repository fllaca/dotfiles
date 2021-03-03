#!/bin/bash

script_dir=$(cd $(dirname $0) && pwd)
source ${script_dir}/common.sh

info "Installing Debian Packages"

brew install neovim
brew install aws-iam-authenticator
brew install ansible
brew install libpq
brew install libpq-dev
brew install jq
brew install flyway
brew install tree
brew install kubernetes-helm@v2.14.3
brew install kubernetes-helm@2.14.3
brew install wget
brew install kubectx
brew install kubens
brew install colordiff
brew install fluxcgtl
brew install fluxctl
brew install wscat
brew install kind
brew install skaffold
brew install ripgrep

