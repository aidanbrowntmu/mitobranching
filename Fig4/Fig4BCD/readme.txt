#==============================================Data================================

Fig4B, Fig4C, Fig.4D are made by using the script plot_Fig4B.gnu, plot_Fig4C.gnu, and plot_Fig4D.gnu, respectively. 

Fig4B: Plotted files are "network_fusion10_degree3.dat", "network_fusion0.2_degree3.dat", and "network_fusion0.002_degree3.dat" using column 1 and (column 5)*3 to get Fig.4B.

Fig4C: Plotted files for the solid curves (degree-3 network) are "network_fusion10_degree3.dat", "network_fusion0.2_degree3.dat", and "network_fusion0.002_degree3.dat" using column 1 and (column 3)*2 and for the dashed curves (degree-2 network) are "network_fusion10_degree2.dat", "network_fusion0.2_degree2.dat", and "network_fusion0.002_degree2.dat" using column 1 and (column 3)*2 to get Fig.4C

Fig4D: Plotted files for the solid curves (degree-3 network) are "network_fusion10_degree3.dat", "network_fusion0.2_degree3.dat", and "network_fusion0.002_degree3.dat" using column 1 and column 2 and  for the dashed curves (degree-2 network) are "network_fusion10_degree2.dat", "network_fusion0.2_degree2.dat", and "network_fusion0.002_degree2.dat" using column 1 and column 2 to get Fig.4D


 
#=============================================Codes===============================

"sukhorukovmodel_network.m" is used to get the number of degree-3, degree-2 and degree-1 nodes stored in file "network.txt".
For degree-3 type network "fusionrateperendside = 0.01" and for degree-2 type network "fusionrateperendside = 0.0".

