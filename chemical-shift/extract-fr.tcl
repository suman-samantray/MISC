# VMD TCL script to extract pdb files from mae and dcd file formats.
#
# Author:  Suman Samantray
# Usage: vmd -dispdev text -e extract-fr.tcl  -args  <reference structure file>  <trajectory file>  
# E.g. vmd -dispdev text -e extract-fr.tcl -args  protein.mae  protein0001.dcd

set ref [lindex $argv 0]
set traj [lindex $argv 1]


set mol [mol new $ref waitfor all]
mol addfile $traj molid $mol waitfor all
    
set nf [molinfo top get numframes] 

for { set i 0 } {$i < $nf } { incr i } { 
	set sel [atomselect top protein frame $i] 
    $sel writepdb frame$i.pdb 
} 
exit