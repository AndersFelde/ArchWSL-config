if [ "$EUID" -ne 0 ]; then 
    tput setaf 1
    echo "Must be run as root"
    tput sgr0

    exit
fi

if ! ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
    tput setaf 1
    echo "Please connect to the internet"
    tput sgr0
    exit
fi

printUpdate()
{
    tput setaf 2
    echo "$1"
    tput sgr0
}

printUpdate "Skriv inn root password"
passwd
echo

printUpdate "Setting up sudoers file"
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel
echo

printUpdate "Creating user"
read -p "Username: " username
#convert uppercase to lowercase
username=$(echo $username | tr '[:upper:]' '[:lower:]')
useradd -m -G wheel -s /bin/bash $username
printUpdate "$username was created"
echo

printUpdate "Password for $username"
passwd $username
echo

printUpdate "Setting up pacman"
sed -i '/.no/s/^#//g' /etc/pacman.d/mirrorlist #uncommenter alle linjer med ".no" i mirrorlist
pacman-key --init
pacman-key --populate
pacman -Syy archlinux-keyring --noconfirm
pacman -Syyu --noconfirm
echo

printUpdate "Installing programs"
pacman -S git zsh neovim fzf bat lsd man wget neofetch gedit --noconfirm
pacman -S --needed base-devel --noconfirm
echo

printUpdate "Installing paru"
sudo -i -u $username bash << EOF
cd ~
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
cd ..
rm -rf ./paru
EOF
echo

printUpdate "Updating paru config"
sed -i '/BottomUp/s/^#//g' /etc/paru.conf
sed -i '/SudoLoop/s/^#//g' /etc/paru.conf
echo

printUpdate "Setting up zsh"
sudo -i -u $username bash << EOF
cd ~
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | /bin/bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
cd ~/.oh-my-zsh/custom/plugins/
git clone https://github.com/zsh-users/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions
EOF
chsh --shell /bin/zsh $username

printUpdate "Setting up config files"
sudo -i -u $username bash << EOF
paru -S dotter-rs-bin zoxide --noconfirm
cd ~
git clone https://github.com/AndersFelde/dotfiles .dotfiles
cd .dotfiles
cp .dotter/wsl_example.toml .dotter/local.toml
dotter deploy -v --force
EOF

printUpdate "Installing LunarVim"
sudo -i -u $username bash << EOF
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
git clone https://github.com/AndersFelde/lvim ~/.config/lvim
EOF

printUpdate "You are now done installing, follow the rest of the install guide"
