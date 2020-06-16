#!/usr/bin/env python
# coding: utf-8

# python script to calculate mean and std deviation of J-coupling values
#
# Author:  Suman Samantray
# Usage: python cal-J.py <jcoupl.dat(output file from extract-J.tcl>  <Number of residues in protein monomer> <final J-coupl output file>
# E.g. python cal-J.py jcoupl.dat 40 JC.dat


import numpy as np
import pandas as pd
import os as os
import sys

#Input the output file obtained from extract-J.tcl
inp=sys.argv[1]
#Count the number of residues
res=int(sys.argv[2])
#Enter the final output file name
ouf=sys.argv[3]

#load your location to file
data=np.loadtxt(inp, comments='#',usecols=(0,2))



## making groups of 40
Jcoup=data[:,1]
Jcoup=np.reshape(Jcoup,(-1,res))

## using pandas for better analysis 


df=pd.DataFrame(Jcoup)

df.index=np.arange(0,len(df)) ### frames
df.columns=np.arange(1,res+1) ## residues

## columns can also take residues names

mean=df.mean(axis=0) ## residue mean
## df.mean(axis=1) ## frame mean

std=df.std(axis=0) ## residue std
## df.std(axis=1) ## frame std

## making output

data=np.vstack((np.arange(1,res+1),mean.values,std.values)).T

with open(ouf,'w') as f :
    f.write('#Resid    Mean   STD\n')
    np.savetxt(f,data,fmt="%i" + "\t" + "%.3f"+ "\t" + "%.3f")


