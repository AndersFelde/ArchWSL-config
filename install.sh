if [ "$EUID" -ne 0 ]
  then tput setaf 1; echo "Must be run as root"
  exit
fi

setaf 2
echo "Write your root password"
passwd
echo

setaf 2
echo "Setting up sudoers file"
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel
echo

echo "Creating user"
read -p "Username: " username
useradd -m -G wheel -s /bin/bash $username

echo "Password for user"
passwd $username
echo

echo "Setting up pacman"
pacman-key --init
pacman-key --populate
pacman -Syy archlinux-keyring --noconfirm
pacman -Syyu --noconfirm
echo

echo "Installing programs"
pacman -S git zsh neovim fzf bat lsd man wget neofetch --noconfirm
echo -ne "n\n\n\n" | pacman -S --needed base-devel
echo

echo "Installing paru"
sudo -i -u $username bash << EOF
cd ~
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
cd ..
rm -rf ./paru
EOF
echo

echo "Updating paru config"
sed -i '/BottomUp/s/^#//g' /etc/paru.conf
echo

echo "Setting up zsh"
sudo -i -u $username bash << EOF
cd ~
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | /bin/bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
wget https://raw.githubusercontent.com/AndersFelde/dotfiles/master/p10k
wget https://raw.githubusercontent.com/AndersFelde/dotfiles/master/zshrc
mv p10k .p10k.zsh
mv zshrc .zshrc
cd ~/.oh-my-zsh/custom/plugins/
git clone https://github.com/zsh-users/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions
EOF
chsh --shell /bin/zsh $username

setaf 2
echo "You are now done installing, follow the rest of the install guide"
