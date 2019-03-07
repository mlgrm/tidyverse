FROM rocker/tidyverse

RUN apt install -y \
        ssh \
        libsodium-dev \
        texlive

RUN Rscript -e "install.packages('togglr')"
RUN	Rscript -e "install.packages('shiny')"
RUN Rscript -e "install.packages('googledrive')"
RUN Rscript -e "install.packages('googlesheets')"
RUN Rscript -e "install.packages('openxlsx')"
RUN	Rscript -e "devtools::install_github('mlgrm/svyr')"

# httr oauth doesn't work "in band" on rstudio server, so set the default to
# "TRUE" for httr out of band.  this means that when you run oauth, e.g. with
# googlesheets, you'll need to copy and paste the auth token into rstudio
RUN echo "options(httr_oob_default=TRUE)" >> /etc/R/Rprofile.site
