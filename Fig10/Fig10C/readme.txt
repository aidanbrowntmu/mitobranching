#==============================================Data================================
Fig10C is made by using the scripts "plot_Fig10C.gnu". 

Plotted data files in the main plot with solid curves are "diffusion_prob_tau0.1_differentmass441.dat", "diffusion_prob_tau1_differentmass441.dat" and "diffusion_prob_tau100_differentmass441.dat" using column 1 (connection probability) and (column2)/4 (effective diffusivity).
Plotted data files in the main plot with dashed curves are "diffusion_prob_tau0.1_samemass441.dat", "diffusion_prob_tau1_samemass441.dat" and "diffusion_prob_tau100_samemass441.dat" using column 1 (connection probability) and (column2)/4 (effective diffusivity).
Plotted data files in the main plot with dot-dashed curves are "diffusion_prob_tau0.1_samemass625.dat", "diffusion_prob_tau1_samemass625.dat" and "diffusion_prob_tau100_samemass625.dat" using column 1 (connection probability) and (column2)/4 (effective diffusivity).

Plotted data files in the top left inset is "bond_topleftinset.dat" and in the top right inset is "bond_toprightinset.dat" with the lattice sites from the file "grid_pos_20X20.dat".


#=============================================Codes===============================
Code used for getting the solid curves (degree-2 network with different mass for different connection probability) is the same used in Fig2C.

Codes used for getting the dashed and dot-dashed curves (degree-2 network same mass (441 and 625) for different connection probabilities) are different for each connection probability with a unique input file as listed below.

Folder "tau_0.1_samemass441", "tau_1_samemass441", and "tau_100_samemass441" contains the folders with codes and input data files for each data point of dashed curves (same mass of 441 degree-42network) in Fig.10C for τ = 0.1, 1, 100, respectively.

Folder "tau_0.1_samemass625", "tau_1_samemass625", and "tau_100_samemass625" contains the folders with codes and input data files for each data point of dot-dashed curves (same mass of 625 degree-2 network) in Fig.10C for τ = 0.1, 1, 100, respectively.

"linear_reg.f90" is used to get the effective diffusivity D_eff by getting a suitable fit to the data "diffusion_time.dat" (use column 1 and column 5) as described in appendix Fig.6. 
One example data file "diffusion_time.dat" is given.

Codes for getting the insets are "code_topleftinset.f90" and "code_toprightinset.f90" with input files "inputfile_topleftinset.dat" and "inputfile_toprightinset.dat", respectively that gives "bond_topleftinset.dat" and "bond_toprightinset.dat", respectively plotted as insets.
