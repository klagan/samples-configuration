# Useful commands

## Host

```bash
# change hostname
sudo hostnamectl set-hostname your-new-hostname

# check users on system
getent passwd

# login as root
sudo su -

# login in another user
sudo su - <username>

# list running services
sudo systemctl list-units --type=service --state=running

# vanila test
for i in {1..10}; do curl localhost > /dev/null; done

# download file via curl
curl -LJO <http address>
```

## Network

```bash
# list network nodes
arp -a

# using netdiscover package
sudo netdiscover -r xxx.xxx.xx.xx/24
```

## Shares

```bash
# list shares on a server
smbclient -L //server_ip_or_hostname -N

# mount windows share
sudo mkdir /mnt/windowsshare
sudo mount -t cifs //<WINDOWS_SERVER_IP_OR_HOSTNAME>/<SHARE_NAME> /mnt/windowsshare -o username=<your_username>,password=<your_password>,uid=<local_user_id>,gid=<local_group_id>

# find user id
id -u

# find group id
id -g

# example
sudo mount -t cifs //xxx.xxx.xx.xx/Public /mnt/homeserver -o uid=1001,gid=1001

# verify mount
df -h "/mnt/server/folder"

# change file/folder ownership
# uid:gid
sudo chown -R 1001:1001 /path/to/file/or/folder
```


## Security baselining

```bash
# audit system
sudo lynis audit system
```

```bash
# check for rootkits
sudo rkhunter --check
```

## Anti-virus with ClamAV

```bash
# verify clam user
getent passwd clamav
getent group clamav
```

```bash
# update av definitions
sudo systemctl stop clamav-freshclam
sudo freshclam
sudo systemctl enable --now clamav-freshclam
sudo systemctl enable --now clamav-daemon

# verify av services back
sudo systemctl status clamav-freshclam
sudo systemctl status clamav-daemon
```

```bash
# full scan (long time)
sudo clamscan -r /

# scan specific file/folder
clamscan -r -i /path/to/scan 
```
## SSH

### Secure SSH connection configuration

```bash
# edit ssh configuration file
vim /etc/ssh/sshd_config
```

- [x] Change the default SSH port (Port 22 to something else)
- [x] PermitRootLogin no
- [x] PasswordAuthentication no (if using SSH keys)
- [ ] AllowUsers <your_username> (to explicitly allow only certain users)

## WiFi

```bash

# list wifi access points
nmcli device wifi list

# turn wifi on/off
nmcli radio wifi on
nmcli radio wifi off

# connect to wifi
nmcli device wifi connect "your_SSID" password "your_Password"

# verify connection
nmcli connection show --active

# gui
nmtui
```
