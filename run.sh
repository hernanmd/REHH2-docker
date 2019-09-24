#!/bin/bash

image_id=$(docker images | awk '$1 ~ /rehh-runner204/ { print $3 }')
pop1="BD_altiplano3-1-CAl-geno-maf-exclude-chr"
pop2="BD_altiplano3-1-CBBA-geno-maf-exclude-chr"
chrrange=$(seq 1 29)
for i in $chrrange; do 
	docker run -e PASSWORD=test --rm -v "$PWD":/rehhfiles -ti "$image_id"\
		"$pop1$i".PHASED.haps \
		"$pop1$i".PHASED.sample \
		"$pop2$i".PHASED.haps \
		"$pop2$i".PHASED.sample
done
