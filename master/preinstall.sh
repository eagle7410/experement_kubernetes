#!/usr/bin/env bash
apt update && apt install git && apt-get install -qy docker.io
# @source https://habr.com/company/southbridge/blog/334846/
apt-get update && apt-get install -y apt-transport-https
apt install curl
## Has in clone. only root
sudo apt install ssh

-- use sudo
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt update && apt install -y kubelet kubeadm kubernetes-cni kubeadctl

# Maybe
swapoff -a
#
apt install keepalived
systemctl enable keepalived
systemctl restart keepalived
sysctl net.bridge.bridge-nf-call-iptables=1
# AS ROOT

# master1
kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.0.101 --ignore-preflight-errors Swap
# master2
kubeadm init --apiserver-advertise-address=192.168.0.100 --ignore-preflight-errors Swap
# Relaod
systemctl daemon-reload
systemctl restart kubelet
kubeadm reset remove swap


# Result Ok
kubeadm join 192.168.0.101:6443 --token 53kdte.b7hfztigtyi59wze --discovery-token-ca-cert-hash sha256:72ee258b3cf9cbf13fe6f0943c813a135527173ff84e62061101ed23890ba2ae

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl create -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

 kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml

# Browser dashboard link
 https://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/

# -- all pods
kubectl get pods -o wide --all-namespaces

# Get token
kubectl create serviceaccount dashboard -n default
kubectl create clusterrolebinding dashboard-admin -n default --clusterrole=clucter-admin --serviceaccount=default:dashboard
# Need load adminuser.yml & cluster-admin.yml
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | awk '/^deployment-controller-token-/{print $1}') | awk '$1=="token:"{print $2}'
# Run dash
kubectl proxy --port=8001 --accept-hosts=^192.168.0.101$,^localhost$,^127.0.0.1$,^[::1]$


# Admin token
eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJhZG1pbi11c2VyLXRva2VuLXN3OGZ4Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImFkbWluLXVzZXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJmMzMxMjA0YS1kN2RkLTExZTgtYjgwMi0wODAwMjc4YzhkNWIiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZS1zeXN0ZW06YWRtaW4tdXNlciJ9.sCr7sVAc55wy5WLYzLfN2pScdHQVanoW1YOBDRk8pOGJjGXf9FobKCYSdj1vEQg3BjxDqaZL7Nfrvg-IPSMuE3KpteR8iZQan7RHCDiY8iIs7FQuRvGbIjpfPjC7OfiPC9AF4MOXc-RUDZm9_ncsJc90zxr2s_GYysUQYbhIyGOewkCiT-onB1iKth-Vp-ppiNy3vpGN5AaKcWbkaEwyV9z8v8xQhu8XeQBbp_f2j2R0SAM8-XraTM4EjfoZZZC2N2YRAa-bOfQ772Xo0Pysk2Pasg3E3HWuEfjIEvda6J9axxYM9SEP4CGTGiZOMFWMm75LF_jawHfD7YKPDXUHcw
