# Description

This repository provides Dockerfiles for building and executing REHH version 2.0.4 for two and three populations  respectively. You can also execute the workflow in two modes: Taking into account racial composition, which implies specifying mix proportions, and without racial composition.

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

The script sample_run.sh provides an example with custom data to evaluate the workflow. You should rewrite it to customize to your needs.

The script run2pop.sh evaluates the workflow with the following parameters: 

  - First parameter is the ancestral population file name from SHAPEIT2, WITHOUT including the chromosome number
  - Second parameter is the problem population file name from SHAPEIT2
  - Third parameter is the maximum number of chromosomes to be used
  - Fourth parameter is the name of the R script to use: 
    - For no racial composition, use rehh-vanilla.R
    - For racial composition (5/8,3/8), use rehh-comp.R

# Contributors

  - Paulo Cecco
  - Hernán Morales Durand
