#!/usr/bin/env bash
set -euo pipefail

REPO="https://raw.githubusercontent.com/leoogolas/linux-auto-mount/main"
INSTALL_DIR="$HOME/.local/bin/linux-auto-mount"
SERVICE_DIR="$HOME/.config/systemd/user"
POLKIT_RULE="/etc/polkit-1/rules.d/10-mount-without-password.rules"
TMP_RULE="$(mktemp)"

trap 'rm -f "$TMP_RULE"' EXIT

mkdir -p "$INSTALL_DIR" "$SERVICE_DIR"

curl -fsSL "$REPO/auto-mount.sh" -o "$INSTALL_DIR/auto-mount.sh"
curl -fsSL "$REPO/auto-mount.service" -o "$SERVICE_DIR/auto-mount.service"
curl -fsSL "$REPO/polkit/10-mount-without-password.rules" -o "$TMP_RULE"

chmod +x "$INSTALL_DIR/auto-mount.sh"

# Allow members of wheel to mount filesystem partitions without an admin prompt.
sudo install -D -m 0644 "$TMP_RULE" "$POLKIT_RULE"
sudo systemctl restart polkit

systemctl --user daemon-reload
systemctl --user enable --now auto-mount.service

echo "Linux Auto Mount installed and enabled."
echo "Check status with: systemctl --user status auto-mount.service"
