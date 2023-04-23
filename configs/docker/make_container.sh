#! /bin/sh

image_name=$1
container_name=$2
if [ -z "$1" ]; then
    read -p "Enter image name: " image_name
    read -p "Enter container name: " container_name
fi

docker run -v $(pwd)/data/:/root/data/ -v /var/run/docker.sock:/var/run/docker.sock --name "$container_name" -it $image_name
