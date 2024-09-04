set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig9A.eps'


set key font ",21"
set key spacing 1.2
set key top center

set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 25"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"

labelFONT="font 'Arial, 22'"
set label '(A)' at 0.0,1.04 @labelFONT

set xlabel '{/Symbol l}_{add}/({/Symbol l}_{add}+{/Symbol l}_{remove})' offset 0,-0.5,0
set ylabel 'Effective diffusivity D_{eff}'  offset -0.8,1,0

set bmargin 4.5 #/0.5
set tmargin 2.2
set lmargin 9
set rmargin 2


set xtics 0.2
set ytics 0.2


set multiplot
set size 1.0,1.0  # main plot
plot [][:] "diffusion_prob_tau1_3connection.dat" u 1:($2/4) w l lw 4 dashtype 2 lc rgb "#0000FF" title "({/Symbol t}=1)_{degree-3}", "diffusion_prob_tau1_4connection.dat" u 1:($2/4)  w lp pt 8 ps 2 lw 3 lc rgb "#0000FF" title "({/Symbol t}=1)_{degree-4}","diffusion_prob_tau100_3connection.dat" u 1:($2/4) w l lw 4 dashtype 2 lc rgb "#00FFFF" title "({/Symbol t}=100)_{degree-3}", "diffusion_prob_tau100_4connection.dat" u 1:($2/4)  w lp pt 10 ps 2 lw 3  lc rgb "#00FFFF" title "({/Symbol t}=100)_{degree-4}"#, "../../../../2_connection_per_node/diffusion/10X10/tau_1/diffusion_prob_new.dat" u 1:($2/4) w lp pt 4 lw 2 lc rgb "#0000FF" title "2 side connected"


