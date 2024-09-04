set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig5F.eps'


set key font ",21"
set key spacing 1.2
set key at 100000,0.65

set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 20"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"

labelFONT="font 'Arial, 22'"
set label '(F)' at 0.0001,1.05 @labelFONT




set ylabel 'Eligible end-to-end fusion pairs/Maximum pairs' offset -0.8,-1.4,0
set xlabel '(a_{1}*N_{mito})/b_{1}'  offset -1.2,-0.8,0


set bmargin 4.8 #/0.5
set tmargin 2.3
set lmargin 8.9
set rmargin 2.5


set xtics 100
set ytics 0.2

set format x "10^{%L}"

set xtics off 0,-0.4
set ytics off -0.2,0
set multiplot
set size 1.0,1.0  # main plot

set log x
pl "eligiblefusion_a1_10_a2_0.01.out" u 1:3 w lp pt 4 ps 2 lw 3 lc rgb "#5cc863" title "", "eligiblefusion_a1_10_a2_0.out" u 1:3 w l dashtype 2 lw 4 lc rgb "#5cc863"title "", "eligiblefusion_a1_0.2_a2_0.01.out" u 1:3 w lp pt 6 ps 2 lw 3 lc rgb "#21908d" title "", "eligiblefusion_a1_0.2_a2_0.out"u 1:3 w l dashtype 2 lw 4 lc rgb "#21908d" title "", "eligiblefusion_a1_0.002_a2_0.01.out"u 1:3 w lp pt 10 ps 2 lw 3 lc rgb "#3b518b" title "", "eligiblefusion_a1_0.002_a2_0.out" u 1:3 w l dashtype 2 lw 4 lc rgb "#3b518b" title ""

