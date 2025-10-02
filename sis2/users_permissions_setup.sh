#!/bin/bash

# Users and Permissions Setup Script
# Based on existing system: adil_yerzhanuly, monitoring_system, logging_system

echo "=== Users and Permissions Setup ==="

# 1. Create groups (matching your existing setup + automation)
echo "Creating groups..."
sudo groupadd devops 2>/dev/null || echo "devops group exists"
sudo groupadd monitoring 2>/dev/null || echo "monitoring group exists"  
sudo groupadd logging 2>/dev/null || echo "logging group exists"
sudo groupadd content_author 2>/dev/null || echo "content_author group exists"
sudo groupadd monitoring_system 2>/dev/null || echo "monitoring_system group exists"
sudo groupadd logging_system 2>/dev/null || echo "logging_system group exists"
sudo groupadd automation 2>/dev/null || echo "automation group exists"

# 2. Create users (matching your existing setup)
echo "Creating users..."

# Main user (if not exists)
sudo useradd -m -u 1000 -g 1001 -s /bin/bash -c "Adil Yerzhanuly" adil_yerzhanuly 2>/dev/null || echo "adil_yerzhanuly exists"

# Service users for monitoring and logging
sudo useradd -u 999 -g monitoring_system -s /usr/sbin/nologin -d /home/monitoring_system -c "Monitoring System" monitoring_system 2>/dev/null || echo "monitoring_system exists"
sudo useradd -u 994 -g logging_system -s /usr/sbin/nologin -d /home/logging_system -c "Logging System" logging_system 2>/dev/null || echo "logging_system exists"

# Automation user for Ansible
sudo useradd -m -u 998 -g automation -s /bin/bash -c "Automation User for Ansible" automation_user 2>/dev/null || echo "automation_user exists"

# Add users to groups
echo "Adding users to groups..."
sudo usermod -aG devops adil_yerzhanuly 2>/dev/null || echo "adil_yerzhanuly already in devops"
sudo usermod -aG monitoring monitoring_system 2>/dev/null || echo "monitoring_system already in monitoring"  
sudo usermod -aG logging logging_system 2>/dev/null || echo "logging_system already in logging"
sudo usermod -aG automation automation_user 2>/dev/null || echo "automation_user already in automation"

# 3. Create directories and set permissions
echo "Setting up directories and permissions..."
sudo mkdir -p /var/www/blog
sudo chown adil_yerzhanuly:devops /var/www/blog
sudo chmod 755 /var/www/blog

sudo mkdir -p /opt/monitoring /var/lib/prometheus
sudo chown monitoring_system:monitoring /opt/monitoring /var/lib/prometheus
sudo chmod 755 /opt/monitoring /var/lib/prometheus

sudo mkdir -p /opt/logging /var/lib/loki  
sudo chown logging_system:logging /opt/logging /var/lib/loki
sudo chmod 755 /opt/logging /var/lib/loki

# Automation directories
sudo mkdir -p /opt/ansible /var/log/ansible
sudo chown automation_user:automation /opt/ansible /var/log/ansible
sudo chmod 755 /opt/ansible /var/log/ansible

# 4. Setup sudo permissions
echo "Setting up sudo permissions..."
cat << 'EOF' | sudo tee /etc/sudoers.d/devops
# DevOps group - Infrastructure management
%devops ALL=(ALL) NOPASSWD: /usr/bin/apt, /usr/bin/apt-get, /bin/systemctl, /usr/bin/docker, /usr/bin/ufw, /usr/bin/certbot, /usr/bin/hugo
adil_yerzhanuly ALL=(ALL) NOPASSWD: /usr/bin/apt, /usr/bin/apt-get, /bin/systemctl, /usr/bin/docker, /usr/bin/ufw, /usr/bin/certbot, /usr/bin/hugo
EOF

cat << 'EOF' | sudo tee /etc/sudoers.d/automation
# Automation group - Ansible operations
%automation ALL=(ALL) NOPASSWD: /usr/bin/systemctl, /usr/bin/docker, /usr/bin/ansible*, /usr/bin/python3, /bin/chmod, /bin/chown
automation_user ALL=(ALL) NOPASSWD: /usr/bin/systemctl, /usr/bin/docker, /usr/bin/ansible*, /usr/bin/python3, /bin/chmod, /bin/chown
EOF