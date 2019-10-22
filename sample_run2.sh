#!/bin/sh

popprefix1=Angus-chr
popprefix2=Brangus-chr
popprefix3=Zebu-chr

copy_infiles () {
	# Set our directory where SHAPEIT2 result files are located:
	local source_path="$1"
	# Copy according SHAPEIT2 files to the current directory
	cp -v "$source_path"/"$popprefix1"*.haps "$source_path"/"$popprefix2"*.sample .
}

# Clean the current directory input files
cleanup() {
	rm -fv "$popprefix1"*.haps "$popprefix2"*.sample
}

trap cleanup EXIT INT QUIT TERM

# Do the REHH analysis
do_run_comp() {
	local maxchr="$4"
	local rscript="$5"
	./run3pop.sh \
		"$1" \
		"$2" \
		"$3" \
		"$maxchr" \
		"$rscript"
}

copy_infiles "/usr/local/data/proyectos/huellas_seleccion/brangus"
do_run "$popprefix1" "$popprefix2" "$popprefix3" 29 rehh-comp.R
