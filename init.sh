# Intial "bloat"
pacman -Syyuu --noconfirm && yay --aur --noconfirm
pacman -S docker firefox chromium pulseaudio pulseaudio-alsa zsh
pacman -Rc conky
yay -S telegram-desktop-bin thunderbird pavucontrol-git visual-studio-code-bin \
       neovim-git

# docker config
systemctl enable docker
systemctl start docker
groupadd docker
groupadd docker

## docker multi-arch support
cp dockermultiarch.service /etc/systemd/system/
cp dockermultiarch /usr/bin/
chmod 755 /usr/bin/dockermultiarch
systemctl enable dockermultiarch.service
systemctl start dockermultiarch.service

# oh-my-zsh config
chsh -s $(which zsh)
sudo chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
