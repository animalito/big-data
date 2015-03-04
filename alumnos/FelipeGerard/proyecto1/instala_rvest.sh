#! /bin/zsh

parallel --nonall --basefile instala_rvest.R --slf instancias_aws \
"
  sudo apt-get install -y libcurl4-gnutls-dev;
  sudo apt-get install -y r-cran-xml;
  sudo R --no-save < ./instala_rvest.R
"
