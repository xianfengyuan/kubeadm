# apple
This folder holds the script to bootstrap a kubernetes cluster on MAC m3 machine using kubeadm.

1. First launch 3 ubunto VMs using multipass.
2. Customize the kernel settings of the VMs.
3. Use kubeadm to provision 3 node cluster.

# k0s
This folder holds the ansible playbook to bootstrap a k0s cluster

1. setup ssh access for ansible
2. download k0s executable and bootstrap controlplane
3. download k0s executable and bootstrap worker
