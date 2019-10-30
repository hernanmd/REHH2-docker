# Description

This repository provides Dockerfiles for building and executing [REHH](https://www.ncbi.nlm.nih.gov/pubmed/27863062) version 2.0.4 - a R package rehh to detect positive selection from haplotype structure - for two and three populations respectively. To use it you have to clone this repository, and then follow instructions below to build and execute. You can also execute the workflow in two modes: Taking into account racial composition, which implies specifying mix proportions, and without racial composition.

# Building

To build the Docker image to evaluate REHH with two populations, execute:

```bash
./build2pop.sh
```

To build the Docker image to evaluate REHH with three populations, execute:

```bash
./build3pop.sh
```

# Execution

The script **sample_run.sh** provides an example with custom data to evaluate the workflow. You should rewrite it to customize to your needs.

The script **run2pop.sh** evaluates the workflow with the following parameters: 

  - First parameter is the ancestral population file name from SHAPEIT2, WITHOUT including the chromosome number
  - Second parameter is the problem population file name from SHAPEIT2
  - Third parameter is the maximum number of chromosomes to be used
  - Fourth parameter is the name of the R script to use: 
    - For no racial composition, use **rehh-vanilla.R**
    - For racial composition (5/8,3/8), use **rehh-comp.R**

# Plotting

We provide a separate customizable R script (**plot_rsb_xpehh.R**) to generate plots for both ies2rsb (Tang 2007) [<doi:10.1371/journal.pbio.0050171>](https://doi.org/10.1371/journal.pbio.0050171) and ies2xpehh (Sabeti 2007) [<doi:10.1038/nature06250>](https://doi.org/10.1038/nature06250) methods, and recommend to execute in RStudio after successful run of the Docker image.

# Contributors

  - Paulo Cecco
  - Hernán Morales Durand
