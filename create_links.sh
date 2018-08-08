#!/bin/bash
rc=$(pwd)
ln -sf $rc/.cvimrc ~/.cvimrc
ln -sf $rc/.ideavimrc ~/.ideavimrc
ln -sf $rc/.lsyncd ~/.lsyncd
ln -sf $rc/.lsyncd.exclude ~/.lsyncd.exclude
ln -sf $rc/.vimrc ~/.vimrc
ln -sf $rc/.zsh_history ~/.zsh_history
ln -sf $rc/.zshrc ~/.zshrc

cd /usr/share/X11/xkb/symbols/
sudo ln -sf $rc/bastian bastian
