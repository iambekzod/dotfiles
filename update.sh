#!/bin/bash

cp ~/.vimrc ./
cp -rf ~/.vim ./
cp ~/.oh-my-zsh/themes/simple.zsh-theme ./
cp ~/.zshrc ./
[ -f  .vim/.netrwhist ] && rm .vim/.netrwhist
cp ~/.gitconfig ./

git status -s
