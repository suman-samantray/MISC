#set mol [mol new "monom.psf" waitfor all] 
#mol addfile "monom.psf" molid $mol waitfor all 
animate delete beg 0 end 0     
set feven [ open [lindex $argv 0] w ]
set fieven [ open [lindex $argv 1] w ]


set nf [ molinfo 0 get numframes ]
for {set i 0 } { $i < $nf } { incr i } { 
    animate goto $i

    for {set n 10 } { $n < 18 } { incr n 2} {

        set n1 [expr {$n+1}]
        set n2 [expr {$n+2}]

        set ps [[atomselect top "fragment 1 and name C1 O4 C4 C3 and residue $n1 to $n2"] get index]
        set tps [lrange $ps 1 4]
        set dps [measure dihed "$tps" ] 
        set ph [[atomselect top "fragment 1 and name O5 C1 O4 C4 and residue $n1 to $n2"] get index]
        set tph [lrange $ph 2 5]
        set dph [measure dihed "$tph" ] 

        puts $fieven "$i\t$n1\t$n2\t$dph\t$dps"
   	puts $feven "$dph\t$dps"
    }
}
close $fieven
close $feven
exit 
