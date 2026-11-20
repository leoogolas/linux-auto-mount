# Linux Auto Mount

Automatically detects and mounts connected filesystem partitions on Linux using UDisks.

The script checks for unmounted filesystem partitions every 10 seconds and asks UDisks to mount them in the current user's session. Partitions without a filesystem, swap partitions, and already-mounted partitions are ignored.

## Install

Run this command in a terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/leoogolas/linux-auto-mount/main/install.sh | bash
```

The installer downloads the script and systemd user service, enables the service, and starts it immediately.

## Check status

```bash
systemctl --user status auto-mount.service
```

Follow logs:

```bash
journalctl --user -u auto-mount.service -f
```

## Stop

```bash
systemctl --user stop auto-mount.service
```

## Disable on login

```bash
systemctl --user disable --now auto-mount.service
```

## Uninstall

```bash
rm -rf ~/.local/bin/linux-auto-mount
rm ~/.config/systemd/user/auto-mount.service
systemctl --user daemon-reload
systemctl --user reset-failed
```

## Notes

- Requires `udisks2` and `curl`.
- Designed for desktop Linux distributions, including Bazzite.
- The service runs as a user service and mounts disks using UDisks.
- The polling interval defaults to 10 seconds.
