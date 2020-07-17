#!/bin/bash
echo "Starting sshd:"
/usr/sbin/sshd
echo "Starting nginx in non daemon mode:"
/usr/sbin/nginx -g 'daemon off;'
