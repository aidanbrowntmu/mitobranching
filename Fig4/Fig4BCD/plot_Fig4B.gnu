set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig4B.eps'


set key font ",21"
set key spacing 1.2
set key at 3.0,0.58

set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 25"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"

set ylabel 'Number of degree-3 nodes/N_{mito}' offset -0.4,-1.2,0
set xlabel '(a_{1}*N_{mito})/b_{1}'   offset -0.8,-1.1,0

set bmargin 4.9 #/0.5
set tmargin 2.5
set lmargin 10
set rmargin 1.3

labelFONT="font 'Arial, 21'"
set label '(B)' at 0.0001,0.63 @labelFONT
set xtics 100
set ytics 0.1

set format x "10^{%L}"
set xtics off 0,-0.8
set ytics off -0.2,0
set multiplot
set size 1.0,1.0  # main plot

set log x
plot [][:]  "network_fusion10_degree3.dat" u 1:($5*3) w lp pt 4 ps 2 lw 3 lc rgb "#5cc863" title "", "network_fusion0.2_degree3.dat" u 1:($5*3) w lp pt 6 ps 2 lw 3 lc rgb "#21908d" title "","network_fusion0.002_degree3.dat" u 1:($5*3) w lp pt 10 ps 2 lw 3 lc rgb "#3b518b" title ""


