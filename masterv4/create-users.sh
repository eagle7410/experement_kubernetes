

// --- BASE ---
adduser master-base && usermod -aG root  master-base && passwd master-base
deluser master-base
sudo usermod -a -G sudo master-base
sudo systemctl status ufw
adduser master-slave && usermod -aG sudo  master-slave && passwd master-slave
sudo usermod -a -G root master-base

// --- SLAVE ---
adduser master-slave && usermod -aG root  master-slave && passwd master-slave
deluser master-slave
sudo usermod -a -G sudo master-slave
sudo systemctl status ufw
adduser master-base && usermod -aG sudo  master-base && passwd master-base
sudo usermod -a -G root master-base

// --- SSH ---
sudo apt install openssh-server
ssh-keygen -t rsa
ssh-copy-id master-slave@192.168.0.101

--Before init use only sudo
systemctl enable docker.service
kubeadm config images pull
kubeadm init --config /home/master-base/kubeadm-config.yaml

--- Disbled
sudo systemctl stop ufw

kubeadm join 10.0.2.15:6443 --token t240lk.wzkzbixs548a6vz3 --discovery-token-ca-cert-hash sha256:936c2159c77b13d98aa9d7dfe375d34de22c9bd4438abab8d6d5403e755fb0b8


// -- Need add to /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
Environment="cgroup-driver-systemd/cgroup-driver-cgroupfs"
ExecStart=
// Apply Calico
sudo kubectl apply -f  https://docs.projectcalico.org/v3.0/getting-started/kubernetes/installation/hosted/kubeadm/1.7/calico.yaml
sudo kubectl apply -f  https://docs.projectcalico.org/v3.0/getting-started/kubernetes/installation/hosted/kubeadm/1.7/calico.yaml
// -- Show Event
sudo kubectl -n kube-system get events
// --- Run DNS poDS
sed -i "s/\$KUBELET_EXTRA_ARGS/\$KUBELET_EXTRA_ARGS\ --cgroup-driver=systemd/g" /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
cat <<EOF >/etc/docker/daemon.json
{
    "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF

mkdir -p /etc/cni/net.d
cat > /etc/cni/net.d/10-flannel.conflist <<EOF
{
    "name": "cbr0",
    "plugins": [
        {
            "type": "flannel",
            "delegate": {
                "hairpinMode": true,
                "isDefaultGateway": true
            }
        },
        {
            "type": "portmap",
            "capabilities": {
                "portMappings": true
            }
        }
    ]
}
kubeadm join 10.0.2.15:6443 --token mur8gs.32paaw93qisoulvr --discovery-token-ca-cert-hash sha256:e5416a0475cd5735250640caf7795417444b2176b2026d9176287d7199e76f29
