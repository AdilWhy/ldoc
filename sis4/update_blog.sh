#!/bin/bash
/usr/bin/podman pull docker.io/adilwhy/adilblog:latest
/usr/bin/systemctl restart adilblog
echo "$(date): Blog updated and restarted" >> /var/log/blog_update.log
