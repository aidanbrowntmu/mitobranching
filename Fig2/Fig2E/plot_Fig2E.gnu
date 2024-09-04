set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig2E.eps'


set key font ",21"
set key spacing 1.18
set key at 100000,0.0045

set xlabel font "Times-Roman, 25"    
set ylabel font "Times-Roman, 25"    
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"

labelFONT="font 'Arial, 22'"
set label '(E)' at 0.000012,3.9 @labelFONT

set xlabel '{/Symbol l}_{add}/{/Symbol l}_{remove}' offset 0,-0.8,0
set ylabel 'Effective diffusivity D_{eff}'  offset -0.8,0.5,0

set bmargin 4.7 #/0.5
set tmargin 2.5
set lmargin 9.2
set rmargin 2.5


set xtics off 0,-0.2
set ytics off -0.2,0

set format x "10^{%L}"
set format y "10^{%L}"

set multiplot
set size 1.0,1.0 
set log
plot [0.00001:100000][0.00001:2] "diffusion_fusion10_2connection.dat" u 1:($2/4) w l dashtype 2 lw 4 lc rgb "#5cc863" title "({/Symbol l}_{add}=10.0)_{degree-2}","diffusion_fusion10_4connection.dat" u 1:($2/4) w lp pt 4 ps 2 lw 3 lc rgb "#5cc863" title "({/Symbol l}_{add}=10.0)_{degree-4}","diffusion_fusion0.2_2connection.dat" u 1:($2/4) w l dashtype 2 lw 4 lc rgb "#21908d" title "({/Symbol l}_{add}=0.2)_{degree-2}","diffusion_fusion0.2_4connection.dat" u 1:($2/4) w lp pt 6 ps 2 lw 3 lc rgb "#21908d" title "({/Symbol l}_{add}=0.2)_{degree-4}","diffusion_fusion0.002_2connection.dat" u 1:($2/4) w l dashtype 2 lw 4 lc rgb "#3b518b" title "({/Symbol l}_{add}=0.002)_{degree-2}","diffusion_fusion0.002_4connection.dat" u 1:($2/4) w lp ps 2 pt 10 lw 3 lc rgb "#3b518b" title "({/Symbol l}_{add}=0.002)_{degree-4}",x w l lw 3 lc rgb "black" title "\\~{/Symbol l}_{add}/{/Symbol l}_{remove})"


