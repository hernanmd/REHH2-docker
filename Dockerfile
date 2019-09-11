FROM rocker/verse:3.5.1

# Set a user and the working directory
USER rstudio
WORKDIR /rehhfiles

# Set the container to run `Rscript --vanilla ` by default
# ENTRYPOINT ["/usr/local/bin/Rscript", "--save"]

# COPY load.st load.st

RUN R -e "install.packages(c('devtools')); \
Sys.setenv(unzip='internal',tar='internal'); \
require(devtools); \

#G Plot & dependencies; \
gtools <- 'https://cran.r-project.org/src/contrib/Archive/gtools/gtools_3.5.0.tar.gz'; \
install.packages(gtools, repos = NULL, type = 'source'); \
gdata <- 'https://cran.r-project.org/src/contrib/Archive/gdata/gdata_2.17.0.tar.gz'; \
install.packages(gdata, repos = NULL, type = 'source'); \
gplots <- 'https://cran.r-project.org/src/contrib/Archive/gplots/gplots_3.0.1.tar.gz'; \
install.packages(gplots, repos = NULL, type = 'source'); \

#GGplot2; \
ggplot2 <- 'https://cran.r-project.org/src/contrib/Archive/ggplot2/ggplot2_3.2.0.tar.gz'; \
install.packages(ggplot2, repos = NULL, type = 'source'); \

#Rehh &RehhData; \
rehhdata <- 'https://cran.r-project.org/src/contrib/rehh.data_1.0.0.tar.gz'; \
install.packages(rehhdata, repos = NULL, type = 'source'); \
rehh <- 'https://cran.rstudio.com/contrib/main/Archive/rehh/rehh_2.0.4.tar.gz'; \
install.packages(rehh, repos = NULL, type = 'source'); \

#Dplyr & dependencies; \
Bh <- 'https://cran.r-project.org/src/contrib/BH_1.69.0-1.tar.gz'; \
install.packages(Bh, repos = NULL, type = 'source'); \
assertthat <- 'https://cran.r-project.org/src/contrib/assertthat_0.2.1.tar.gz'; \
install.packages(assertthat, repos = NULL, type = 'source'); \
glue <- 'https://cran.r-project.org/src/contrib/glue_1.3.1.tar.gz'; \
install.packages(glue, repos = NULL, type = 'source'); \
magrittr <- 'https://cran.r-project.org/src/contrib/magrittr_1.5.tar.gz'; \
install.packages(magrittr, repos = NULL, type = 'source'); \
pkgconfig <- 'https://cran.r-project.org/src/contrib/pkgconfig_2.0.2.tar.gz'; \
install.packages(pkgconfig, repos = NULL, type = 'source'); \
R6 <- 'https://cran.r-project.org/src/contrib/R6_2.4.0.tar.gz'; \
install.packages(R6, repos = NULL, type = 'source'); \
Rcpp <-'https://cran.r-project.org/src/contrib/Rcpp_1.0.2.tar.gz'; \
install.packages(Rcpp, repos = NULL, type = 'source'); \
rlang <- 'https://cran.r-project.org/src/contrib/rlang_0.4.0.tar.gz'; \
install.packages(rlang, repos = NULL, type = 'source'); \
tibble <- 'https://cran.r-project.org/src/contrib/tibble_2.1.3.tar.gz'; \
install.packages(tibble, repos = NULL, type = 'source'); \
tidyselect <- 'https://cran.r-project.org/src/contrib/tidyselect_0.2.5.tar.gz'; \
install.packages(tidyselect, repos = NULL, type = 'source'); \

#Dplyr
dplyr <- 'https://cran.r-project.org/src/contrib/Archive/dplyr/dplyr_0.8.1.tar.gz'; \
install.packages(dplyr, repos = NULL, type = 'source');"
