#!/bin/bash

# vim stuff
git submodule init
git submodule update

# oh-my-zsh stuff
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# various files
./copy.sh
