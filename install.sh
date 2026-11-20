#!/usr/bin/env bash
set -e

REPO="https://raw.githubusercontent.com/leoogolas/linux-auto-mount/main"
INSTALL_DIR="$HOME/.local/bin/linux-auto-mount"
SERVICE_DIR="$HOME/.config/systemd/user"

mkdir -p "$INSTALL_DIR" "$SERVICE_DIR"

curl -fsSL "$REPO/auto-mount.sh" -o "$INSTALL_DIR/auto-mount.sh"
curl -fsSL "$REPO/auto-mount.service" -o "$SERVICE_DIR/auto-mount.service"

chmod +x "$INSTALL_DIR/auto-mount.sh"

systemctl --user daemon-reload
systemctl --user enable --now auto-mount.service

echo "Linux Auto Mount installed and enabled."
echo "Check status with: systemctl --user status auto-mount.service"
