#!/bin/bash                                                                                                                                                                                    

for script in $(find * | grep .swift$)
do
   echo $script
   sed -i -e 's/@strcat/strcat/' $script
   sed -i -e 's/@filename/filename/' $script
   sed -i -e 's/@toInt/toInt/' $script
   sed -i -e 's/@arg/arg/' $script

done