mkdir -p /opt/sftpgo/data # This will be the actual SFTP user home directories
mkdir -p /opt/sftpgo/config # This will store SFTPGo's internal database/config

# For SFTPGo's default user (UID 1000, usually 'sftpgo')
# If your default Docker user is 1000:1000 (often the case for LinuxServer.io images too)
sudo chown -R 1000:1000 /opt/sftpgo/data
sudo chown -R 1000:1000 /opt/sftpgo/config

# http://your_server_ip:8080
