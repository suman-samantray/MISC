#set mol [mol new "monom.psf" waitfor all] 
#mol addfile "monom.psf" molid $mol waitfor all 
animate delete beg 0 end 0     
set fp [ open [lindex $argv 0] w ] 
set sel [atomselect top "protein"] 
set n [ molinfo 0 get numframes ]
for {set i 0 } { $i < $n } { incr i } { 
    animate goto $i
    $sel frame $i 
    puts $fp "[expr [measure bond {2 583}]/10]" 
    #puts $fp "[measure bond {2 583} frame $i]" 
} 
$sel delete 
close $fp 
exit