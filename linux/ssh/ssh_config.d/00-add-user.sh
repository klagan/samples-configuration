#!/bin/bash

new_user="user_name"
useradd -m "$new_user"

mkdir /home/"$new_user"/.ssh
chown "$new_user":"$new_user" /home/"$new_user"/.ssh
chmod 700 /home/"$new_user"/.ssh
touch /home/"$new_user"/.ssh/authorized_keys
chmod 600 /home/"$new_user"/.ssh/authorized_keys

echo "User $new_user created and .ssh directory set up."

# set password for user
# sudo passwd kam

# add to sudo group
# sudo usermod -a -G sudo kam

# ---> manual publickey addition to account
# ssh username@remote_host
# mkdir -p ~/.ssh
# touch ~/.ssh/authorized_keys
# echo "paste your public key here" >> ~/.ssh/authorized_keys
# chmod 700 ~/.ssh
# chmod 600 ~/.ssh/authorized_keys

# ---> automated publickey addition to account from client
# ssh-copy-id -i path/to/your/key.pub username@remote_host
# ssh-copy-id -i ~/.ssh/my_special_key.pub user@example.com

# better to use the manual method so that you do not need to assign passwords anywhere
# must also distribute the private key to the user

# ---> add user specific ssh configuration/restrictions
# /etc/ssh/sshd_config.d/90-kam.conf
# can match on multiple criteria like: Match User john.doe Address 192.168.1.5
# Match User new_user
#     PasswordAuthentication no
#     PubkeyAuthentication yes
