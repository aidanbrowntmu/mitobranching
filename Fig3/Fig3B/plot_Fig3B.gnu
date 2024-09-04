set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig3B.eps'


set key font ",25"
set key spacing 1.1
set key top center

labelFONT="font 'Arial, 21'"
set label '(B)' at 0.002,420.0 @labelFONT


set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 23"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"


set xlabel '{/Symbol l}_{add}/({/Symbol l}_{add}+{/Symbol l}_{remove})' offset 0,-0.4,0
set ylabel 'Number of connected components'  offset -0.8,1,0

set bmargin 4 #/0.5
set tmargin 2.5
set lmargin 9
set rmargin 2


set xtics 0.2


set multiplot
set size 1.0,1.0 

pl [0:][:400] "connected_components_4connection.out" u 1:3 w lp pt 12 ps 2 lw 3 lc rgb "#21908d" title "degree-4", "connected_components_2connection.out" u 1:3 w l dashtype 2 lw 3 lc rgb "#21908d" title "degree-2"


