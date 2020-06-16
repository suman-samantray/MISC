#set mol [mol new "monom.psf" waitfor all] 
#mol addfile "monom.psf" molid $mol waitfor all 
animate delete beg 0 end 0     
set fodd [ open [lindex $argv 0] w ]
set fiodd [ open [lindex $argv 1] w ]


set nf [ molinfo 0 get numframes ]
for {set i 0 } { $i < $nf } { incr i } { 
    animate goto $i

    for {set n 0 } { $n < 10 } { incr n 2} {
        set n1 [expr {$n+1}]

        set psi3 [[atomselect top "fragment 0 and name C1 O3 C3 C2 and residue $n to $n1"] get index]
        set tpsi3 [lrange $psi3 1 4]
        set dpsi3 [measure dihed "$tpsi3" ] 
        set phi3 [[atomselect top "fragment 0 and name O5 C1 O3 C3 and residue $n to $n1"] get index]
        set tphi3 [lrange $phi3 2 5]
        set dphi3 [measure dihed "$tphi3" ] 

        puts $fiodd "$i\t$n\t$n1\t$dphi3\t$dpsi3"
   	    puts $fodd "$dphi3\t$dpsi3"
    }
}
close $fiodd
close $fodd
exit 
