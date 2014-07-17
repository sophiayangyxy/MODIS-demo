#!/bin/bash

mkdir ../data
cd ../data
wget http://www.ci.uchicago.edu/swift/modis/modis-2002.tar.gz
tar -zxf modis-2002.tar.gz
cd ../tutorial