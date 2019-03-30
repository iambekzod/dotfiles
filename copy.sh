#!/bin/bash

cp .gitconfig ~/
cp -rf .vim ~/
cp simple.zsh-theme ~/.oh-my-zsh/themes/
cp .vimrc ~/

vim +PluginInstall +qall
