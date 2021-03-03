#!/bin/bash

GREEN='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

function info() {
    local msg=$1
    echo -e "${GREEN} [INFO]: ${msg}${NC}"
} 

function err() {
    local msg=$1
    echo -e "${RED} [ERROR]: ${msg}${NC}"
    exit 1
}

function last_path_segment() {
	echo $1 | sed -E 's/.*\/(.+)/\1/g'
}
