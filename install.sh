#!/bin/bash

# Function to echo with timestamp
log_echo() {
    echo "$(date +"%Y-%m-%d %H:%M:%S")[#] MAXTER@installer: $1"
}

# Display loading message
log_echo "Granting storage permission..."
termux-setup-storage > /dev/null 2>&1 && log_echo "Storage permission granted."

# Install required packages
yes | pkg install zsh > /dev/null 2>&1 && log_echo "Zsh installed."
yes | pkg install curl > /dev/null 2>&1 && log_echo "curl installed."
yes | pkg install git > /dev/null 2>&1 && log_echo "git installed."

# Install Oh My Zsh
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" > /dev/null 2>&1 && log_echo "Oh My Zsh installed."

# Clone Powerlevel10k theme
yes | git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k > /dev/null 2>&1 && log_echo "Powerlevel10k theme cloned."

# Clone zsh-syntax-highlighting
yes | git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1 > /dev/null 2>&1 && log_echo "zsh-syntax-highlighting cloned."

# Update .zshrc to include zsh-syntax-highlighting
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc" && log_echo "Updated .zshrc with syntax highlighting."

# Clone the MAXTER repository
git clone https://github.com/mahendraplus/MAXTER > /dev/null 2>&1 && log_echo "MAXTER repository cloned."

# Move and rename files to the home directory
mv -f MAXTER/termux $HOME/.termux > /dev/null 2>&1 && log_echo "Renamed and moved .termux."
mv -f MAXTER/p10k.zsh $HOME/.p10k.zsh > /dev/null 2>&1 && log_echo "Renamed and moved .p10k.zsh."
mv -f MAXTER/zshrc $HOME/.zshrc > /dev/null 2>&1 && log_echo "Renamed and moved .zshrc."

# Clean up: remove the original MAXTER repository folder
rm -rf MAXTER > /dev/null 2>&1 && log_echo "Cleaned up MAXTER repository."

# Change default shell to Zsh
chsh -s zsh > /dev/null 2>&1 && log_echo "Default shell changed to Zsh."

# Remove the introduction text
rm /data/data/com.termux/files/usr/etc/motd > /dev/null 2>&1 && log_echo "Introduction text removed."

log_echo "Script execution completed!"
