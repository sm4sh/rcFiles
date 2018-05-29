#!/bin/bash
sudo apt-get install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
mkdir ~/src
git clone https://github.com/powerline/fonts.git ~/src/fonts
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
sh ~/src/fonts/install.sh
sh ~/src/rcFiles/create_links.sh
