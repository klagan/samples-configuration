apt update
apt -y upgrade
apt -y install lynis rkhunter needrestart fail2ban clamav clamav-daemon
apt autoremove

# verify installations
systemctl list-units --type=service --state=running
