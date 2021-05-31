#!/bin/bash
for j in *;do cd $j; echo `sort -n -k 2 -t "," $j-out-out-out.csv | head -n 1 | awk -F "," '{print $1, $2}'` >> ~/Desktop/lowestE_2.csv;$SCHRODINGER/run extract_complex.py $j-out.maegz `sort -n -k 2 -t "," $j-out-out-out.csv | head -n 1 | awk -F "," '{print $1}' | sed "s/$j//g" | sed 's/[^0-9]*//g'` ;cd ..;done

for j in *;do cd $j;$SCHRODINGER/run extract_complex.py $j-out.maegz `sort -n -k 2 -t " " $j.csv | head -n 1 | awk -F " " '{print $1}' | sed "s/$j//g" | sed 's/[^0-9]*//g'` ;cd ..;done
