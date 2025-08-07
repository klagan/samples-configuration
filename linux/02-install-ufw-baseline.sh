#!/bin/bash

# ==============================================================================
# UFW Security Script for a Linux Server
# Author: Kam L
# Date: July 24, 2025
#
# This script configures UFW (Uncomplicated Firewall) with a strong, secure
# baseline. It follows the principle of "deny all incoming" and then
# explicitly allows only essential services.
#
# USAGE:
# 1. Save the file as secure_ufw.sh.
# 2. Make it executable: chmod +x secure_ufw.sh
# 3. Run the script: sudo ./secure_ufw.sh
#
# IMPORTANT:
# - Run this script on a server you can access via console, or make sure
#   you have SSH access allowed before you enable the firewall to avoid
#   locking yourself out.
# - Customize the ports below to match your specific needs.
# ==============================================================================

# --- Variables ---
# Define the ports you want to allow.
# Add or remove ports from these lists as needed.
# Common ports are pre-filled as a reference.

SSH_PORT="22"         # Standard SSH port. CHANGE THIS if you use a different port!
HTTP_PORT="80"        # Standard port for web servers (HTTP)
HTTPS_PORT="443"      # Standard port for secure web servers (HTTPS)
PROMETHEUS_EXPORTER="9100" # prometheus node exporter
# Example: Add other service ports here
# MYSQL_PORT="3306"
# POSTGRES_PORT="5432"
# CUSTOM_APP_PORT="8080"

IPV4_INTERFACE=$(ip -4 route show default | awk '{print $5}')

IPV4_CIDR_SUBNET=$(ip addr show $IPV4_INTERFACE | grep 'inet ' | awk '{print $2}')


# --- Functions ---

# Function to check for root privileges
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root. Please use 'sudo'."
        exit 1
    fi
}

# Function to display the UFW status
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

# Step 1: Reset UFW to a clean state.
# This removes all existing rules and restores the default policies.
echo "Resetting UFW to a clean state..."
sudo ufw --force reset

# Step 2: Set default policies to deny incoming and allow outgoing.
# This is the most critical step for security. It blocks all incoming
# connections unless we explicitly allow them.
echo "Setting default policies: deny incoming, allow outgoing."
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Step 3: Allow essential services.
# This is where you grant access to the ports you need.
echo "Allowing essential services..."

# Allow SSH. This is crucial to avoid locking yourself out!
# If you are managing the server remotely, this must be done first.
echo "Allowing SSH on port $SSH_PORT/tcp..."
# sudo ufw allow $SSH_PORT/tcp
sudo ufw allow in proto tcp from 0.0.0.0/0 to any port $SSH_PORT

# Allow HTTP and HTTPS for a web server
echo "Allowing HTTP on port $HTTP_PORT/tcp..."
# sudo ufw allow $HTTP_PORT/tcp
sudo ufw allow in proto tcp from 0.0.0.0/0 to any port $HTTP_PORT

echo "Allowing HTTPS on port $HTTPS_PORT/tcp..."
# sudo ufw allow $HTTPS_PORT/tcp
# sudo ufw allow in proto tcp to any port $HTTPS_PORT
sudo ufw allow in proto tcp from 0.0.0.0/0 to any port $HTTPS_PORT

echo "Allowing HTTPS on port $PROMETHEUS_EXPORTER/tcp..."
# sudo ufw allow $PROMETHEUS_EXPORTER/tcp
sudo ufw allow in from $IPV4_CIDR_SUBNET to any port $PROMETHEUS_EXPORTER

# --- Custom Rules (Uncomment and customize as needed) ---

# Allow a database port from a specific IP or subnet
# echo "Allowing MySQL from a specific IP..."
# sudo ufw allow from 192.168.1.100 to any port $MYSQL_PORT

# Allow a custom application port from anywhere
# echo "Allowing Custom App on port $CUSTOM_APP_PORT/tcp..."
# sudo ufw allow $CUSTOM_APP_PORT/tcp

# --- Enable UFW ---
# This step activates the firewall with the rules defined above.
echo "Enabling UFW..."
sudo ufw --force enable

# Step 4: Display the final status to confirm the rules.
echo "UFW configuration complete."
show_status

echo "--- UFW is now configured and active! ---"
