# Intial "bloat"
pacman -Syyuu --noconfirm && yay --aur --noconfirm
pacman -S docker docker-compose firefox chromium pulseaudio pulseaudio-alsa zsh
pacman -Rc conky
yay -S telegram-desktop-bin thunderbird pavucontrol-git visual-studio-code-bin \
       neovim-git inkscape-git youtube-dl-git calibre-git etcher-git

# oh-my-zsh config
chsh -s $(which zsh)
sudo chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# docker config
systemctl enable docker
systemctl start docker
groupadd docker
usermod -aG docker $USER

### REBOOT HERE

## docker multi-arch support
docker build --platform=local -o . git://github.com/docker/buildx
mkdir -p ~/.docker/cli-plugins
mv buildx ~/.docker/cli-plugins/docker-buildx
docker buildx create --name mybuilder
docker buildx use mybuilder
docker buildx inspect --bootstrap
# https://github.com/docker/docker-ce/blob/master/components/cli/experimental/README.md
sudo printf "{\n\t\"experimental\": true\n}\n" | sudo tee /etc/docker/daemon.json

SHELL_RC="/dev/null"

if [ "/bin/zsh" == $SHELL ]
then
    SHELL_RC="/.zshrc"
fi
if [ "/bin/bash" == $SHELL ]
then
    SHELL_RC="/.bashrc"
fi

printf "\n\
# multiarch script configurations\n\
export DOCKER_CLI_EXPERIMENTAL=enabled\n\
export DOCKER_BUILDKIT=1\n\
" >> $HOME$SHELL_RC

cp dockermultiarch.service /etc/systemd/system/
cp dockermultiarch /usr/bin/
chmod 755 /usr/bin/dockermultiarch
systemctl enable dockermultiarch.service
systemctl start dockermultiarch.service

# rxvt-unicode (urxvt)
