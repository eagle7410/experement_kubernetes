-- show services
kubectl get services
-- show pods
kubectl get pods
-- show servers
kubectl get nodes
--- Run pods in master
kubectl taint nodes --all node-role.kubernetes.io/master-
