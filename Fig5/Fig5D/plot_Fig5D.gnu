set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig5D.eps'

set key font ",18"
set key spacing 1.1
set key at 0.9,0.5

set xlabel font "Times-Roman, 22"     #Arial-Bold
set ylabel font "Times-Roman, 20"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"

labelFONT="font 'Arial, 22'"
set label font "Arial-Bold, 45"
set label font "Arial-Bold, 20"
set label '(D)' at 0.0001,1.1 @labelFONT




set ylabel 'Fraction of nodes part of component with zero loops' offset -0.8,-2.0,0
set xlabel '(a_{1}*N_{mito})/b_{1}'  offset -1.2,-0.8,0


set bmargin 4.8 #/0.5
set tmargin 2.3
set lmargin 8.5
set rmargin 2.5


set xtics 100

set format x "10^{%L}"

set xtics off 0,-0.3
set ytics off -0.2,0
set multiplot
set size 1.0,1.0  # main plot

set log x

pl [][-0.05:1.05]"aspatial_a1_10_a2_0.01_cycles.out" u 2:3 w lp pt 4 ps 2 lw 3 lc rgb "#5cc863" title "", "aspatial_a1_10_a2_0.0_cycles.out" u 2:3 w l dashtype 2 lw 4 lc rgb "#5cc863" title "","aspatial_a1_0.2_a2_0.01_cycles.out" u 2:3 w lp pt 6 ps 2 lw 3 lc rgb "#21908d" title "", "aspatial_a1_0.2_a2_0.0_cycles.out" u 2:3 w l dashtype 2 lw 4 lc rgb "#21908d" title "","aspatial_a1_0.002_a2_0.01_cycles.out" u 2:3 w lp pt 10 ps 2 lw 3 lc rgb "#3b518b" title "", "aspatial_a1_0.002_a2_0.0_cycles.out" u 2:3 w l dashtype 2 lw 4 lc rgb "#3b518b" title ""

