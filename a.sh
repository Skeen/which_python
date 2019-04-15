#!/bin/bash

DEBIAN_IMAGES=$(curl https://registry.hub.docker.com/v1/repositories/debian/tags | jq -r ".[].name")
UBUNTU_IMAGES=$(curl https://registry.hub.docker.com/v1/repositories/ubuntu/tags | jq -r ".[].name")
FEDORA_IMAGES=$(curl https://registry.hub.docker.com/v1/repositories/fedora/tags | jq -r ".[].name")
CENTOS_IMAGES=$(curl https://registry.hub.docker.com/v1/repositories/centos/tags | jq -r ".[].name")

APT_COMMAND="apt-get update >/dev/null 2>/dev/null; apt-get install -y python python3 >/dev/null 2>/dev/null; python --version; python3 --version"
YUM_COMMAND="yum install -y python python3 >/dev/null 2>/dev/null; python --version; python3 --version"

for IMAGE in ${DEBIAN_IMAGES}; do
    echo "debian:$IMAGE"
    docker run -it debian:$IMAGE /bin/bash -c "$APT_COMMAND"
    echo ""
done

for IMAGE in ${UBUNTU_IMAGES}; do
    echo "ubuntu:$IMAGE"
    docker run -it ubuntu:$IMAGE /bin/bash -c "$APT_COMMAND"
    echo ""
done

for IMAGE in ${FEDORA_IMAGES}; do
    echo "fedora:$IMAGE"
    docker run -it fedora:$IMAGE /bin/bash -c "$YUM_COMMAND"
    echo ""
done

for IMAGE in ${CENTOS_IMAGES}; do
    echo "centos:$IMAGE"
    docker run -it centos:$IMAGE /bin/bash -c "$YUM_COMMAND"
    echo ""
done
