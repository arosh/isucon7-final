#!/bin/bash
set -ex
now=`date +%Y%m%d-%H%M%S`

# Nginx
if [ -e /var/log/nginx/access.log ]; then
  mv /var/log/nginx/access.log /var/log/nginx/access.log.$now
fi

if [ -e conf/nginx.conf ]; then
  cp conf/nginx.conf /etc/nginx/nginx.conf
fi

# Python
if [ -e conf/cco.python.service ]; then
  cp conf/cco.python.service /etc/systemd/system/cco.python.service
fi

# system
#if [ -e conf/sysctl.conf ]; then
#  cp conf/sysctl.conf /etc/sysctl.conf
#  sysctl -p
#fi
#
#if [ -e conf/limits.conf ]; then
#  cp conf/limits.conf /etc/security/limits.conf
#fi

# Redis
#if [ -e conf/redis.conf ]; then
#  cp conf/redis.conf /etc/redis/redis.conf
#fi
#redis-cli flushall

systemctl daemon-reload
systemctl reload nginx
systemctl restart cco.python
journalctl -f -u nginx -u cco.python
