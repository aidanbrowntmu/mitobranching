set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig12.eps'


set key font ",21"
set key spacing 1.2
set key at 100.0,1000

set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 25"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"

labelFONT="font 'Arial, 21'"

set ylabel 'MFPT/N_{mito}' offset -0.8,-2.0,0
set xlabel '(a_{1}*N_{mito})/b_{1}'  offset -1.2,-0.8,0


   set bmargin 4.8 #/0.5
   set tmargin 1.8
   set lmargin 8.5
   set rmargin 2.5


set xtics 100

set format x "10^{%L}"
set format y "10^{%L}"

set xtics off 0,-0.3
set ytics off -0.2,0
set multiplot
set size 1.0,1.0  # main plot

set log 
plot [:][0.5:1500] "MFPT_a210_a1_10_degree3_Nmito100.dat" w lp pt 4 ps 2 lw 3 lc rgb "#5cc863" title "a_{1}=10.0", "MFPT_a210_a1_0.2_degree3_Nmito100.dat" w lp pt 6 ps 2 lw 3 lc rgb "#21908d" title "a_{1}=0.2","MFPT_a210_a1_0.002_degree3_Nmito100.dat" w lp pt 10 ps 2 lw 3 lc rgb "#3b518b" title "a_{1}=0.002", 0.24/x w l lw 3 lc rgb "black" title "\\~b_{1}/(a_{1}*N_{mito})",1.0 dashtype 77 lw 3 lc rgb "black" title ""


