#!/bin/sh

# Show the name of the directory where this script is located
SCRIPT_DIR=$(cd $(dirname $0); pwd)

# Create a symbolic link to dotfile in my home directory
ls -AF | grep -v '/' | grep '^\.' | xargs -I {} ln -sf ${SCRIPT_DIR}/{} $HOME/{}
