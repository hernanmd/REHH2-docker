#!/bin/sh

# Set our directory where SHAPEIT2 result files are located:
source_path="/usr/local/data/proyectos/huellas_seleccion/highlanders"
# Copy all SHAPEIT2 files to the current directory
cp -v "$source_path"/*.haps "$source_path"/*.sample .

# Do the REHH analysis
./run.sh \
	BD_altiplano3-1-CBBA-geno-maf-exclude-chr \
	BD_altiplano3-1-CAl-geno-maf-exclude-chr \
	29

# Clean the current directory input files
rm -fv *.haps *.sample
