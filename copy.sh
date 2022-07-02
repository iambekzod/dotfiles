#!/bin/bash

cp .gitconfig ~/
cp -rf .vim ~/
cp simple.zsh-theme ~/.oh-my-zsh/themes/
cp .zshrc ~/
cp .vimrc ~/

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

. ~/.zshrc

vim +PluginInstall +qall
