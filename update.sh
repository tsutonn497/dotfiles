#!/bin/bash

# Update zsh custom scripts.
OH_MY_ZSH_DIR="$HOME/.oh-my-zsh/custom"
if [ ! -d "$OH_MY_ZSH_DIR" ]; then
  echo "Directory $OH_MY_ZSH_DIR does not exist."
else
  cp -v .oh-my-zsh/custom/*.zsh $OH_MY_ZSH_DIR
fi
