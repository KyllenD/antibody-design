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
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/tcls/extract_chains.tcl
sed -i "s/lowestEstr/`echo $j-out_pose_*.pdb`/" extract_chains.tcl
vmd -dispdev text -e extract_chains.tcl

#convert these pdb chains into charmm crd files
#prereq pdb2crd_a.inp, pdb2crd_b.inp, pdb2crd_c.inp, pdb2crd_cara.inp

wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/pdb2crd_a.inp
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/pdb2crd_b.inp
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/pdb2crd_c.inp
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/pdb2crd_cara.inp

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
mv *.tcl ./charmm

#copy toppar folder and toppar.str to charmm folder
#wget -nv *link to toppar.str and toppar folder*
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar.str
mkdir toppar
cd toppar
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/par_all36_carb.prm
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/par_all36_cgenff.prm
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/par_all36_lipid.prm
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/par_all36m_prot.prm
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/par_all36_na.prm
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/par_interface.prm
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/tip216.crd
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/top_all36_carb.rtf
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/top_all36_cgenff.rtf
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/top_all36_lipid.rtf
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/top_all36_na.rtf
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/top_all36_prot.rtf
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/top_interface.rtf
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_carb_glycolipid.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_carb_glycopeptide.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_carb_imlab.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_label_fluorophore.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_label_spin.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_archaeal.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_bacterial.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_cardiolipin.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_cholesterol.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_dag.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_detergent.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_ether.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_hmmm.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_inositol.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_lnp.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_lps.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_miscellaneous.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_model.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_mycobacterial.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_prot.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_sphingo.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_tag.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_lipid_yeast.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_na_nad_ppi.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_nanolig_patch.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_nano_lig.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_na_rna_modified.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_polymer_solvent.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_prot_arg0.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_prot_c36m_d_aminoacids.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_prot_fluoro_alkanes.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_prot_heme.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_prot_modify_res.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_prot_na_combined.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_prot_retinol.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_synthetic_polymer_patch.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_all36_synthetic_polymer.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_dum_noble_gases.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_ions_won.str
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/toppar/toppar_water_ions.str
cd ..
mv toppar ./charmm
mv toppar.str ./charmm
cd charmm
# include glycan.str - this will change for other ligands

if [ `head -4 cara.crd | tail -1 | grep -Eo '[0-9]{1,}'` -eq 28 ] ;then wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step1_pdbreader_glycan_Tn.str;mv step1_pdbreader_glycan_Tn.str step1_pdbreader_glycan.str;fi

if [ `head -4 cara.crd | tail -1 | grep -Eo '[0-9]{1,}'` -eq 64 ] ;then wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step1_pdbreader_glycan_STn.str;mv step1_pdbreader_glycan_STn.str step1_pdbreader_glycan.str;fi

if [ `head -4 cara.crd | tail -1 | grep -Eo '[0-9]{1,}'` -eq 121 ] ;then wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step1_pdbreader_glycan_DiST.str;mv step1_pdbreader_glycan_DiST.str step1_pdbreader_glycan.str;fi

if [ `head -4 cara.crd | tail -1 | grep -Eo '[0-9]{1,}'` -eq 49 ] ;then wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step1_pdbreader_glycan_T.str;mv step1_pdbreader_glycan_T.str step1_pdbreader_glycan.str;fi

a=$(grep -F "TITLE" $j-out_pose_*.pdb | sed -e 's/TITLE//' | sed -e 's/ligand//' |sed -e 's/^ *//g'); if [ `head -4 cara.crd | tail -1 | grep -Eo '[0-9]{1,}'` -eq 85 -a ${a} == "6ST" ];then wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step1_pdbreader_glycan_6ST.str; mv step1_pdbreader_glycan_6ST.str step1_pdbreader_glycan.str; else wget https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step1_pdbreader_glycan_3ST.str; mv step1_pdbreader_glycan_3ST.str step1_pdbreader_glycan.str;fi

# include step1.inp file
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step1_pdbreader.inp
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step1_pdbreader_ligand.inp
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step2.1_waterbox.inp
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step2.2_ions.inp
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step2_solvator.inp
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/step3_pbcsetup.inp
#run step1 of charmm gui

charmm -i step1_pdbreader.inp -o step1_pdbreader.out

#ensure crystal_image.str present
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/crystal_image.str
charmm -i step2.1_waterbox.inp -o step2.1_waterbox.out
charmm -i step2.2_ions.inp -o step2.2_ions.out
charmm -i step2_solvator.inp -o step2_solvator.out

#ensure checkff.py is present
#change python to python command system recognizes
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/charmm_inps/checkfft.py
#sed -i 's/python/python3/' step3_pbcsetup.inp
charmm -i step3_pbcsetup.inp -o step3_pbcsetup.out

#generate gromacs inputs

mkdir gromacs

#get script to convert .psf to .top

wget -nv https://raw.githubusercontent.com/xiki-tempula/gmx_lipid17.ff/cf76996e56dc135778d09a408f40aa663be53754/g_charmm4lipid17/charmm-gui_gromacs/psf2itp.py

#run conversion from .psf to .top

python3 psf2itp.py toppar.str step3_pbcsetup.psf

#generate .gro and move to folder

gmx editconf -f step3_pbcsetup.pdb -o step3_input.gro -box `head -3 step3_pbcsetup.str | tail -1 | grep -Eo '[0-9]{1,}'` `head -3 step3_pbcsetup.str | tail -1 | grep -Eo '[0-9]{1,}'` `head -3 step3_pbcsetup.str | tail -1 | grep -Eo '[0-9]{1,}'`
mv step3_input.gro ./gromacs

#copy gmx files needed for sims i.e .00 scripts and .sh file

cd gromacs

wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/gromacs_mdps/enmin.00
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/gromacs_mdps/gmx.sh
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/gromacs_mdps/npt.00
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/gromacs_mdps/nvt.00
wget -nv https://raw.githubusercontent.com/KyllenD/antibody-design/main/gromacs_mdps/prod.00

mkdir complex
mv * ./complex
cd ..
mv gromacs ..
mkdir comp
mv * comp
mkdir lig
cd lig
mv ../comp/*.inp .
mv ../comp/toppar .
mv ../comp/*.str .
mv ../comp/checkfft.py .
mv ../comp/*.crd .
mv ../comp/psf2itp.py .

charmm -i step1_pdbreader_ligand.inp -o step1_pdbreader_ligand.out
charmm -i step2.1_waterbox.inp -o step2.1_waterbox.out
charmm -i step2.2_ions.inp -o step2.2_ions.out
charmm -i step2_solvator.inp -o step2_solvator.out
charmm -i step3_pbcsetup.inp -o step3_pbcsetup.out
mkdir gromacs
python3 psf2itp.py toppar.str step3_pbcsetup.psf

gmx editconf -f step3_pbcsetup.pdb -o step3_input.gro -box `head -3 step3_pbcsetup.str | tail -1 | grep -Eo '[0-9]{1,}'` `head -3 step3_pbcsetup.str | tail -1 | grep -Eo '[0-9]{1,}'` `head -3 step3_pbcsetup.str | tail -1 | grep -Eo '[0-9]{1,}'`
mv step3_input.gro ./gromacs
cp ../../gromacs/complex/*.00 ./gromacs
cp ../../gromacs/complex/*.sh ./gromacs
mv gromacs ligand
