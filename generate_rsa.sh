#! /bin/bash
mkdir /vagrant/docker/ssh
ssh-keygen -q -t rsa -N '' -f /vagrant/docker/ssh/id_rsa
cp /vagrant/docker/ssh/* ~/.ssh/
