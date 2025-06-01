#!/bin/zsh

base_dir=$(dirname $0)

for i in 1 2; do
  multipass transfer ${base_dir}/known_hosts vm0${i}:udemypub
  multipass exec vm0${i} -- sh -c "cat udemypub >> /home/ubuntu/.ssh/authorized_keys"
done
