docker run -d -v /usr/share/ca-certificates/:/etc/ssl/certs -p 4001:4001 -p 2380:2380 -p 2379:2379 \
 --name etcd quay.io/coreos/etcd:v2.3.8 \
 -name etcd \
 -advertise-client-urls http://192.168.0.104:2379,http://192.168.0.104:4001 \
 -listen-client-urls http://0.0.0.0:2379,http://0.0.0.0:4001 \
 -initial-advertise-peer-urls http://192.168.0.104:2380 \
 -listen-peer-urls http://0.0.0.0:2380 \
 -initial-cluster-token 9489bf68bdfe1b9ae037d6fd9e7efefd \
 -initial-cluster etcd0=http://192.168.12.50:2380,etcd1=http://192.168.0.104:2380,etcd2=http://192.168.0.105:2380 \
 -initial-cluster-state new


 etcdctl member list \
  --endpoints=https://127.0.0.1:2380 \
   --cacert=/etc/etcd/ca.pem \
   --cert=/etc/etcd/kubernetes.pem \
   --key=/etc/etcd/kubernetes-key.pem
