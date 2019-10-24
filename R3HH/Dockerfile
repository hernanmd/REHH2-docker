FROM rocker/tidyverse:3.5.1

COPY install.R .
RUN Rscript install.R

# Set a user and the working directory
RUN mkdir -p /rehhfiles
#RUN chown rstudio /rehhfiles
#USER rstudio
WORKDIR /rehhfiles

COPY ./rehh-mprunner.R ./rehh-mprunner.R
CMD Rscript ./$rscript $chr $pop1haps $pop1sample $pop2haps $pop2sample $pop3haps $pop3sample $maxchr
