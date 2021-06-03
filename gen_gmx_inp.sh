#!/bin/bash
PATH='/home/kyllen/charmm/':$PATH
PATH='/usr/local/gromacs/bin':$PATH

#TO BE RUN IN PROT-PROT-DOCKING_# DIRECTORY 
#This script generates gromacs input from lowest E strcuture pdb using vmd,charmm, gmx and python3

j="${PWD##*/}";echo $j #gives current directory name

#Ensure HIS residues are renamed HSD
sed -i 's/HIS/HSD/' $j-out_pose_*.pdb

#first use vmd to split pdb into chains
#prereq extract_chains.tcl
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/tcls/extract_chains.tcl
sed -i "s/lowestEstr/`echo $j-out_pose_*.pdb`/" extract_chains.tcl
vmd -dispdev text -e extract_chains.tcl

#convert these pdb chains into charmm crd files
#prereq pdb2crd_a.inp, pdb2crd_b.inp, pdb2crd_c.inp, pdb2crd_cara.inp

wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/pdb2crd_a.inp
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/pdb2crd_b.inp
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/pdb2crd_c.inp
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/pdb2crd_cara.inp

charmm -i pdb2crd_a.inp -o pdb2crd_a.out
charmm -i pdb2crd_b.inp -o pdb2crd_b.out
charmm -i pdb2crd_c.inp -o pdb2crd_c.out
charmm -i pdb2crd_cara.inp -o pdb2crd_cara.out

#move crds to a folder 

mkdir charmm -p
mv *.crd ./charmm
mv *.out ./charmm
mv *.inp ./charmm
mv *.pdb ./charmm

#copy toppar folder and toppar.str to charmm folder
#wget *link to toppar.str and toppar folder*
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar.str
mkdir toppar 
cd toppar 
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/par_all36_carb.prm
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/par_all36_cgenff.prm
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/par_all36_lipid.prm
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/par_all36m_prot.prm
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/par_all36_na.prm
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/par_interface.prm
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/tip216.crd
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/top_all36_carb.rtf
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/top_all36_cgenff.rtf
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/top_all36_lipid.rtf
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/top_all36_na.rtf
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/top_all36_prot.rtf
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/top_interface.rtf
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_carb_glycolipid.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_carb_glycopeptide.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_carb_imlab.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_label_fluorophore.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_label_spin.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_archaeal.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_bacterial.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_cardiolipin.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_cholesterol.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_dag.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_detergent.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_ether.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_hmmm.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_inositol.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_lnp.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_lps.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_miscellaneous.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_model.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_mycobacterial.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_prot.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_sphingo.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_tag.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_yeast.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_na_nad_ppi.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_nanolig_patch.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_nano_lig.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_na_rna_modified.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_polymer_solvent.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_prot_arg0.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_prot_c36m_d_aminoacids.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_prot_fluoro_alkanes.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_prot_heme.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_prot_modify_res.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_prot_na_combined.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_prot_retinol.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_synthetic_polymer_patch.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_synthetic_polymer.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_dum_noble_gases.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_ions_won.str
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_water_ions.str
cd ..
mv toppar ./charmm
mv toppar.str ./charmm
cd charmm
# include glycan.str - this will change for other ligands

if [ `head -4 cara.crd | tail -1 | grep -Eo '[0-9]{1,}'` -eq 28 ] ;then wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step1_pdbreader_glycan_Tn.str;mv step1_pdbreader_glycan_Tn.str step1_pdbreader_glycan.str;fi 

if [ `head -4 cara.crd | tail -1 | grep -Eo '[0-9]{1,}'` -eq 64 ] ;then wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step1_pdbreader_glycan_STn.str;mv step1_pdbreader_glycan_STn.str step1_pdbreader_glycan.str;fi

if [ `head -4 cara.crd | tail -1 | grep -Eo '[0-9]{1,}'` -eq 121 ] ;then wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step1_pdbreader_glycan_DiST.str;mv step1_pdbreader_glycan_DiST.str step1_pdbreader_glycan.str;fi

if [ `head -4 cara.crd | tail -1 | grep -Eo '[0-9]{1,}'` -eq 49 ] ;then wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step1_pdbreader_glycan_T.str;mv step1_pdbreader_glycan_T.str step1_pdbreader_glycan.str;fi

a=$(grep -F "TITLE" prot-prot-docking_137-out_pose_6.pdb | sed -e 's/TITLE//' | sed -e 's/ligand//' |sed -e 's/^ *//g'); if [ `head -4 cara.crd | tail -1 | grep -Eo '[0-9]{1,}'` -eq 85 -a ${a} == "6ST" ];then wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step1_pdbreader_glycan_6ST.str; mv step1_pdbreader_glycan_6ST.str step1_pdbreader_glycan.str; else wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step1_pdbreader_glycan_3ST.str; mv step1_pdbreader_glycan_3ST.str step1_pdbreader_glycan.str;fi

# include step1.inp file
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step1_pdbreader.inp
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step2.1_waterbox.inp
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step2.2_ions.inp
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step2_solvator.inp
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step3_pbcsetup.inp
#run step1 of charmm gui

cd charmm
charmm -i step1_pdbreader.inp -o step1_pdbreader.out

#ensure crystal_image.str present
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/crystal_image.str
charmm -i step2.1_waterbox.inp -o step2.1_waterbox.out
charmm -i step2.2_ions.inp -o step2.2_ions.out
charmm -i step2_solvator.inp -o step2_solvator.out

#ensure checkff.py is present 
#change python to python command system recognizes
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/checkfft.py
#sed -i 's/python/python3/' step3_pbcsetup.inp
charmm -i step3_pbcsetup.inp -o step3_pbcsetup.out

#generate gromacs inputs

mkdir gromacs

#get script to convert .psf to .top

wget https://raw.githubusercontent.com/xiki-tempula/gmx_lipid17.ff/cf76996e56dc135778d09a408f40aa663be53754/g_charmm4lipid17/charmm-gui_gromacs/psf2itp.py 

#run conversion from .psf to .top

python3 psf2itp.py toppar.str step3_pbcsetup.psf

#generate .gro and move to folder

gmx editconf -f step3_pbcsetup.pdb -o step3_input.gro -box `head -3 step3_pbcsetup.str | tail -1 | grep -Eo '[0-9]{1,}'` `head -3 step3_pbcsetup.str | tail -1 | grep -Eo '[0-9]{1,}'` `head -3 step3_pbcsetup.str | tail -1 | grep -Eo '[0-9]{1,}'`
mv step3_input.gro ./gromacs

#copy gmx files needed for sims i.e .00 scripts and .sh file

cd gromacs

wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/gromacs_mdps/enmin.00
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/gromacs_mdps/gmx.sh
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/gromacs_mdps/npt.00
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/gromacs_mdps/nvt.00
wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/gromacs_mdps/prod.00
#./gmx.sh
