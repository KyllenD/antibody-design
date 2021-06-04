#!/bin/bash
j="${PWD##*/}";echo $j #gives current directory name
MAIN=`pwd`
ssh lengau.chpc.ac.za << EOF
cd lustre3p
mkdir gmx -p
mkdir gmx/$j -p
exit
EOF
scp -r $MAIN/gromacs/* kdilsook@scp.chpc.ac.za:/home/kdilsook/lustre3p/gmx/$j/
ssh lengau.chpc.ac.za << EOF
pushd /mnt/lustre3p/users/kdilsook/gmx/$j/complex
sed -i 's|chpcpath|/mnt/lustre3p/users/kdilsook/gmx/$j/complex|' mpi_gmx.pbs
#qsub mpi_gmx.pbs
pushd /mnt/lustre3p/users/kdilsook/gmx/$j/ligand
sed -i 's|chpcpath|/mnt/lustre3p/users/kdilsook/gmx/$j/ligand|' mpi_gmx.pbs
#qsub mpi_gmx.pbs
exit
EOF


