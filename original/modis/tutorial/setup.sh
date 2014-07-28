#!/bin/bash

cat /etc/skel/.bashrc >> ~/.bashrc

#source ~/.bashrc
#mkdir ../data
#cd ../data
#wget --no-check-certificate http://www.ci.uchicago.edu/swift/modis/modis-2002.tar.gz
#tar -zxf modis-2002.tar.gz
#cd ../tutorial

source ~/.bashrc
mkdir -p ../data/modis/2002
cd ../data/modis/2002
wget --no-check-certificate http://www.ci.uchicago.edu/swift/modis/europe.tar.gz
tar -zxf europe.tar.gz
cd -
