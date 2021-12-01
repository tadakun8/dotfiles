#!/bin/bash

# Create a symbolic link to dotfile in my home directory
# $1: dotfile path
function create_symbolic_link_to_homedir() {
  file_name=$(basename "${1}")
  ln -sf "${1}" "${HOME}"/"${file_name}"
}
export -f create_symbolic_link_to_homedir

cd "$(dirname "${0}")" || (echo 'Failure'; exit)

find "$(pwd)" -type f -mindepth 2 -maxdepth 2 | grep -v .git | xargs -I{} bash -c "create_symbolic_link_to_homedir {}"
