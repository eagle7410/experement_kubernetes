#!/usr/bin/env bash
# use sudo
apt update && apt install git && apt-get install -qy docker.io
apt-get update && apt-get install -y apt-transport-https
apt install curl
apt install ssh
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get install keepalived
##!!!?? Open for get base files
nano /etc/ssh/sshd_config
-> PermitRootLogin yes
systemctl restart ssh
## Has in clone. only root
