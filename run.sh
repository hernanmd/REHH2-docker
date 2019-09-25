#!/bin/sh

image_id=$(docker images | awk '$1 ~ /rehh-runner204/ { print $3 }')

pop1="$1"
pop2="$2"

chrrange=$(seq 1 29)
for i in $chrrange; do
	docker run \
		-e PASSWORD=test \
		-e chr="$i" \
		-e pop1haps="$pop1$i".PHASED.haps \
		-e pop1sample="$pop1$i".PHASED.sample \
		-e pop2haps="$pop2$i".PHASED.haps \
		-e pop2sample="$pop2$i".PHASED.sample \
		--rm \
		-v "$PWD":/rehhfiles \
		-ti "$image_id"
done
