set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig9C.eps'


set key font ",18"
set key spacing 1.2
set key at 60000,0.01


labelFONT="font 'Arial, 22'"
set label '(C)' at 0.00001,3.5 @labelFONT


set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 25"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"

set xlabel '{/Symbol l}_{add}/{/Symbol l}_{remove}' offset 0,-0.8,0
set ylabel 'Effective diffusivity D_{eff}'  offset -0.8,1,0


set bmargin 4.8 #/0.5
set tmargin 2.1
set lmargin 9.2
set rmargin 2.5


set xtics 100
set ytics 10

set format x "10^{%L}"
set format y "10^{%L}"
set xtics off 0,-0.3
set multiplot
set size 1.0,1.0  # main plot
set log 


plot [0.00001:100000][:2] "diffusion_fusion10_3connection.dat" u 1:($2/4) w l dashtype 2 lw 4 lc rgb "#5cc863" title "({/Symbol l}_{add}=10.0)_{degree-3}", "diffusion_fusion10_4connection.dat" u 1:($2/4) w lp pt 4 ps 2 lw 3 lc rgb "#5cc863" title "({/Symbol l}_{add}=10.0)_{degree-4}", "diffusion_fusion0.02_3connection.dat" u 1:($2/4) w l dashtype 2 lw 4 lc rgb "#2c718e" title "({/Symbol l}_{add}=0.02)_{degree-3}", "diffusion_fusion0.02_4connection.dat" u 1:($2/4) w lp pt 8 ps 2 lw 3 lc rgb "#2c718e" title "({/Symbol l}_{add}=0.02)_{degree-4}","diffusion_fusion0.0002_3connection.dat" u 1:($2/4) w l dashtype 2 lw 4 lc rgb "#472c7a" title "({/Symbol l}_{add}=0.0002)_{degree-3}", "diffusion_fusion0.0002_4connection.dat" u 1:($2/4) w lp pt 12 ps 2 lw 3 lc rgb "#472c7a" title "({/Symbol l}_{add}=0.0002)_{degree-4}",x w l lw 3 lc rgb "black" title "\\~{/Symbol l}_{add}/{/Symbol l}_{remove}"


