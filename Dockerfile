FROM rocker/tidyverse

RUN apt-get install -y \
        ssh-client \
        libsodium-dev \
        texlive \
        default-jdk \
        liblzma-dev \
        libbz2-dev

RUN Rscript -e "install.packages(c('rJava','Hmisc','xlsx','googlesheets','googledrive','RPostgres'))"
RUN Rscript -e "install.packages('togglr')"
RUN Rscript -e "install.packages('shiny')"
RUN Rscript -e "install.packages('openxlsx')"
RUN Rscript -e "devtools::install_github('mlgrm/svyr')"


# httr oauth doesn't work "in band" on rstudio server, so set the default to
# "TRUE" for httr out of band.  this means that when you run oauth, e.g. with
# googlesheets, you'll need to copy and paste the auth token into rstudio
RUN echo "options(httr_oob_default=TRUE)" >> /etc/R/Rprofile.site
RUN export ADD=shiny && bash /etc/cont-init.d/add
