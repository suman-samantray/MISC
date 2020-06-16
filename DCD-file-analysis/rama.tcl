#set mol [mol new "monom.psf" waitfor all] 
#mol addfile "monom.psf" molid $mol waitfor all 
package require pbctools
animate delete beg 0 end 0     
set fp [ open [lindex $argv 0] w ] 
set fs [ open [lindex $argv 1] w ] 
#set sel [ atomselect $mol "alpha" ]
set sel [atomselect 0 "alpha" frame 0]
#set n [ molinfo $mol get numframes ] 
set n [ molinfo 0 get numframes ]
for {set i 0 } { $i < $n } { incr i } { 
    animate goto $i
    $sel frame $i 
    $sel update 
    puts $fs "\# frame: $i" 
    set a [ $sel num ] 
    for {set j 0 } { $j < $a } { incr j } { 
        #puts $fp "[expr $j + 1] [lindex [$sel get {phi psi resname resid}] $j]" 
        puts $fs "[expr $j + 1] [lindex [$sel get {phi psi resname}] $j]-[lindex [ $sel get resid ] $j]"
        puts $fp "[lindex [$sel get {phi psi resname}] $j]-[expr $j + 1]"
    } 
} 
$sel delete 
close $fs
close $fp 
#quit
exit
