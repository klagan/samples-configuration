apt update
apt upgrade -y
apt install vim lynx curl glances apt-listbugs neofetch -y
apt autoremove

# install pi apps appstore
wget -qO- https://raw.githubusercontent.com/Botspot/pi-apps/master/install | bash

# verify installations
systemctl list-units --type=service --state=running
