#!/bin/bash

# --- Configuration Variables (Customize these for your specific entry) ---
# Example 1: Local Partition Mount
# DEVICE_OR_UUID="UUID=YOUR_PARTITION_UUID_HERE" # Get this from 'sudo blkid'
# MOUNT_POINT="/mnt/mydata"
# FS_TYPE="ext4"
# OPTIONS="defaults,nofail" # nofail is crucial for external/network drives

# Example 2: CIFS Network Share Mount (recommended way with credentials file)
# Make sure cifs-utils is installed: sudo apt install cifs-utils / sudo dnf install cifs-utils
# Also ensure your credentials file exists and has correct permissions (e.g., /root/.cifs_credentials with 600)
# Example credentials file content:
# username=your_cifs_username
# password=your_cifs_password
# domain=your_ad_domain (optional)
# For creating the credentials file, refer to the previous answer.
CIFS_SERVER="$CIFS_SERVER"
CIFS_SHARE="$CIFS_SHARE"
MOUNT_POINT="$MOUNT_POINT"
CREDENTIALS_FILE="$CREDENTIALS_FILE" # Path to your secure credentials file
# echo "username=${CIFS_USERNAME}" | tee "${CREDENTIALS_FILE}" > /dev/null
# echo "password=${CIFS_PASSWORD}" | tee -a "${CREDENTIALS_FILE}" > /dev/null # -a for append
FS_TYPE="cifs"
# OPTIONS="credentials=${CREDENTIALS_FILE},iocharset=utf8,vers=3.0,uid=$(id -u calibreweb),gid=$(id -g calibreweb),file_mode=0770,dir_mode=0770,nofail,x-systemd.automount"

OPTIONS="uid=$(id -u $OWNER_NAME),gid=$(id -g $OWNER_GROUP_NAME),nofail"

# chown $(id -u calibreweb):$(id -g calibreweb) ${CREDENTIALS_FILE}

# NOTE: uid and gid should be the IDs of the local user/group that should own the mounted files.
# Use 'id -u YOUR_USERNAME' and 'id -g YOUR_USERNAME' to find these.

# Example 3: NFS Network Share Mount
# NFS_SERVER="nfsserver.example.com"
# NFS_SHARE="/export/data"
# MOUNT_POINT="/mnt/nfs_data"
# FS_TYPE="nfs"
# OPTIONS="defaults,nofail,x-systemd.automount"

# --- Common fstab fields ---
DUMP_OPTION="0" # Usually 0 for non-root filesystems and network shares
PASS_OPTION="0" # 0 for network shares; 2 for other local non-root filesystems; 1 for root fs


# --- Script Logic ---

FSTAB_FILE="/etc/fstab"
FSTAB_BACKUP="${FSTAB_FILE}.bak_$(date +%Y%m%d%H%M%S)"

# Construct the full fstab line based on your chosen example
# For local partition:
# FSTAB_ENTRY="${DEVICE_OR_UUID} ${MOUNT_POINT} ${FS_TYPE} ${OPTIONS} ${DUMP_OPTION} ${PASS_OPTION}"

# For CIFS network share:
FSTAB_ENTRY="//${CIFS_SERVER}/${CIFS_SHARE} ${MOUNT_POINT} ${FS_TYPE} ${OPTIONS} ${DUMP_OPTION} ${PASS_OPTION}"

echo ${FSTAB_ENTRY}

# For NFS network share:
# FSTAB_ENTRY="${NFS_SERVER}:${NFS_SHARE} ${MOUNT_POINT} ${FS_TYPE} ${OPTIONS} ${DUMP_OPTION} ${PASS_OPTION}"


# 1. Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Error: This script must be run as root or with sudo."
    exit 1
fi

# 2. Backup the existing fstab file
echo "Backing up ${FSTAB_FILE} to ${FSTAB_BACKUP}..."
cp "${FSTAB_FILE}" "${FSTAB_BACKUP}"
if [ $? -ne 0 ]; then
    echo "Error: Failed to create fstab backup. Exiting."
    exit 1
fi
echo "Backup created."

# 3. Create the mount point if it doesn't exist
if [ ! -d "${MOUNT_POINT}" ]; then
    echo "Mount point '${MOUNT_POINT}' does not exist. Creating it..."
    mkdir -p "${MOUNT_POINT}"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create mount point. Exiting."
        exit 1
    fi
    chmod 755 "${MOUNT_POINT}" # Adjust permissions as needed for your use case
fi

# 4. Check if the entry already exists in fstab (idempotency check)
# Using grep -qF for exact string match without output
if grep -qF "${FSTAB_ENTRY}" "${FSTAB_FILE}"; then
    echo "The specified fstab entry already exists. No changes made."
else
    # 5. Add the line to fstab
    echo "Adding the following line to ${FSTAB_FILE}:"
    echo "${FSTAB_ENTRY}"
    echo "${FSTAB_ENTRY}" | tee -a "${FSTAB_FILE}" > /dev/null

    if [ $? -ne 0 ]; then
        echo "Error: Failed to add entry to fstab. Reverting to backup."
        mv "${FSTAB_BACKUP}" "${FSTAB_FILE}"
        exit 1
    fi
    echo "Entry added successfully."
fi

# 6. Attempt to mount the new entry to verify (without rebooting)
echo "Attempting to mount the new entry: ${MOUNT_POINT}..."
mount "${MOUNT_POINT}" -o credentials=${CREDENTIALS_FILE}

if [ $? -eq 0 ]; then
    echo "SUCCESS: Share mounted successfully from the new fstab entry."
    echo "To verify, you can run 'df -h' or 'mount | grep ${MOUNT_POINT}'."
else
    echo "WARNING: Failed to mount the share from the new fstab entry."
    echo "Please check the entry (${FSTAB_ENTRY}) and your server/network connectivity."
    echo "Your fstab has been backed up to ${FSTAB_BACKUP}. You may need to revert if this entry causes issues."
fi

echo "Script finished."
