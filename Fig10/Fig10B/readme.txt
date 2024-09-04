#==============================================Data================================
Fig10B is made by using the scripts "plot_Fig10B.gnu". 

Plotted data files in the main plot with solid curves are "MFPT_prob_tau0.1_differentmass441.dat", "MFPT_prob_tau1_differentmass441.dat" and "MFPT_prob_tau100_differentmass441.dat" using column 1 (connection probability) and column 2 (MFPT).
Plotted data files in the main plot with dashed curves are "MFPT_prob_tau0.1_samemass441.dat", "MFPT_prob_tau1_samemass441.dat" and "MFPT_prob_tau100_samemass441.dat" using column 1 (connection probability) and column 2 (MFPT).
Plotted data files in the main plot with dot-dashed curves are "MFPT_prob_tau0.1_samemass625.dat", "MFPT_prob_tau1_samemass625.dat" and "MFPT_prob_tau100_samemass625.dat" using column 1 (connection probability) and column 2 (MFPT).

Plotted data files in the inset are "spacing_mass441.dat" and "spacing_mass625.dat".


#=============================================Codes===============================
Code used for getting the solid curves (degree-4 network with different mass for different connection probability) is the same used to get Fig2B.

Codes used for getting the dashed and dot-dashed curves (degree-4 network same mass (441 and 625) for different connection probabilities) are different for each connection probability with a unique input file as listed below.

Folder "tau_0.1_samemass441", "tau_1_samemass441", and "tau_100_samemass441" contains the sub-folders with codes and input data files for each data point of dashed curves (same mass of 441 degree-4 network) in Fig.10A for τ = 0.1, 1, 100, respectively.

Folder "tau_0.1_samemass625", "tau_1_samemass625", and "tau_100_samemass625" contains the sub-folders with codes and input data files for each data point of dot-dashed curves (same mass of 625 degree-4 network) in Fig.10A for τ = 0.1, 1, 100, respectively.

"xy_time_target.dat" is generated for every case within each sub-folder to get the averaged MFPT (average of column 2) over the realizations (column 1).
One example data file "xy_time_target.dat" is given.

Lattice spacing is calculated as L/(n−1), where L is the system size and n is the number of nodes in each direction.


