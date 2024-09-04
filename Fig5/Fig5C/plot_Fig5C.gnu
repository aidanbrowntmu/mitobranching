set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig5C.eps'


set key font ",21"
set key spacing 1.2
set key at 400000,40

set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 25"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"

labelFONT="font 'Arial, 22'"
set label font "Arial-Bold, 45"
set label font "Arial-Bold, 20"
set label '(C)' at 0.0001,52.5 @labelFONT




set ylabel 'Number of connected components' offset -0.8,-2.0,0
set xlabel '(a_{1}*N_{mito})/b_{1}'  offset -1.2,-0.8,0


set bmargin 4.8 #/0.5
set tmargin 2.3
set lmargin 8.5
set rmargin 2.5


set xtics 100
set ytics 10

set format x "10^{%L}"

set xtics off 0,-0.3
set ytics off -0.2,0
set multiplot
set size 1.0,1.0  # main plot

set log x
pl "aspatial_a1_10_a2_0.01_components.out" u 2:3 w lp pt 4 ps 2 lw 3 lc rgb "#5cc863" title "(a_{1}=10.0)_{degree-3}", "aspatial_a1_10_a2_0.0_components.out" u 2:3 w l dashtype 2 lw 4 lc rgb "#5cc863" title "(a_{1}=10.0)_{degree-2}","aspatial_a1_0.2_a2_0.01_components.out" u 2:3 w lp pt 6 ps 2 lw 3 lc rgb "#21908d" title "(a_{1}=0.2)_{degree-3}", "aspatial_a1_0.2_a2_0.0_components.out" u 2:3 w l dashtype 2 lw 4 lc rgb "#21908d" title "(a_{1}=0.2)_{degree-2}","aspatial_a1_0.002_a2_0.01_components.out" u 2:3 w lp pt 10 ps 2 lw 3 lc rgb "#3b518b" title "(a_{1}=0.002)_{degree-3}", "aspatial_a1_0.002_a2_0.0_components.out" u 2:3 w l dashtype 2 lw 4 lc rgb "#3b518b" title "(a_{1}=0.002)_{degree-2}"
