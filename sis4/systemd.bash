#!/bin/bash
# setup-adilblog.sh — install and manage Podman systemd service
set -e

SERVICE_FILE="/etc/systemd/system/adilblog.service"
IMAGE="docker.io/adilwhy/adilblog:latest"

echo "[INFO] Creating systemd service for Adil Hugo Blog..."

sudo bash -c "cat > $SERVICE_FILE" <<EOF
[Unit]
Description=Adil Hugo Blog Container
After=network.target

[Service]
ExecStart=/usr/bin/podman run --rm -p 80:80 $IMAGE
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

echo "[INFO] Reloading systemd daemon..."
sudo systemctl daemon-reload

echo "[INFO] Enabling service..."
sudo systemctl enable adilblog.service

echo "[INFO] Restarting service..."
sudo systemctl restart adilblog.service

echo "[INFO] Checking status..."
sudo systemctl --no-pager status adilblog.service

echo "[SUCCESS] Adil Hugo Blog container is running and managed by systemd."
