set mol [mol new "DESRES-Trajectory_pnas2018b-Ab40-a99SBdisp-protein.mae" waitfor all]
mol addfile "traj1.dcd" molid $mol waitfor all

set outfile [open "rms1.dat" w]
set nf [molinfo $mol get numframes]
set frame0 [atomselect top "protein and backbone and noh" frame 0]
set sel [atomselect top "protein and backbone and noh"]
# rmsd calculation loop
for { set i 1 } { $i <= $nf } { incr i } {
$sel frame $i
$sel move [measure fit $sel $frame0]
puts $outfile "$i [measure rmsd $sel $frame0]"
}
close $outfile
exit

