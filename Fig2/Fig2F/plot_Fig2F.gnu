set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig2F.eps'

set key font ",25"
set key spacing 1.1
set key at 80.0,55000000
set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 25"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"

labelFONT="font 'Arial, 22'"
set label '(F)' at 0.000004,210000000 @labelFONT

set ylabel 'MFPT' offset -1.0,-1.2,0
set xlabel '{/Symbol l}_{add}/{/Symbol l}_{remove}'  offset -2.0,-0.8,0

set bmargin 4.5 #/0.5
set tmargin 2.5
set lmargin 8.9
set rmargin 2.5


set xtics 100

set format x "10^{%L}"
set format y "10^{%L}"
set xtics off 0,-0.25
set ytics off -0.2,0

set multiplot
set size 1.0,1.0  # main plot


set log
plot [:10000][100:]  "MFPT_fusion10_2connection.dat"  w l dashtype 2 lw 4 lc rgb "#5cc863" title "","MFPT_fusion10_4connection.dat" w lp pt 4 ps 2 lw 3 lc rgb "#5cc863" title "","MFPT_fusion0.2_2connection.dat" w l dashtype 2 lw 4 lc rgb "#21908d" title "","MFPT_fusion0.2_4connection.dat" w lp pt 6 ps 2 lw 3 lc rgb "#21908d" title "","MFPT_fusion0.002_2connection.dat"  w l dashtype 2 lw 4 lc rgb "#3b518b" title "","MFPT_fusion0.002_4connection.dat" w lp pt 10 ps 2 lw 3 lc rgb "#3b518b" title "",350/x w l lw 3 lc rgb "black" title "\\~{/Symbol l}_{remove}/{/Symbol l}_{add}"


