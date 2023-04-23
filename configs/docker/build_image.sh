#! /bin/sh

image_name=$1
if [ -z "$1" ]; then
    read -p "Enter image name: " image_name
fi

docker build --no-cache -f Dockerfile -t "$image_name" .