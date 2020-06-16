set mol [mol new "DESRES-Trajectory_pnas2018b-Ab40-a99SBdisp-protein.mae" waitfor all]
mol addfile "traj1.dcd" molid $mol waitfor all
    
set fp [ open "phi-1.dat" w ]
set sel [ atomselect $mol "alpha" ]
set n [ molinfo $mol get numframes ]

for {set i 0 } { $i < $n } { incr i } {
    $sel frame $i
    $sel update
    puts $fp "\# frame: $i"

    set a [ $sel num ]
    for {set j 0 } { $j < $a } { incr j } {	
	set PHI [lindex [$sel get {phi}] $j]
    	set R [expr {$PHI-60}]
	set RAD [expr {$PHI*0.0174533}]
	set RAD1 [expr {$R*0.0174533}]
	set A 7.97
    	set B -1.26
    	set C 0.63
    	set J [expr {$A*cos($RAD)*cos($RAD) + $B*cos($RAD) + $C}]
	set J1 [expr {$A*cos($RAD1)*cos($RAD1) + $B*cos($RAD1) + $C}]	
        puts $fp "[expr $j + 1] [lindex [$sel get {resname}] $j] $J1"
    }
}

$sel delete
close $fp 
