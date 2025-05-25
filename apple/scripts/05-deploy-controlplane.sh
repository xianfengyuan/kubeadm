#!/usr/bin/env bash

sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=${PRIMARY_IP}

mkdir -p ~/.kube
sudo cp /etc/kubernetes/admin.conf ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config
chmod 600 ~/.kube/config
sudo kubeadm token create --print-join-command | sudo tee /tmp/join-command.sh > /dev/null
sudo chmod +x /tmp/join-command.sh

echo "Installing Weave for pod networking"
wget -q -O /tmp/weave.yaml https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s-1.11.yaml
perl -i -p0e 's/              env:\n                - name: INIT_CONTAINER/              env:\n                - name: IPALLOC_RANGE\n                  value: 10.244.0.0\/16\n                - name: INIT_CONTAINER/' /tmp/weave.yaml
kubectl apply -f /tmp/weave.yaml

# echo "Installing Calico for pod networking"
# wget -q -O /tmp/tiger.yaml https://raw.githubusercontent.com/projectcalico/calico/v3.29.3/manifests/tigera-operator.yaml
# wget -q -O /tmp/calico.yaml https://raw.githubusercontent.com/projectcalico/calico/v3.29.3/manifests/custom-resources.yaml
# perl -i -p0e 's/cidr: 192.168.0.0\/16/cidr: 10.244.0.0\/16/' /tmp/calico.yaml
# kubectl create -f /tmp/tiger.yaml
# kubectl create -f /tmp/calico.yaml

for s in $(seq 60 -10 10)
do
    echo "Waiting $s seconds for all control plane pods to be running"
    sleep 10
done
