nano /etc/hostname
-> HOST_NAME

git clone https://github.com/rjeka/kubernetes-ha.git
cd kubernetes-ha
docker-compose --file etcd/docker-compose.yaml up -d
nano create-config.sh
 set containt create-config.sh
