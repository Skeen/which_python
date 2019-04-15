#!/bin/bash

DEBIAN_IMAGES=$(curl https://registry.hub.docker.com/v1/repositories/debian/tags | jq ".[].name")
UBUNTU_IMAGES=$(curl https://registry.hub.docker.com/v1/repositories/ubuntu/tags | jq ".[].name")


APT_COMMAND="apt-get update >/dev/null 2>/dev/null; apt-get install -y python python3 >/dev/null 2>/dev/null; python --version; python3 --version"

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
