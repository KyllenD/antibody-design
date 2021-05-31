#!/bin/bash
#generates docking job that can run on chpc
for j in *; do cd $j; sed -i '1 i\' $j.sh; sed -i '1 i\module add chpc/schrodinger/2020-3' $j.sh; sed -i '1 i\module purge' $j.sh; sed -i '$s/$/ -QARG "-P CBBI1063 -l walltime=12:00:00"/' $j.sh; chmod +x $j.sh; cd ..; done
#submits jobs to chpc
for j in *; do cd $j; if [[ ! -f "$j-out.maegz" ]]; then ./$j.sh;sleep 30m ;fi; while grep -Fq "Piper Error" $j.log; do ./$j.sh; sleep 30m; done; if [[ -f "$j-out.maegz" ]]; then cd ..;fi;done
