#!/bin/bash

# ==============================================================================
# UFW Security Script for a Linux Server
# Author: Kam L
# Date: July 24, 2025
#
# This script configures UFW (Uncomplicated Firewall) with a strong, secure
# baseline. It follows the principle of "deny all incoming" and then
# explicitly allows only essential services.

# ==============================================================================

# --- Variables ---
SSH_PORT="22"                 # standard SSH port. CHANGE THIS if you use a different port!
HTTP_PORT="80"                # standard port for web servers (HTTP)
HTTPS_PORT="443"              # standard port for secure web servers (HTTPS)
PROMETHEUS_EXPORTER="9100"    # prometheus node exporter
# add other service ports here
# MYSQL_PORT="3306"
# POSTGRES_PORT="5432"
# CUSTOM_APP_PORT="8080"

IPV4_INTERFACE=$(ip -4 route show default | awk '{print $5}')
IPV4_CIDR_SUBNET=$(ip addr show $IPV4_INTERFACE | grep 'inet ' | awk '{print $2}')

# --- Functions ---
# check for root privileges
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root. Please use 'sudo'."
        exit 1
    fi
}

# display the UFW status
show_status() {
    echo "--- UFW Status ---"
    sudo ufw status verbose
    echo "------------------"
}

# --- Main Script ---
check_root

apt update
apt -y upgrade
apt -y install ufw
apt autoremove

echo "--- Starting UFW Configuration ---"

# reset UFW to a clean state. - removes all existing rules and restores the default policies.
echo "Resetting UFW to a clean state..."
sudo ufw --force reset

# set default policies to deny incoming and allow outgoing.
echo "Setting default policies: deny incoming, allow outgoing."
sudo ufw default deny incoming
sudo ufw default allow outgoing

# allow essential services.
echo "Allowing essential services..."

echo "Allowing SSH on port $SSH_PORT/tcp..."
sudo ufw allow in proto tcp from 0.0.0.0/0 to any port $SSH_PORT

echo "Allowing HTTP on port $HTTP_PORT/tcp..."
sudo ufw allow in proto tcp from 0.0.0.0/0 to any port $HTTP_PORT

echo "Allowing HTTPS on port $HTTPS_PORT/tcp..."
sudo ufw allow in proto tcp from 0.0.0.0/0 to any port $HTTPS_PORT

echo "Allowing HTTPS on port $PROMETHEUS_EXPORTER/tcp..."
sudo ufw allow in from $IPV4_CIDR_SUBNET to any port $PROMETHEUS_EXPORTER

# --- Enable UFW ---
echo "Enabling UFW..."
sudo ufw --force enable

echo "UFW configuration complete."
show_status

echo "--- UFW is now configured and active! ---"
