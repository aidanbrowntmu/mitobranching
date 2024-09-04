#======================================Data=============================
Fig2B is made by using the script plot_Fig2B.gnu.

In the main plot MFPT_prob_tau0.dat, MFPT_prob_tau1.dat, and MFPT_prob_tau100.dat is plotted using first and second column. First column is connection probability p and the second column is mean first passage time (MFPT).

In the inset plot, search_diffusion_tau0.dat, search_diffusion_tau1.dat, and search_diffusion_tau100.dat is plotted using (column 2)/4 and column 3. Column 1 is the connection probability p. Column 2 is effective diffusivity 4*D_eff and column 3 is MFPT.


#=================================Codes=================================
For τ=0 "code_MFPT_tau0_4connection.f90" is used with an input file "bond_pos_10X10.dat" to generate MFPT(column 2) for each realization (column 1) as "xy_time_target.dat". Final MFPT is the averaged value of column 2 over the realizations. Same code is used to get the MFPT for other connection probabilities by changing values of rate_bond_add and rate_bond_remove in the code. 

For τ=1 "code_MFPT_tau1_4connection.f90" is used with an input file "bond_pos_10X10.dat" to generate MFPT(column 2) for each realization (column 1) as "xy_time_target.dat". Final MFPT is the averaged value of column 2 over the realizations. Same code is used to get the MFPT for other connection probabilities by changing values of rate_bond_add and rate_bond_remove in the code. 

For τ=100, follow the same code used for τ=1 with changed values of rate_bond_add and rate_bond_remove to get τ=100.  
