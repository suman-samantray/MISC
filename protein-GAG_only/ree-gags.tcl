#set mol [mol new "monom.psf" waitfor all] 
#mol addfile "monom.psf" molid $mol waitfor all 
animate delete beg 0 end 0
set f0 [ open [lindex $argv 0] w ]
set f1 [ open [lindex $argv 1] w ]
set fall [ open [lindex $argv 2] w ]
#set sel [atomselect top all]
set nf [ molinfo 0 get numframes ]
for {set i 0 } { $i < $nf } { incr i } {
    animate goto $i
    #$sel frame $i

    set a0 [[atomselect top "fragment 0 and name C1 and residue 0"] get index]
    set b0 [[atomselect top "fragment 0 and name C4 and residue 9"] get index]
    set a1 [[atomselect top "fragment 1 and name C1 and residue 10"] get index]
    set b1 [[atomselect top "fragment 1 and name C4 and residue 19"] get index]
    
    set fi0 "[expr [measure bond "$a0 $b0"]/10]"
    puts $f0 "$i\t$fi0"

    set fi1 "[expr [measure bond "$a1 $b1"]/10]"
    puts $f1 "$i\t$fi1"

    puts $fall "$i\t$fi0\t$fi1" 
}
#$sel delete
close $f0
close $f1
close $fall
exit
