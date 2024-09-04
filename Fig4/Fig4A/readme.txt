#==============================================Data================================

Fig4A is made by using the script plot_Fig4A.gnu. 

Plotted files in the main plot are with solid curves are "MFPT_a1_10_degree3.dat", "MFPT_a1_0.2_degree3.dat", and "MFPT_a1_0.002_degree3.dat".
Plotted files in the main plot are with dashed curves are "MFPT_a1_10_degree2.dat", "MFPT_a1_0.2_degree2.dat", and "MFPT_a1_0.002_degree2.dat".
 
#=============================================Codes===============================

"sukhorukovmodel_MFPT.m" is used to get the MFPT as "mean_time.txt" for a fixed "fusionrateperendside (a2) = 0.01" for degree-3 type networks (solid curves) and the same code with "fusionrateperendside (a2) = 0.0" is used to get the MFPT for degree-2 type network (dashed curves).
 "fissionrateperpair (b1)" is varied to get the xaxis. Different curves are for different values of "fusionrateperendpair (a1) = 10.0, 0.2, 0.002", respectively.
 Number of mitochondria in the system are "mitonum = 50"

