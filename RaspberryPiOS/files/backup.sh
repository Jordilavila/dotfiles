#!/bin/bash

####################################
#
# Backup to NFS mount script.
#
####################################

# What to backup. 
backup_files="/home/pi/TelegramBots /var/www/html"

# Where to backup to.
dest="/media/HDDRED/rpibackups/backups"

# This script is prepared to backup data in two ways: weekely or daily
# Add to crontab with -d to have a daily backup respect to the saturday.
# 
# The weekely backup is an absolute backup, while the daily backup is a differential backup.
#
# Variables to fill:
#
# backup file name of the absolute copy:
BACKUP_FILE_NAME_ABS="Abs"
# backup file name of the differential copy:
BACKUP_FILE_NAME_DIFF="Diff"

# RSYNC variables
set -o errexit
set -o nounset
#set -o pipefail

readonly SOURCE_DIR=$backup_files
readonly BACKUP_DIR=$dest
readonly DATETIME="$(date '+%Y-%m-%d_%H:%M:%S')"
readonly BACKUP_PATH="${BACKUP_DIR}/${DATETIME}"
readonly LATEST_LINK="${BACKUP_DIR}/latest"

mkdir -p "${BACKUP_DIR}"
mkdir -p "${LATEST_LINK}"

# Begin the script
#
#. ~/.bash_profile
if [ $1 = "-d" ]
then
    echo "Differential Backup"
    rsync -aRv --delete \
        ${SOURCE_DIR} \
        --link-dest "${LATEST_LINK}" \
        --exclude-from="backup_exclude.lst" \
        "${BACKUP_PATH}"
    
    rm -rf "{$LATEST_LINK}"
    echo "Backup finished. Files:"
    ln -s "${BACKUP_PATH}" "${LATEST_LINK}"
elif [ $1 = "-a" ]
then
    echo "Absolute Backup"
    DATE=$( date -d "now" +%Y%m%d )
    TYPE=$BACKUP_FILE_NAME_ABS
    archive_file="$DATE-$TYPE.tar.gz"
    tar czf $dest/$archive_file $backup_files
    echo "Backup finished. Files:"
    ls -lh $dest
else
    echo "Invalid option"
    echo "The options are the next:"
    echo "-d Differential backup"
    echo "-a Absolute backup"
    echo ""
fi