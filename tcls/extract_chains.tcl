mol load pdb lowestEstr
set a  [atomselect top "protein and chain A or protein and chain H"]
set b  [atomselect top "protein and chain B or protein and chain L"]
set c  [atomselect top "protein and chain C or protein and chain P"]
set d  [atomselect top "not protein and not water and not ions and resname ANE or resname AGA or resname BGA"]
$a writepdb proc.pdb
$b writepdb prob.pdb
$c writepdb proa.pdb
$d writepdb cara.pdb
exit

