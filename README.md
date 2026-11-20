# Linux Auto Mount

Automatically detects and mounts connected filesystem partitions on Linux using UDisks.

The script checks for unmounted filesystem partitions every 10 seconds and asks UDisks to mount them in the current user's session. Partitions without a filesystem, swap partitions, and already-mounted partitions are ignored.

## Install

Run this command in a terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/leoogolas/linux-auto-mount/main/install.sh | bash
```

The installer downloads the script and systemd user service, installs a Polkit rule that allows members of the `wheel` group to mount filesystems without an administrator password, restarts Polkit, and enables the service.

The installer will ask for your administrator password once to install the Polkit rule.

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

To remove the Polkit rule as well:

```bash
sudo rm /etc/polkit-1/rules.d/10-mount-without-password.rules
sudo systemctl restart polkit
```

## Notes

- Requires `udisks2` and `curl`.
- Designed for desktop Linux distributions, including Bazzite.
- The service runs as a user service and mounts disks using UDisks.
- The Polkit rule applies to members of the `wheel` group.
- The polling interval defaults to 10 seconds.
