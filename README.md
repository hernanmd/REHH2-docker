[![license-badge](https://img.shields.io/badge/license-MIT-blue.svg)](https://img.shields.io/badge/license-MIT-blue.svg)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)

# Description

This repository provides Dockerfiles for building and executing [REHH](https://www.ncbi.nlm.nih.gov/pubmed/27863062) version 2.0.4 - a R package rehh to detect positive selection from haplotype structure - for two and three populations respectively. To use it you have to clone this repository, and then follow instructions below to build and execute. You can also execute the workflow in two modes: Taking into account racial composition, which implies specifying mix proportions, and without racial composition.

# Requirements

  - [Docker](https://www.docker.com/get-started)
  - [MSYS2](https://www.msys2.org/) (for Windows)
  - (optional) R: To plot RSB and XPEHH.
  
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
  - Guillermo Giovambattista

# Troubleshooting

If you experiment problems, please run the collect environment script: 

```bash
./collectEnv
```

And open an issue with the output in the [Issue Tracker](https://github.com/hernanmd/REHH2-docker/issues)).

# Contribute

**Working on your first Pull Request?** You can learn how from this *free* series [How to Contribute to an Open Source Project on 
GitHub](https://egghead.io/series/how-to-contribute-to-an-open-source-project-on-github)

If you have discovered a bug or have a feature suggestion, feel free to create an issue on Github.

If you'd like to make some changes yourself, see the following:

  - Fork this repository to your own GitHub account and then clone it to your local device
  - Edit the files with your favorite text editor.
  - Test.
  - Add _your GitHub username_ to add yourself as author below.
  - Finally, submit a pull request with your changes!
  - This project follows the [all-contributors specification](https://github.com/kentcdodds/all-contributors). Contributions of any kind are welcome!
  
# License

This software is licensed under the MIT License.

Copyright IGEVET (Instituto de Genética Veterinaria, CCT La Plata, Argentina), 2018-2019

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.