set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig9D.eps'


set key font ",25"
set key spacing 1.2
set key at 4000,300000000
set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 25"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"

labelFONT="font 'Arial, 22'"
set label '(D)' at 0.000001,1000000000 @labelFONT


set xlabel '{/Symbol l}_{add}/{/Symbol l}_{remove}' offset 0,-0.9,0
set ylabel 'MFPT'  offset -1.2,1,0

set bmargin 4.8 #/0.5
set tmargin 2.2
set lmargin 9
set rmargin 2.2


set xtics 100
set ytics 10

set format x "10^{%L}"
set format y "10^{%L}"
set xtics off 0,-0.3
set multiplot
set size 1.0,1.0  # main plot

set log 
plot [0.000001:10000][100:500000000]  "MFPT_fusion10_3connection.dat"  w l lw 4 dashtype 2 lc rgb "#5cc863" title "", "MFPT_fusion10_4connection.dat" w lp pt 4 ps 2 lw 3 lc rgb "#5cc863" title "", "MFPT_fusion0.02_3connection.dat" w l lw 4 dashtype 2 lc rgb "#2c718e" title "","MFPT_fusion0.02_4connection.dat" w lp pt 8 ps 2 lw 3 lc rgb "#2c718e" title "","MFPT_fusion0.0002_3connection.dat" w l lw 4 dashtype 2 lc rgb "#472c7a" title "","MFPT_fusion0.0002_4connection.dat" w lp pt 12 ps 2 lw 3 lc rgb "#472c7a" title "", 300/x w l lw 3 lc rgb "black" title "\\~{/Symbol l}_{remove}/{/Symbol l}_{add}" 




