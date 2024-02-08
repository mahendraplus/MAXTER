#!/bin/bash

yes | apt update
yes | pkg update
# Grant storage permission
termux-setup-storage

# Install required packages
yes | pkg install zsh
yes | pkg install curl
yes | pkg install git

# Install Oh My Zsh
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Clone Powerlevel10k theme
git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Clone zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1

# Update .zshrc to include zsh-syntax-highlighting
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"

# Clone the MAXTER repository
git clone https://github.com/mahendraplus/MAXTER

#Copy and overwrite 
yes | cp -rf $HOME/MAXTER/maxterm.p10k.zsh $HOME/.p10k.zsh
yes | cp -rf $HOME/MAXTER/maxterm.zshrc $HOME/.zshrc
yes | cp -rf $HOME/MAXTER/maxterm.termux.properties $HOME/.termux/termux.properties
yes | cp -rf $HOME/MAXTER/maxterm.colors.properties $HOME/.termux/colors.properties
yes | cp -rf $HOME/MAXTER/maxterm.font.ttf $HOME/.termux/font.ttf

# Change default shell to Zsh
chsh -s zsh

# Remove the introduction text
rm /data/data/com.termux/files/usr/etc/motd

echo "Script execution completed!"