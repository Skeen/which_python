#!/bin/bash

DEBIAN_IMAGES=$(curl -s https://registry.hub.docker.com/v1/repositories/debian/tags | jq -r ".[].name")
UBUNTU_IMAGES=$(curl -s https://registry.hub.docker.com/v1/repositories/ubuntu/tags | jq -r ".[].name")
FEDORA_IMAGES=$(curl -s https://registry.hub.docker.com/v1/repositories/fedora/tags | jq -r ".[].name")
CENTOS_IMAGES=$(curl -s https://registry.hub.docker.com/v1/repositories/centos/tags | jq -r ".[].name")
ALPINE_IMAGES=$(curl -s https://registry.hub.docker.com/v1/repositories/alpine/tags | jq -r ".[].name")

SHARED_COMMAND="source /etc/os-release; echo $PRETTY_NAME; python --version; python3 --version"
APT_COMMAND="apt-get update >/dev/null 2>/dev/null; apt-get install -y python python3 >/dev/null 2>/dev/null; $SHARED_COMMAND"
YUM_COMMAND="yum install -y python python3 >/dev/null 2>/dev/null; $SHARED_COMMAND"
APK_COMMAND="apk add python python3 >/dev/null 2>/dev/null; $SHARED_COMMAND"

for IMAGE in ${DEBIAN_IMAGES}; do
    echo "debian:$IMAGE"
    docker pull debian:$IMAGE >/dev/null 2>/dev/null
    docker run -it debian:$IMAGE /bin/bash -c "$APT_COMMAND"
    echo ""
done

for IMAGE in ${UBUNTU_IMAGES}; do
    echo "ubuntu:$IMAGE"
    docker pull ubuntu:$IMAGE >/dev/null 2>/dev/null
    docker run -it ubuntu:$IMAGE /bin/bash -c "$APT_COMMAND"
    echo ""
done

for IMAGE in ${FEDORA_IMAGES}; do
    echo "fedora:$IMAGE"
    docker pull fedora:$IMAGE >/dev/null 2>/dev/null
    docker run -it fedora:$IMAGE /bin/bash -c "$YUM_COMMAND"
    echo ""
done

for IMAGE in ${CENTOS_IMAGES}; do
    echo "centos:$IMAGE"
    docker pull centos:$IMAGE >/dev/null 2>/dev/null
    docker run -it centos:$IMAGE /bin/bash -c "$YUM_COMMAND"
    echo ""
done

for IMAGE in ${ALPINE_IMAGES}; do
    echo "alpine:$IMAGE"
    docker pull alpine:$IMAGE >/dev/null 2>/dev/null
    docker run -it alpine:$IMAGE /bin/bash -c "$APK_COMMAND"
    echo ""
done
