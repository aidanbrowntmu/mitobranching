set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
#set terminal postscript eps color solid
set output 'Fig3A.eps'
set key font ",19"
set key spacing 1.1
set key at 0.667,0.983

labelFONT="font 'Arial, 21'"
set label '(A)' at 0.005,1.05 @labelFONT


set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 25"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"



set xlabel '{/Symbol l}_{add}/({/Symbol l}_{add}+{/Symbol l}_{remove})' offset 0,-0.4,0
set ylabel 'Node degree probability'  offset -0.8,1,0

set bmargin 4 #/0.5
set tmargin 2.5
set lmargin 9
set rmargin 2


set xtics 0.2

set multiplot
set size 1.0,1.0  # main plot

pl [:][:1]"degree_0_4connection.dat" u 1:($2/441) w lp pt 4 ps 2 lw 3 lc rgb "#5cc863" title "(Node degree-0)_{degree-4}", "degree_0_2connection.dat" u 1:($2/441) w l dashtype 2 lw 3 lc rgb "#5cc863" title "(Node degree-0)_{degree-2}","degree_1_4connection.dat" u 1:($2/441) w lp pt 6 ps 2 lw 3 lc rgb "#21908d" title "(Node degree-1)_{degree-4}", "degree_1_2connection.dat" u 1:($2/441) w l dashtype 2 lw 3 lc rgb "#21908d" title "(Node degree-1)_{degree-2}", "degree_2_4connection.dat" u 1:($2/441) w lp pt 8 ps 2 lw 3 lc rgb "#2c718e" title "(Node degree-2)_{degree-4}", "degree_2_2connection.dat" u 1:($2/441) w l dashtype 2 lw 3 lc rgb "#2c718e" title "(Node degree-2)_{degree-2}", "degree_3_4connection.dat" u 1:($2/441) w lp pt 10 ps 2 lw 3 lc rgb "#472c7a" title "(Node degree-3)_{degree-4}", "degree_4_4connection.dat" u 1:($2/441) w lp pt 12 ps 2 lw 3 lc rgb "#440154" title "(Node degree-4)_{degree-4}"


