#!/bin/bash

image_id=$(docker images | awk '$1 ~ /rehh-runner204/ { print $3 }')
docker run -e PASSWORD=test --rm -v "$PWD":/rehhfiles -ti "$image_id"
