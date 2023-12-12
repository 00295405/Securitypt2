#!/bin/bash

# Directory for backups
backup_dir="$HOME/backup"

# Check if the backup directory exists
if [ ! -d "$backup_dir" ]; then
    echo "Creating backup directory: $backup_dir"
    mkdir "$backup_dir"
    echo "Backup directory created."
else
    echo "Backup directory already exists: $backup_dir"
fi

# Create a timestamp for the backup
timestamp=$(date +\%Y\%m\%d_\%H\%M\%S)

# Define config files to backup
config_files=(
	"/etc/httpd/"
	"/etc/apache2/"
	"/etc/nginx/"
	"/etc/ssl/"
	"/etc/letsencrypt/"
	"/etc/ssl/certs/"
)

# Define log files to backup
log_files=(
    "/var/log/cron"
    "/var/log/kern.log"
    "/var/log/audit/audit.log"
    "/var/log/mail.log"
    "/var/log/mysql/error.log"
    "/var/log/apache2/error.log"
    "/var/log/apache2/access.log"
    "/var/log/auth.log"
    "/var/log/syslog"
)

# Create a backup archive with a timestamp
backup_archive="$backup_dir/backup_$timestamp.tar.gz"

# Backup log files
#tar -czvf "$backup_archive" -C / "${config_files[@]}" -C / "${log_files[@]}"
tar -czvf "$backup_archive" --directory=/ --files-from <(printf "%s\n" "${log_files[@]}" "${config_files[@]}" | grep -v '^$')


# Check if the backup was successful
if [ $? -eq 0 ]; then
  echo "Backup completed successfully. Archive saved to: $backup_archive"
else
  echo "Backup failed. Please check for errors. Possible Error: Not all Files found as mentioned!"
fi

