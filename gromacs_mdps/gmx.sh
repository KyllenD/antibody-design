#!/bin/bash
PATH='/usr/local/gromacs/bin':$PATH

# _________ read inputs from the galaxy wrapper and define some variables ____________

lam=19
iter=$((lam+1))

mkdir MDP -p
mkdir data -p
mkdir traj -p

FREE_ENERGY=`pwd`
MDP=$FREE_ENERGY/MDP

set -e

for i in `seq 0 $lam`
 do
   cp enmin.00 em_steep_$i.mdp
   sed -i "s/%L%/$i/" em_steep_$i.mdp
   mv em_steep_$i.mdp ./MDP
   cp nvt.00 nvt_$i.mdp
   sed -i "s/%L%/$i/" nvt_$i.mdp
   mv nvt_$i.mdp ./MDP
   cp npt.00 npt_$i.mdp
   sed -i "s/%L%/$i/" npt_$i.mdp
   mv npt_$i.mdp ./MDP
   cp prod.00 md_$i.mdp
   sed -i "s/%L%/$i/" md_$i.mdp
   mv md_$i.mdp ./MDP
 done


for (( i=0; i<$iter; i++ ))
do
    LAMBDA=$i

    # A new directory will be created for each value of lambda

    mkdir Lambda_$LAMBDA -p
    cd Lambda_$LAMBDA

# _______ ENERGY MINIMIZATION STEEP _______

    echo "Starting minimization for lambda = $LAMBDA..."

    mkdir EM -p
    cd EM

    # Iterative calls to.pdbmpp and mdrun to run the simulations

    gmx grompp -f $MDP/em_steep_$LAMBDA.mdp -c $FREE_ENERGY/step3_input.gro -p $FREE_ENERGY/topol.top -o min$LAMBDA.tpr -maxwarn 150 -r $FREE_ENERGY/step3_input.gro -n $FREE_ENERGY/index.ndx

    gmx mdrun -v -stepout 1000 -s min$LAMBDA.tpr -nt "${GALAXY_SLOTS:-4}" -deffnm min$LAMBDA


    sleep 10


# _______ NVT EQUILIBRATION _______

    echo "Starting constant volume equilibration..."

    cd ../
    mkdir NVT -p
    cd NVT

    gmx grompp -f $MDP/nvt_$LAMBDA.mdp -c ../EM/min$LAMBDA.gro -p $FREE_ENERGY/topol.top -o nvt$LAMBDA.tpr -maxwarn 150 -r ../EM/min$LAMBDA.gro

    gmx mdrun -stepout 1000 -s nvt$LAMBDA.tpr -nt "${GALAXY_SLOTS:-4}" -deffnm nvt$LAMBDA


    echo "Constant volume equilibration complete."

    sleep 10

# _______ NPT EQUILIBRATION _______

    echo "Starting constant pressure equilibration..."

    cd ../
    mkdir NPT -p
    cd NPT

    gmx grompp -f $MDP/npt_$LAMBDA.mdp -c ../NVT/nvt$LAMBDA.gro -p $FREE_ENERGY/topol.top -t ../NVT/nvt$LAMBDA.cpt -o npt$LAMBDA.tpr -maxwarn 150 -r ../NVT/nvt$LAMBDA.gro

    gmx mdrun -stepout 1000 -s npt$LAMBDA.tpr -nt "${GALAXY_SLOTS:-4}" -deffnm npt$LAMBDA


    echo "Constant pressure equilibration complete."

    sleep 10

# ________ PRODUCTION MD ___________

    echo "Starting production MD simulation..."

    cd ../
    mkdir Production_MD -p
    cd Production_MD

    gmx grompp -f $MDP/md_$LAMBDA.mdp -c ../NPT/npt$LAMBDA.gro -p $FREE_ENERGY/topol.top -t ../NPT/npt$LAMBDA.cpt -o md$LAMBDA.tpr -maxwarn 150 -r ../NPT/npt$LAMBDA.gro

    gmx mdrun -stepout 1000 -s md$LAMBDA.tpr -nt "${GALAXY_SLOTS:-4}" -deffnm md$LAMBDA


    echo "Production MD complete."

    # End
    echo "Ending. Job completed for lambda = $LAMBDA"

    cd $FREE_ENERGY
done
mv *.mdp $MDP

cp Lambda_*/Production_MD/*.xvg data/
tar cf data.tar data/

cp Lambda_*/Production_MD/*.trr traj/
tar cf traj.tar traj/

done
