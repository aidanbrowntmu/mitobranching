#=====================Data===============================
Fig2F is made by using the script plot_Fig2F.gnu. 

Plotted files in the main plot are MFPT_fusion10_4connection.dat, MFPT_fusion0.2_4connection.dat, and MFPT_fusion0.002_4connection.dat with solid curves, MFPT_fusion10_4connection.dat, MFPT_fusion0.2_4connection.dat, and MFPT_fusion0.002_4connection.dat with dashed curves using column 1 and column 2. First column is fusion fraction of dynamics λadd/(λadd+λremove) and the second column is MFPT.

#=======================Code===========================
Code used in Fig.2D "code_MFPT_2connection.f90" is used to get the MFPT vs realizations for degree-2 network. The same code is modified for degree-4 network by changing the parameter value "neighno = 4" from "neighno = 2". Inputs parameters in the code, rate_bond_add and rate_bond_remove are varied to get the x-axis.

