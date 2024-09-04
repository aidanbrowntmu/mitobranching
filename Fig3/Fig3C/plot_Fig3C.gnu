set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig3C.eps'

set key font ",19"
set key spacing 1.1
set key at 0.95,0.8

labelFONT="font 'Arial, 21'"
set label '(C)' at 0.01,1.07 @labelFONT


set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 21"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"


set xlabel '{/Symbol l}_{add}/({/Symbol l}_{add}+{/Symbol l}_{remove})' offset 0,-0.4,0
set ylabel 'Fraction of nodes part of component with n_{loop} loops'  offset -0.5,-0.9,0

set bmargin 4 #/0.5
set tmargin 2.5
set lmargin 9
set rmargin 2


set xtics 0.2

set multiplot
set size 1.0,1.0  # main plot

pl [:][-0.03:1.02] "loops_4connections.out" u 1:3 w lp pt 12 ps 2 lw 3 lc rgb "#5cc863" title "(n_{loop}=0 )_{degree-4}", "loops_2connections.out" u 1:3 w l dashtype 2 lw 3 lc rgb "#5cc863" title "(n_{loop}=0)_{degree-2}", "loops_4connections.out" u 1:4 w lp pt 14 ps 2 lw 3 lc rgb "#21908d" title "(n_{loop}=1)_{degree-4}", "loops_2connections.out" u 1:4 w l dashtype 2 lw 3 lc rgb "#21908d" title "(n_{loop}=1)_{degree-2}","loops_4connections.out" u 1:5 w lp pt 16 ps 2 lw 3 lc rgb "#3b518b" title "(n_{loop} > 2)_{degree-4}", "loops_2connections.out" u 1:5 w l dashtype 2 lw 3 lc rgb "#3b518b" title "(n_{loop} >2)_{degree-2}"





