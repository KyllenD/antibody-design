#!/bin/bash

$SCHRODINGER/utilities/structconvert step3_input.pdb complex.mae

$SCHRODINGER/run pv_convert.py -mode split_pv complex.mae

$SCHRODINGER/run poseviewer_interactions.py -csv complex-out_pv.mae

$SCHRODINGER/run calc_rest.py complex-out_pv.mae `head -n 2 complex-out_pv_interactions.csv | tail -1 | awk -F "," '{print $5'}| sed -e 's/([^)]*)//g'` `head -n 2 complex-out_pv_interactions.csv | tail -1 | awk -F "," '{print $7}'| sed -e 's/([^)]*)//g'` `head -n 2 complex-out_pv_interactions.csv | tail -1 | awk -F "," '{print $8}'| sed -e 's/([^)]*)//g'`
