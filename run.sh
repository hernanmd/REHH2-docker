#!/bin/sh

echo "First parameter is the ancestral population file name from SHAPEIT2, WITHOUT including the chromosome number"
pop1="$1"
pop2="$2"

# Optional argument: Maximum chromosome number
maxchr="$3"

# Obtain Docker image ID based on the published name
image_id=$(docker images | awk '$1 ~ /rehh-runner204/ { print $3 }')

# Apply the analysis on the whole genome up to maxchr
chrrange=$(seq 1 "$maxchr")

for i in $chrrange; do
	docker run \
		-e PASSWORD=test \
		-e maxchr="$maxchr" \
		-e chr="$i" \
		-e pop1haps="$pop1$i".PHASED.haps \
		-e pop1sample="$pop1$i".PHASED.sample \
		-e pop2haps="$pop2$i".PHASED.haps \
		-e pop2sample="$pop2$i".PHASED.sample \
		--rm \
		-v "$PWD":/rehhfiles \
		-ti "$image_id"
done
