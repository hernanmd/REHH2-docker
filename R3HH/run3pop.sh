#!/bin/sh

printf "First parameter is the ancestral population file name from SHAPEIT2, WITHOUT including the chromosome number\nSecond parameter is the problem population file name from SHAPEIT2\nThird parameter is the maximum number of chromosomes to be used\nFourth parameter is the name of the R script to use: \n\tFor no racial composition, use rehh-vanilla.R\n\tFor racial composition (5/8,3/8), use rehh-comp.R\n"

pop1="$1"
pop2="$2"
pop3="$3"

# Optional argument: Maximum chromosome number
maxchr="$4"
# R script name to execute
rscriptname="$5"

# Obtain Docker image ID based on the published name
image_id=$(docker images | awk '$1 ~ /r3hh-runner204/ { print $3 }')

# Apply the analysis on the whole genome up to maxchr
chrrange=$(seq 1 "$maxchr")

for i in $chrrange; do
	docker run \
		-e PASSWORD=test \
		-e maxchr="$maxchr" \
		-e rscript="$rscriptname" \
		-e chr="$i" \
		-e pop1haps="$pop1$i".PHASED.haps \
		-e pop1sample="$pop1$i".PHASED.sample \
		-e pop2haps="$pop2$i".PHASED.haps \
		-e pop2sample="$pop2$i".PHASED.sample \
		-e pop3haps="$pop3$i".PHASED.haps \
		-e pop3sample="$pop3$i".PHASED.sample \
		--rm \
		-v "$PWD":/rehhfiles \
		-ti "$image_id"
done
