set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig4A.eps'

set key font ",21"
set key spacing 1.2
set key at 290.0,2000

set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 25"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"

labelFONT="font 'Arial, 23'"
set label '(A)' at 0.0001,5000 @labelFONT



set ylabel 'MFPT/N_{mito}' offset -1.5,-1.2,0
set xlabel '(a_{1}*N_{mito})/b_{1}'  offset -1.0,-0.5,0


set bmargin 4.5 #/0.5
set tmargin 2.5
set lmargin 9.0
set rmargin 2


set xtics 100

set format x "10^{%L}"
set format y "10^{%L}"

set xtics off 0,-0.3
set ytics off -0.2,0

set multiplot
set size 1.0,1.0  # main plot

set log 


plot [][0.5:3000] "MFPT_a1_10_degree3.dat" w lp pt 4 ps 2 lw 3 lc rgb "#5cc863" title "(a_{1}=10.0)_{degree-3}", "MFPT_a1_10_degree2.dat" w l dashtype 2 lw 4 lc rgb "#5cc863" title "(a_{1}=10.0)_{degree-2}","MFPT_a1_0.2_degree3.dat" w lp pt 6 ps 2 lw 3 lc rgb "#21908d" title "(a_{1}=0.2)_{degree-3}","MFPT_a1_0.2_degree2.dat" w l dashtype 2 lw 4 lc rgb "#21908d" title "(a_{1}=0.2)_{degree-2}","MFPT_a1_0.002_degree3.dat" w lp pt 10 ps 2 lw 3 lc rgb "#3b518b" title "(a_{1}=0.002)_{degree-3}","MFPT_a1_0.002_degree2.dat" w l dashtype 2 lw 4 lc rgb "#3b518b" title "(a_{1}=0.002)_{degree-2}", 0.25/x w l lw 3 lc rgb "black" title "\\~b_{1}/(a_{1}*N_{mito})",1.0 dashtype 77 lw 3 lc rgb "black" title ""


