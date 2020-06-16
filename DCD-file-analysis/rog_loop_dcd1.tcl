mol new /u2/data/suman/abeta/deshaw/DEshaw-ab40/a99SBdisp/pnas2018b-Ab40-a99SBdisp-protein/DESRES-Trajectory_pnas2018b-Ab40-a99SBdisp-protein.mae
mol addfile /u2/data/suman/abeta/deshaw/DEshaw-ab40/a99SBdisp/pnas2018b-Ab40-a99SBdisp-protein/traj1.dcd first 0 last -1 waitfor all

# load necessary tcl functions  (Ref : http://www.ks.uiuc.edu/Research/vmd/vmd-1.7.1/ug/node182.html )
source gyr_radius.tcl
source center_of_mass.tcl

set outfile [open radius_of_gyration1.dat w]
puts $outfile "i rad_of_gyr"
set nf [molinfo top get numframes] 
set i 0

set prot [atomselect top "protein"]
while {$i < $nf} {

    $prot frame $i
    $prot update

    set i [expr {$i + 1}]
    set rog [gyr_radius $prot]

    puts $outfile "$i $rog"

} 

close $outfile
exit
