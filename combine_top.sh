#!/bin/bash
#Adds .itp files to a single topology file which can be read by galaxy. Uses default CHARMM-GUI name conventions and directory locations assuming inputs were genrated using CHARMM-GUI Input Generator 
grep -E -v "#include" topol.top > topol.top.tmp
cat `grep -E "#include" topol.top | sed 's/#include//' | sed 's/"//g'`>> galaxy_topol.top
cat topol.top.tmp >> galaxy_topol.top
rm topol.top.tmp

