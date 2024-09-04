#==============================================Data================================

Fig2A is made by using the script plot_Fig2A.gnu. 

Plotted files in the main plot are "diffusion_prob_tau0.dat", "diffusion_prob_tau1.dat", "diffusion_prob_tau100.dat", and "diffusion_prob_tau_infinity.dat" using column 1 and (column 2)/4. First column in each data file is connection probability p and second column is effective diffusivity 4*D_eff.

Plotted files as the insets are "bond_time10_p0.2.dat", "bond_time10_p0.9.dat" with background lattice points from "grid_pos_10X10.dat" using column 1 and column 2.


#=============================================Codes===============================

"code_diffusion_tau0_4connection.f90" is used with an input file "bond_pos_10X10.dat" to generate the data for mean-squared displacement as "MSD_time.dat" for network dynamics
timescale τ=0. 

"code_diffusion_tau1_4connection.f90" is used with an input file "bond_pos_10X10.dat" to generate the data for mean-squared displacement as "MSD_time.dat" for network dynamics
timescale τ=1.
 
For τ=100, change the inputs rate_bond_add and rate_bond_remove in "code_diffusion_tau1_4connection.f90".

"linear_reg.f90" is used to get the effective diffusivity D_eff by getting a suitable fit to <r^2> (column 4) vs time (column 1) from data file "MSD_time.dat" as described in appendix Fig.6. The same codes are used to get the diffusivity for different connection probabilities by changing the inputs rate_bond_add and rate_bond_remove to get a desired p value. 

To get the network snapshots in the insets use "code_network_4connection.f90" with input file "centers_bond_10X10.dat".
