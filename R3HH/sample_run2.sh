#!/bin/sh

path="/usr/local/data/proyectos/huellas_seleccion/brangus"
popprefix1=Angus-chr-chr-
popprefix2=Brangus-chr-chr-
popprefix3=Zebu-chr-chr-

copy_infiles () {
	# Set our directory where SHAPEIT2 result files are located:
	local source_path="$1"
	# Copy according SHAPEIT2 files to the current directory
	cp -v "$source_path"/"$popprefix1"*.haps "$source_path"/"$popprefix1"*.sample .
	cp -v "$source_path"/"$popprefix2"*.haps "$source_path"/"$popprefix2"*.sample .
	cp -v "$source_path"/"$popprefix3"*.haps "$source_path"/"$popprefix3"*.sample .
}

# Clean the current directory input files
cleanup() {
	rm -fv "$popprefix"*.haps "$popprefix"*.sample
}

# trap cleanup EXIT INT QUIT TERM

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

copy_infiles "$path"
do_run_comp "$popprefix1" "$popprefix2" "$popprefix3" 29 rehh-comp.R
