# stop the twingate service
sudo systemctl stop twingate-connector

# remove and purge the twingate package
sudo apt purge twingate-connector

# clean up any leftover folders
sudo rm /etc/systemd/system/twingate-connector.service

# reload the daemon service
sudo systemctl daemon-reload

