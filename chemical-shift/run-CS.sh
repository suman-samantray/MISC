#!/bin/bash

#If multiple trajectories files(.dcd) for one structure file (.mae) are present, use the commands below otherwise comment out.
file_list="protein0001 protein0002 protein0003"
for x in `echo $file_list`; do
    echo $x
    mkdir ${x}
    cd ${x}
    vmd -dispdev text -e extract-fr.tcl -args  *.mae  ${x}.dcd
    #Activate the sparta command
    /home/xxx/Desktop/SPARTA+/sparta+ -in frame*.pdb
    #Column:'5' denotes the primary chemical shifts and Column:'4' denotes the secondary chemical shifts
    awk '{a[FNR]+=$5; b[FNR]++; c[FNR]+=$5*$5 }END{for(i=1;i<=FNR;i++)print a[i]/b[i], "\t", sqrt((c[i]-a[i]*a[i]/b[i])/(b[i]-1)) ;}' frame*_pred.tab > chemshift.dat
    
    
    cp chemshift.dat chemshift_bck.dat
    cp frame0_pred.tab frame0_pred_bck.tab

	#Check line number in frame0_pred.tab, ideally line 27 is the last line of remark. 
    sed '1,27d' chemshift_bck.dat > chemshift_n.dat
	sed '1,27d' frame0_pred_bck.tab > index.dat
	paste index.dat chemshift_n.dat | awk '{print $1 "  " $2 "  " $3 "  " $10 "  " $11}' > final-chemshift.dat
	
	#Backbone atoms
	atoms_list="HN N CA HA CB C"
	for a in `echo $atom_list`; do
		awk '$3 == "'$a'"  {print $0}' final-chemshift.dat  > ${a}_CS.dat
	done
	#rm index.dat chemshift_n.dat chemshift_bck.dat chemshift.dat
	cd ..
done
