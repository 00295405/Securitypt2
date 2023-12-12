#!/bin/bash

# Specify the file to store the snapshot
snapshot_file="/var/log/user_snapshot_$(date +\%Y\%m\%d_\%H\%M).txt"

# Capture user information and append it to the snapshot file
echo "User Snapshot at $(date)" >> "$snapshot_file"
echo "------------------------" >> "$snapshot_file"
cat /etc/passwd >> "$snapshot_file"


