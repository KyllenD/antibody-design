set sel [atomselect top "resname AGALN"]
set end [lindex [$sel get residue] 0]
set start [expr {$end - 10}] 
set fileID [open "vmd_ligand_selection.txt" "w"]
puts $fileID "residue $start to $end"

#set mda_end [expr {$end + 1}]
#set mda_start [expr {$start + 1}]
#set file2ID [open "MDA_ligand_selection.txt" "w"]
#puts $file2ID "resnum $mda_start-$mda_end"

set file3ID [open "parmed_ligand_selection.txt" "w"]
puts $file3ID $start-$end
quit
