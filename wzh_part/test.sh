#!/bin/bash

# untar your R installation
tar -xzf R402.tar.gz
tar -xzf fastICA_1.2-2.tar.gz
echo 'Untar finished' 1>&2
# make sure the script will use your R installation, 
# and the working directory as its home location
export PATH=$PWD/R/bin:$PATH
export RHOME=$PWD/R
export R_LIBS=$PWD/packages

# run your script
Rscript ica.R $1
