
#!/bin/bash

# local machine ip address
export K8SHA_IPLOCAL=192.168.0.105

# local machine etcd name, options: etcd1, etcd2, etcd3, etcd4, etcd5
export K8SHA_ETCDNAME=etcd2

# local machine keepalived state config, options: MASTER, BACKUP. One keepalived cluster only one MASTER, other's are BACKUP
export K8SHA_KA_STATE=MASTER

# local machine keepalived priority config, options: 102, 101, 100, 99, 98. MASTER must 102
export K8SHA_KA_PRIO=102

# local machine keepalived network interface name config, for example: eth0
export K8SHA_KA_INTF=enp0s3

#######################################
# all masters settings below must be same
#######################################

# master keepalived virtual ip address
export K8SHA_IPVIRTUAL=192.168.0.100

# master01 ip address
export K8SHA_IP1=192.168.0.104

# master02 ip address
export K8SHA_IP2=192.168.0.105

# master01 hostname
export K8SHA_HOSTNAME1=masterv21

# master02 hostname
export K8SHA_HOSTNAME2=masterv22


# keepalived auth_pass config, all masters must be same
export K8SHA_KA_AUTH=55df7dc334c90194d1600c483e10acfr

# kubernetes cluster token, you can use 'kubeadm token generate' to get a new one
export K8SHA_TOKEN=4ae6cb.9dbc7b3600a3de89

# kubernetes CIDR pod subnet, if CIDR pod subnet is "10.244.0.0/16" please set to "10.244.0.0\\/16"
export K8SHA_CIDR=10.244.0.0\\/16

##############################
# please do not modify anything below
##############################
