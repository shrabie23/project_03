#!/bin/bash

#Install vim and ansible on debian VM

IP=$(hostname -I | awk '{print $2}')

echo "START - install on - "$IP
echo "[1]: install vim"
apt-get update -qq >/dev/null
apt-get install -qq -y vim >/dev/null

echo "[2]: install ansible"
apt-get install -qq -y git sshpass wget ansible gnupg2 curl >/dev/null
echo "END - install "$IP
