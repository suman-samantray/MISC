#!/usr/bin/python

import numpy as np, matplotlib, matplotlib.colors, matplotlib.pyplot as plt, gzip
import matplotlib.gridspec
import matplotlib.patches as patches

import sys

def anint(x):
    x1=np.floor(x)
    x2=x1+1.0
    if (x2-x)<(x-x1):
        return int(x2)
    else:
        return int(x1)

## regions for SS types
phi_alpha_1=-122
phi_alpha_2=-52
psi_alpha_1=-84
psi_alpha_2=-14

rama=np.zeros((360,360))

inf=open(sys.argv[1],'r')
#infr=np.loadtxt('rama_traj1.txt', delimiter=None, dtype=np.ndarray)
nRes=int(sys.argv[3])

phi_new=[]
psi_new=[]

#while 1:
#    line=inf.readline()
#    if line[0]=='@':
#        continue
#    if line[0]=='#':
#        continue
#    break
norm=0
while 1:
    line=inf.readline()[:-1]
    if line==' ':
        break
    if len(line)==0:
        break
    norm+=1
    data=line.split()
    if len(data)<2:
        break
    (phi,psi)=(float(data[0]),float(data[1]))
    #print phi, psi
    psi_new.append(psi)
    phi_new.append(phi)

    iPhi=anint(phi)+180
    if iPhi==360:
        iPhi=0
    iPsi=anint(psi)+180
    if iPsi==360:
        iPsi=0
    rama[iPsi,iPhi]+=1.0
x=np.reshape(phi_new,(-1,1))
y=np.reshape(psi_new,(-1,1))
#print phi_new[39]


## normalise
fig=plt.figure(figsize=(8,8))
#cs=plt.contourf([float(iPsi) for iPsi in range(-180,180)],[float(iPhi) for iPhi in range(-180,180)],rama,[0,10,20,30,40,50,100], cmap='binary')
cs=plt.scatter(x, y, marker='o', c='red', s=4, alpha=1)
ca=plt.gca()
ca.add_patch(patches.Rectangle((-122,-84),70,70,fill=False))
ca.add_patch(patches.Rectangle((-150,95),80,80,fill=False))
ca.add_patch(patches.Rectangle((14,52),70,70,fill=False))
ca.add_patch(patches.Rectangle((-180,50),130,130,fill=False))
ca.add_patch(patches.Rectangle((150,50),30,130,fill=False))
ca.add_patch(patches.Rectangle((-180,-180),130,30,fill=False))
#cb=plt.colorbar()
font = {'family': 'serif', 'color': 'black','size': 24}

plt.title('Abeta40', fontdict=font)
plt.xlabel(r'$\phi$',labelpad= 1,fontdict=font)
plt.xlim(-180,180)
plt.xticks([-180,-90,0,90,180],['-180','-90','0','90','180'],size=16)
plt.ylabel(r'$\psi$',labelpad= 1,fontdict=font)
plt.ylim(-180,180)
plt.yticks([-180,-90,0,90,180],['-180','-90','0','90','180'],size=16)
#mng = plt.get_current_fig_manager()
#mng.window.state('zoomed')
plt.plot([-180, 180], [0, 0], color="black")
plt.plot([0, 0], [-180, 180], color="black")
plt.locator_params(axis='both', tight= True, nbins=6)

#cb=plt.colorbar()
#print ires
plt.axis('tight')

fig.savefig(sys.argv[2])
#plt.show()
