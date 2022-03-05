set sel [atomselect top "ligand"]
$sel set segid "L"
[atomselect top all] writepdb step3_input.pdb
quit
