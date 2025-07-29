# Useful commands

## Host

```bash
# change hostname
hostnamectl set-hostname your-new-hostname

# check users on system
getent passwd

# login as root
sudo su -

# login in another user
sudo su - <username>

# list running services
systemctl list-units --type=service --state=running

# vanila test
for i in {1..10}; do curl localhost > /dev/null; done

# download file via curl
curl -LJO <http address>

# if using raspberry pi - find model
cat /proc/device-tree/model

# find size of package
dpkg -s glances | grep 'Installed-Size:'
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
mkdir /mnt/windowsshare
mount -t cifs //<WINDOWS_SERVER_IP_OR_HOSTNAME>/<SHARE_NAME> /mnt/windowsshare -o username=<your_username>,password=<your_password>,uid=<local_user_id>,gid=<local_group_id>

# find user id
id -u

# find group id
id -g

# example
mount -t cifs //xxx.xxx.xx.xx/Public /mnt/homeserver -o uid=1001,gid=1001

# verify mount
df -h "/mnt/server/folder"

# persist the mount after servee restart
# edit fstab
vim /etc/fstab

# add mount map line to end of file
//xxx.xxx.xx.xx/share /path/to/mount cifs defaults,uid=1002,gid=1002,credentials=/path/.smbcredentials,nofail 0 0

# change file/folder ownership
# uid:gid
chown -R 1001:1001 /path/to/file/or/folder

# reload mount
# unmount current mapping
umount <path>

# reload fstab settings 
systemctl daemon-reload

# remount fstab
mount -a

# check mapping successful
df -h

```


## Security baselining

```bash
# audit system
lynis audit system
```

```bash
# check for rootkits
rkhunter --check
```

## Anti-virus with ClamAV

#### ClamAV optimisations

```bash
# edit clamav configuration file
sudo nano /etc/clamav/clamd.conf

# add or edit the entry below
ConcurrentDatabaseReload no

# restart clamav daemon
systemctl restart clamav-daemon

# OPTIONAL: can stop service completely
systemctl stop clamav-daemon
```

#### ClamAV management

```bash
# verify clam user
getent passwd clamav
getent group clamav
```

```bash
# update av definitions
systemctl stop clamav-freshclam
freshclam
systemctl enable --now clamav-freshclam
systemctl enable --now clamav-daemon

# verify av services back
systemctl status clamav-freshclam
systemctl status clamav-daemon
```

```bash
# full scan (long time)
clamscan -r /

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

## Remove the swapfile

```bash
# disable swapfile
swapoff /swapfile

#  make a backup of your fstab file first!
cp /etc/fstab /etc/fstab.bak

# remove the specific line using sed
sed -i '\%^/swapfile none swap sw 0 0$%d' /etc/fstab

# disable swapfile
rm /swapfile

# remove the following entries from /etc/sysctl.conf or from /etc/sysctl.d/
# vm.swappiness=10
# vm.vfs_cache_pressure=50

# reboot
reboot
```
