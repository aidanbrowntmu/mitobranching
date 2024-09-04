#=================================Data======================
Fig3D is made by using the script "plot_Fig3D.gnu" 
Solid curve is the data "maxeligiblefusion_4connection.out" using column 1 (connection probability) and column 2 (eligible fusion pairs/maximum pairs).
Dashed curve is the data "maxeligiblefusion_2connection.out" using column 1 (connection probability) and column 2 (eligible fusion pairs/maximum pairs).

#=================================Code===========================
"fig3d_code.m" is code to analyze a single 2d spatial lattice network snapshot to determine the number of pairs that are eligible for fusion as a fraction of the total possible pairs.
A network snapshot file is provided as the file name on line 8.
The eligible fraction is stored in the variable fraction, calculated on line 83.
