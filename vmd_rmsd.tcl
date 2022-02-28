proc print_rmsd_through_time {{mol top}} {
	set sel [atomselect top "resname AGALN"]
	set end [lindex [$sel get residue] 0]
	set start [expr {$end - 10}] 
	set ligand [puts "residue $start to $end"]
	set reference [atomselect $mol \"$ligand\" frame 0]
	set compare [atomselect $mol \"$ligand\"]
	set num_steps [molinfo $mol get numframes]
	set filename "rmsd.txt"
	set fileID [open $filename "w"]
	for {set frame 0} {$frame < $num_steps} {incr frame} {
		$compare frame $frame
		set trans_mat [measure fit $compare $reference]
		$compare move $trans_mat
		set rmsd [measure rmsd $compare $reference]
		puts $fileID "$frame $rmsd"
		
	}
	close $fileID
}

print_rmsd_through_time
quit
