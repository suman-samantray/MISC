# VMD TCL script to print Frame number and j-coupling constants as a f() of phi values
#
# Author:  Suman Samantray
# Usage: vmd -dispdev text -e extract-J.tcl  -args  <reference structure file>  <trajectory file>  <output file>
# E.g. vmd -dispdev text -e extract-J.tcl -args  protein.mae  protein0001.dcd  jcoupl.dat

#Load reference protein structure file
set ref [lindex $argv 0]
#Load the trajectory file related to the protein structure
set traj [lindex $argv 1]
#Write the J-coupling values to the output file
set output [lindex $argv 2]


set mol [mol new $ref waitfor all]
mol addfile $traj molid $mol waitfor all    
set fp [ open $output w ]

#Select the C-alpha atoms from the protein topology
set sel [ atomselect $mol "alpha" ]
#Select the frames 
set n [ molinfo $mol get numframes ]

#loop through the frames
for {set i 0 } { $i < $n } { incr i } {
    $sel frame $i
    $sel update
    puts $fp "\# frame: $i"

    set a [ $sel num ]
    for {set j 0 } { $j < $a } { incr j } {	
	set PHI [lindex [$sel get {phi}] $j]
    set R [expr {$PHI-60}]
    #Convert degrees to radians
	set RAD [expr {$R*0.0174533}]
	#New J-coupling constants values for A B C
    set A 7.97
    set B -1.26
    set C 0.63
    #Calculate the Jcoupling value using Karplus equation
	set J [expr {$A*cos($RAD)*cos($RAD) + $B*cos($RAD) + $C}]	
    puts $fp "[expr $j + 1] [lindex [$sel get {resname}] $j] $J"
    }
}

$sel delete
close $fp 
exit
