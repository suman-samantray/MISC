#!/usr/bin/python

import numpy as np, matplotlib, matplotlib.colors, matplotlib.pyplot as plt, gzip
import matplotlib.gridspec
import matplotlib.patches as patches
import matplotlib.cm as cm
plt.rcParams.update({'figure.max_open_warning': 0})
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
#edit to accomodate more residues eg. 16-22 = 6
#rama=np.zeros((6,360,360))


inf=open(sys.argv[1],'r')
nRes=int(sys.argv[3])

rama=np.zeros((nRes,360,360))
#nPB=nRes-1
phi_new=[]
psi_new=[]
res_new=[]
#resname = np.loadtxt(sys.argv[1], usecols=2, dtype=np.str)

#while 1:
#    line=inf.readline()
#    #print line
#    if line[0]=='@':
#        continue
#    if line[0]=='#':
#        continue
#    break

norm=0
finished=False
while 1:
    #print norm
    for ires in range(nRes):
        line=inf.readline()[:-1]
        if line=='':
            finished=True
            break
        if len(line)==0:
            finished=True
            break
        norm+=1
        data=line.split()
        if len(data)<2:
            finished=True
            break
        (phi,psi)=(float(data[0]),float(data[1]))
        res=str(data[2])
        #print res
        res_new.append(res)
        psi_new.append(psi)
        phi_new.append(phi)

        iPhi=anint(phi)+180
        if iPhi==360:
            iPhi=0
        iPsi=anint(psi)+180
        if iPsi==360:
            iPsi=0
        rama[ires,iPsi,iPhi]+=1.0
        #print iPsi, iPhi
    if finished:
        break
x=np.reshape(phi_new,(-1,1))
y=np.reshape(psi_new,(-1,1))
z=np.reshape(res_new,(-1,1))
#print z[0::40]
#print y[0::40]
#c=[]
#c=z[0:40]
#for row in z:
#    print row[0]



for ires in range(nRes):
    ## normalise
    #fig=plt.figure(figsize=(12,8),constrained_layout=True)
    fig=plt.figure(figsize=(12,8))
    ax=plt.gca()
    #im = ax.imshow(rama[ires,:,:], cmap=cm.Spectral_r,extent=[-180,180,-180,180], vmin=0, vmax=25, alpha=1, interpolation='nearest')
    cs=ax.contourf([float(iPsi) for iPsi in range(-180,180)],[float(iPhi) for iPhi in range(-180,180)],rama[ires,:,:],[v*0.05 for v in range(0, int(31/0.05))], cmap=cm.afmhot_r, extend='both', antialiased=False)
    cb=plt.colorbar(cs, ticks= [0, 5, 10, 15, 20, 25, 30])
    cb.ax.set_yticklabels(['0','5','10','15','20','25','30'] )
    #cs=plt.scatter(x[ires::40], y[ires::40],  marker='o', c='red', s=4, alpha=1)
    

    ax.add_patch(patches.Rectangle((-122,-84),70,70,fill=False))
    ax.add_patch(patches.Rectangle((-150,95),80,80,fill=False))
    ax.add_patch(patches.Rectangle((14,52),70,70,fill=False))
    ax.add_patch(patches.Rectangle((-180,50),130,130,fill=False))
    ax.add_patch(patches.Rectangle((150,50),30,130,fill=False))
    ax.add_patch(patches.Rectangle((-180,-180),130,30,fill=False))
    #cb=plt.colorbar()
    font = {'family': 'serif', 'color': 'black','size': 24}
    #print (z[0])   
    ff=sys.argv[4]
    plt.title( (ff + "    " + str(z[ires][0])), fontdict=font)
    #plt.title(str(z[ires][0]), fontdict=font)
    ax.set_xlabel(r'$\phi$',labelpad= 1,fontdict=font)
    ax.set_xlim(-180,180)
    plt.xticks([-180,-90,0,90,180],['-180','-90','0','90','180'],size=16)
    ax.set_ylabel(r'$\psi$',labelpad= 1,fontdict=font)
    ax.set_ylim(-180,180)
    plt.yticks([-180,-90,0,90,180],['-180','-90','0','90','180'],size=16)
    
    #mng = plt.get_current_fig_manager()
    #mng.window.state('zoomed')
    #plt.plot([-180, 180], [0, 0], color="black")
    #plt.plot([0, 0], [-180, 180], color="black")
    #plt.locator_params(axis='both', tight= True, nbins=6)

    #cb=plt.colorbar()
    #print ires
    #fig.tight_layout()
    savefile=sys.argv[2] + str(ires+1)
    fig.savefig(savefile)
    #plt.show()
