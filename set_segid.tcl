set sel [atomselect top "residue 229 to 239"]
$sel set segid "L"
[atomselect top all] writepdb step3_input.pdb
quit
