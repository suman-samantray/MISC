#!/bin/bash

#If multiple trajectories files(.dcd) for one structure file (.mae) are present, use the commands below otherwise comment out.
file_list="protein0001 protein0002 protein0003"
for x in `echo $file_list`; do
    echo $x
    vmd -dispdev text -e extract-J.tcl -args  *.mae  ${x}.dcd jcoupl_${x}.dat
    python cal-J.py jcoupl_${x}.dat 40 JC_${x}.dat & disown

done
