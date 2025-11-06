#!/bin/bash
if curl -s --head http://localhost | grep "200 OK" > /dev/null; then
  echo "$(date): Blog is OK" >> /var/log/blog_health.log
else
  echo "$(date): Blog DOWN!" >> /var/log/blog_health.log
fi