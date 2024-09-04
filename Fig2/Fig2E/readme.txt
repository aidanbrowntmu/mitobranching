#==============================Data==========================
Fig2E is made by using the script plot_Fig2E.gnu. 

Plotted files in the main plot are diffusion_fusion10_4connection.dat, diffusion_fusion0.2_4connection.dat, and diffusion_fusion0.002_4connection.dat with solid curves, diffusion_fusion10_2connection.dat, diffusion_fusion0.2_2connection.dat, and diffusion_fusion0.002_2connection.dat with dashed curves using column 1 and (column 2)/4. First column is fusion fraction of dynamics λadd/(λadd+λremove) and the second column is effectivity diffusivity 4*D_eff.

#=========================Code=======================================
Code used for Fig.2C "code_diffusion_tau1_2connection.f90" is used to get the MSD vs time for degree-2 network. The same code is modified for degree-4 network by changing the parameter value "neighno=4" from "neighno=2". Inputs in the code, rate_bond_add and rate_bond_remove are varied to get the x-axis. "linear_reg.f90" is used to get the effective diffusivity. 

