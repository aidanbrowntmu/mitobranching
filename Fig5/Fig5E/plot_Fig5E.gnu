set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig5E.eps'


set key font ",19"
set key spacing 1.1
set key at 1.42,0.59

set xlabel font "Times-Roman, 22"     #Arial-Bold
set ylabel font "Times-Roman, 20"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"

labelFONT="font 'Arial, 22'"
set label font "Arial-Bold, 45"
set label font "Arial-Bold, 20"
set label '(E)' at 0.0001,1.05 @labelFONT




set ylabel 'Fraction of nodes part of component with one loop' offset -0.8,-2.0,0
set xlabel '(a_{1}*N_{mito})/b_{1}'  offset -1.5,-1.2,0

set bmargin 4.8 #/0.5
set tmargin 2.3
set lmargin 8.5
set rmargin 2.5


set xtics 100
set ytics 0.20

set format x "10^{%L}"
set xtics off 0,-0.7
set ytics off -0.2,0

set multiplot
set size 1.0,1.0  # main plot

set log x
pl [][-0.04:]"aspatial_a1_10_a2_0.01_cycles.out" u 2:4 w lp pt 4 ps 2 lw 3 lc rgb "#5cc863" title "", "aspatial_a1_10_a2_0.0_cycles.out" u 2:4 w l dashtype 2 lw 4 lc rgb "#5cc863" title "","aspatial_a1_0.2_a2_0.01_cycles.out" u 2:4 w lp pt 6 ps 2 lw 3 lc rgb "#21908d" title "", "aspatial_a1_0.2_a2_0.0_cycles.out" u 2:4 w l dashtype 2 lw 4 lc rgb "#21908d" title "","aspatial_a1_0.002_a2_0.01_cycles.out" u 2:4 w lp pt 10 ps 2 lw 3 lc rgb "#3b518b" title "", "aspatial_a1_0.002_a2_0.0_cycles.out" u 2:4 w l dashtype 2 lw 4 lc rgb "#3b518b" title ""

unset key
unset title
unset xlabel
unset ylabel
unset label
unset xtics
unset ytics
unset log
unset format y
set size 0.54,0.56
set origin 0.11,0.41

set key font ",15"
set key spacing 1.10
set xlabel font "Times-Roman, 16"     #Arial-Bold
set ylabel font "Times-Roman, 18"     #Arial-Bold

set xtics font "Times-Roman, 18"
set ytics font "Times-Roman, 18"

set xlabel '(a_{1}*N_{mito})/b_{1}' offset -3.0,0,0
set ylabel 'f_{nodes,multiloop}'  offset 1.0,0.2,0
set log x
pl [][-0.08:1.05]"aspatial_a1_10_a2_0.01_cycles.out" u 2:5 w lp pt 4 ps 1.5 lw 2 lc rgb "#5cc863" title "", "aspatial_a1_10_a2_0.0_cycles.out" u 2:5 w l dashtype 2 lw 3 lc rgb "#5cc863" title "","aspatial_a1_0.2_a2_0.01_cycles.out" u 2:5 w lp pt 6 ps 1.5 lw 2 lc rgb "#21908d" title "", "aspatial_a1_0.2_a2_0.0_cycles.out" u 2:5 w l dashtype 2 lw 3 lc rgb "#21908d" title "","aspatial_a1_0.002_a2_0.01_cycles.out" u 2:5 w lp pt 10 ps 1.5 lw 2 lc rgb "#3b518b" title "", "aspatial_a1_0.002_a2_0.0_cycles.out" u 2:5 w l dashtype 2 lw 3 lc rgb "#3b518b" title ""
