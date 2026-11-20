#!/usr/bin/env bash
set -u

CHECK_INTERVAL="${CHECK_INTERVAL:-10}"

while true; do
    # Find unmounted filesystem partitions. Swap and partitions without a filesystem are ignored.
    while IFS= read -r device; do
        [[ -z "$device" ]] && continue

        # Skip anything that is already mounted.
        if findmnt -rn -S "$device" >/dev/null 2>&1; then
            continue
        fi

        # Ask UDisks to mount the partition in the user's session.
        udisksctl mount --block-device "$device" >/dev/null 2>&1 || true
    done < <(lsblk -rpn -o NAME,TYPE,FSTYPE,MOUNTPOINT | awk '$2 == "part" && $3 != "" && $4 == "" { print $1 }')

    sleep "$CHECK_INTERVAL"
done
