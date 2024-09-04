set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig8B.eps'


set key font ",20"
set key at 0.9,1.17

set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 25"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"

labelFONT="font 'Arial, 22'"
set label '(B)' at 0.0,1.25 @labelFONT

set xlabel '{/Symbol l}_{add}/({/Symbol l}_{add}+{/Symbol l}_{remove})' offset 0,-0.8,0
set ylabel 'Effective diffusivity D_{eff}'  offset -0.5,1,0
set bmargin 4.5 #/0.5
set tmargin 2.3
set lmargin 9
set rmargin 2


set xtics 0.2 
set ytics 0.2


set multiplot
set size 1.0,1.0  # main plot
plot [:][:1.2] "diffusion_prob_tau1_degree2_large.dat" u 1:($2/4) w lp pt 9 ps 2 lw 3 lc rgb "blue" title "(({/Symbol t}=1})_{large})_{degree-2}","diffusion_prob_tau1_degree2_small.dat" u 1:($2/4) w lp dashtype 2 pt 8 ps 1.5 lw 2 lc rgb "#8A2BE2" title "(({/Symbol t}=1})_{small})_{degree-2}","diffusion_prob_tau1_degree4_large.dat"  u 1:($2/4) w lp pt 7 ps 2 lw 3 lc rgb "#008000" title "(({/Symbol t}=1)_{large}})_{degree-4}", "diffusion_prob_tau1_degree4_small.dat" u 1:($2/4) w lp dashtype 2 pt 6 ps 1.5 lw 3 lc rgb "#00FFFF" title "(({/Symbol t}=1)_{small}})_{degree-4}"


unset key
unset title
unset xlabel
unset ylabel
unset xtics
unset ytics
unset log

set size 0.48,0.48
set origin 0.1,0.3

set key font ",11"
set key spacing 1.0
set key  at 1.36,0.014
set xlabel font "Times-Roman, 16"     #Arial-Bold
set ylabel font "Times-Roman, 16"     #Arial-Bold

labelFONT="font 'Arial, 21'"
set label '(B)' at 0.8,0.94 @labelFONT


set xtics font "Times-Roman, 16"
set ytics font "Times-Roman, 16"
set xtics 0.2
set ytics 0.02
set xlabel '{/Symbol l}_{add}/({/Symbol l}_{add}+{/Symbol l}_{remove})' offset 1.5,0.1,0
set ylabel 'D_{eff}'  offset 1.7,0.2,0

set key bottom right
set key spacing 1.1

pl[:][:0.04] "diffusion_prob_tau100_degree2_large.dat" u 1:($2/4) w lp pt 9 ps 1.5 lw 2 lc rgb "blue" title "","diffusion_prob_tau100_degree2_small.dat" u 1:($2/4) w lp dashtype 2 lw 2 pt 8 ps 1 lc rgb "#8A2BE2" title "", "diffusion_prob_tau100_degree4_large.dat" u 1:($2/4) w lp pt 7 ps 1.5 lw 2 lc rgb "#008000" title "", "diffusion_prob_tau100_degree4_small.dat" u 1:($2/4) w lp dashtype 2 lw 2 pt 6 ps 1 lc rgb "#00FFFF" title ""
