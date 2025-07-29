# apple

```
This folder holds the script to bootstrap a kubernetes cluster on MAC m3 machine using kubeadm.

1. First launch 3 ubunto VMs using multipass.
2. Customize the kernel settings of the VMs.
3. Use kubeadm to provision 3 node cluster.
```

## How to copy kubectl configuration

```
multipass transfer controlplane:.kube/config ~/.kube/config
```

## How to install metallb load balancer

```
kubectl apply -f metallb-native.yaml
kubectl apply -f metallb-config.yaml
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install ingress-nginx ingress-nginx/ingress-nginx --namespace default
kubectl get service --namespace default ingress-nginx-controller --output wide --watch
```

## How to enable local storage class

```
kubectl apply -f local-path-storage.yaml
```

## How to enable ArgoCD

```
kubectl create ns argocd
kubectl create -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
argocd admin initial-password -n argocd
kubectl port-forward svc/argocd-server -n argocd 8080:443

argocd login localhost:8080

kubectl apply -f fibs-app_app.yaml

argocd app list
```

## Useful kubernetes commands

```
kubectl run bb --image=curlimages/curl --rm -it -- sh

```

# k0s

```
This folder holds the ansible playbook to bootstrap a k0s cluster

1. setup ssh access for ansible
2. download k0s executable and bootstrap controlplane
3. download k0s executable and bootstrap worker
```
