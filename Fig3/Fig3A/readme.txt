#==============================================Data================================

Fig3A is made by using the script plot_Fig3A.gnu. 

Plotted files in the main plot are with solid curves are "degree_0_4connection.dat", "degree_1_4connection.dat", "degree_2_4connection.dat", "degree_3_4connection.dat, and "degree_4_4connection.dat".
Plotted files in the main plot are with dashed curves are "degree_0_2connection.dat", "degree_1_2connection.dat", and "degree_2_2connection.dat".
 
#=============================================Codes===============================

"code_degree_4connection.f90" is used with an input file "centers_bond_10X10.dat" to calculated the node degree 0, 1, 2, 3, and 4 for degree-4 network.
Same code is modified from maximum allowed 4 nearest neighbors to 2 nearest neighbors by changing a parameter value "neighno = 4" to "neighno = 2" for calculating node degrees in the case of degree-2 network.

