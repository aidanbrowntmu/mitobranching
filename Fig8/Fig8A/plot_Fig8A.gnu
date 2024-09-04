set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig8A.eps'


set key font ",21"
set key spacing 1.2
set key at 0.45, 0.95

set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 25"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"

set xlabel 'Connection probability p' offset 0,-0.5,0
set ylabel 'Effective diffusivity D_{eff}'  offset -0.6,1,0

set bmargin 4.5 #/0.5
set tmargin 2.3
set lmargin 9
set rmargin 2

labelFONT="font 'Arial, 22'"
set label '(A)' at 0.0,1.04 @labelFONT

set ytics 0.2
set multiplot
set size 1.0,1.0  # main plot

pl "diffusion_prob_tau0_4connection.dat" u 1:($2/4) w lp pt 7 ps 2 lw 3 lc rgb "#8A2BE2" title "({/Symbol t}=0)_{large}","diffusion_prob_tau0_2connection.dat" u 1:($2/4) w lp pt 6 ps 1.5 dashtype 2 lw 3 lc rgb "#8A2BE2" title "({/Symbol t}=0)_{small}","diffusion_prob_tau1_4connection.dat" u 1:($2/4) w lp pt 9 ps 2 lw 3 lc rgb "#0000FF" title "({/Symbol t}=1)_{large}", "diffusion_prob_tau1_2connection.dat" u 1:($2/4) w lp pt 8 ps 1.5 dashtype 2 lw 3 lc rgb "#0000FF" title "({/Symbol t}=1)_{small}", "diffusion_prob_tau100_4connection.dat" u 1:($2/4) w lp pt 11 ps 2 lw 3 lc rgb "#00FFFF" title "({/Symbol t}=100})_{large}", "diffusion_prob_tau100_2connection.dat" u 1:($2/4) w lp pt 10 ps 1.5 dashtype 2 lw 3 lc rgb "#00FFFF" title "({/Symbol t}=100)_{small}","diffusion_prob_tau_infinity_4connection.dat" u 1:($2/4) w lp pt 13 ps 2 lw 3 lc rgb "#00FF00" title "({{/Symbol t}={/Symbol\245}})_{large}", "diffusion_prob_tau_infinity_2connection.dat" u 1:($2/4) w lp pt 12 ps 1.5 dashtype 2 lw 3 lc rgb "#00FF00" title "({{/Symbol t}={/Symbol\245}})_{small}"


