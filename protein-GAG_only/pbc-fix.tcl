# Usage: vmd -dispdev text Ab25-35-6monomers-500ns-prot.gro Ab25-35-6monomers-500ns-prot.xtc -e PBC-fixAB42-D3.tcl -args output

# call the pbc tools plugin
package require pbctools

# wrap the lipid bilayer around the center of mass of the protein
#pbc wrap -all -sel "lipid" -compound res -center com -centersel "protein"

# now, wrap the solvent & ions around the wrapped complex of protein and lipids
#pbc wrap -all -sel "water or ions" -compound res -center com -centersel "protein or lipid"



# Removes the first frame which is the .gro or .pdb file 
animate delete beg 0 end 0

# Name of output file
set output [lindex $argv 0]

# center each frame of the trajectory so that is it aligned at the origin (0,0,0)
set nf [molinfo top get numframes]
set all [atomselect top all]
for {set i 0} {$i < $nf} {incr i 1} {
    animate goto $i
    $all frame $i
    pbc join fragment -now

	#set w_com [vecsub {0.0 0.0 0.0} [measure center $all]] 
	#set w_com [vecsub {0.0 0.0 0.0} [measure center $all weight mass]
	#$all moveby $w_com 

    $all moveby [vecinvert [measure center $all weight mass]]
    pbc box -center centerofmass
    pbc box -center bb
}


# Write new trajectory
animate write trr $output.trr waitfor all
exit
