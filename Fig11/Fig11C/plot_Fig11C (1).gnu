set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig11C.eps'


set key font ",23"
set key spacing 1.2
set key at 400.0,2100

set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 25"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"

labelFONT="font 'Arial, 22'"
set label '(C)' at 0.0001,4300 @labelFONT



set ylabel 'MFPT/N_{mito}' offset -0.9,-1.2,0
set xlabel '(a_{1}*N_{mito})/b_{1}'  offset -0.8,-0.5,0


set bmargin 4.5 #/0.5
set tmargin 2.2
set lmargin 8.5
set rmargin 2


set xtics 100

set format x "10^{%L}"
set format y "10^{%L}"

set multiplot
set size 1.0,1.0  # main plot

set log 


plot [:][0.5:3000] "MFPT_a20.001_a1_10_degree3.dat" w lp pt 4 ps 2 lw 3 lc rgb "#5cc863" title "", "MFPT_a20.001_a1_0.2_degree3.dat" w lp pt 6 ps 2 lw 3 lc rgb "#21908d" title "","MFPT_a20.001_a1_0.002_degree3.dat" w lp pt 10 ps 2 lw 3 lc rgb "#3b518b" title "", 0.25/x w l lw 3 lc rgb "black" title "",1.0 dashtype 77 lw 3 lc rgb "black" title ""




