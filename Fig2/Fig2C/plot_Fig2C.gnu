set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig2C.eps'
set key font ",21"
set key at 0.95,0.98

set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 25"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"

labelFONT="font 'Arial, 22'"
set label '(C)' at 0.01,1.05 @labelFONT



set xlabel '{/Symbol l}_{add}/({/Symbol l}_{add}+{/Symbol l}_{remove})' offset 0,-0.8,0
set ylabel 'Effective diffusivity D_{eff}'  offset -0.1,1,0

set bmargin 5 #/0.5
set tmargin 2.5
set lmargin 9.0
set rmargin 2
set xtics 0.2 
set ytics 0.2
set multiplot
set size 1.0,1.0  # main plot
plot [][] "diffusion_prob_tau1_2connection.dat" u 1:($2/4) w l lw 4 dashtype 2 lc rgb "#0000FF" title "({/Symbol t}=1})_{degree-2}","diffusion_prob_tau1_4connection.dat" u 1:($2/4) w lp pt 8 ps 2 lw 2 lc rgb "#0000FF" title "({/Symbol t}=1)_{degree-4}}"
unset label
unset key
unset title
unset xlabel
unset ylabel
unset xtics
unset ytics
unset log

set size 0.485,0.48
set origin 0.13,0.495

set key font ",13"
set key spacing 1.0
set key  at 1.03,0.01
set xlabel font "Times-Roman, 18"     #Arial-Bold
set ylabel font "Times-Roman, 18"     #Arial-Bold

set xtics font "Times-Roman, 18"
set ytics font "Times-Roman, 18"
set xtics 0.2
set ytics 0.01
set xlabel '{/Symbol l}_{add}/({/Symbol l}_{add}+{/Symbol l}_{remove})' offset 0.2,0.1,0
set ylabel 'D_{eff}'  offset 1.0,0.6,0

set key bottom right
set key spacing 1.2

pl[:][:0.04] "diffusion_prob_tau100_2connection.dat" u 1:($2/4) w l lw 4 dashtype 2 lc rgb "#00FFFF" title "({/Symbol t}=100})_{degree-2}", "diffusion_prob_tau100_4connection.dat" u 1:($2/4) w lp pt 10 lw 2 lc rgb "#00FFFF" title "({/Symbol t}=100)_{degree-4}}"

unset title
unset xlabel
unset ylabel
unset xtics
unset ytics
unset log
unset label

set size  0.36, 0.487   #0.437,0.437
set origin 0.025,0.125

set key font ",15"
set key spacing 1.0
set key  at 3,3000
set xlabel font "Times-Roman, 18"     #Arial-Bold
set ylabel font "Times-Roman, 18"     #Arial-Bold
set xtics font "Times-Roman, 18"
set ytics font "Times-Roman, 18"

unset border
unset xlabel
unset ylabel
unset xtics
unset ytics

pl [5:10][-5:0]"grid_pos_10X10.dat" w p pt 6 ps 0.7 lw 1.5 lc rgb "#7f7f7f" title "","bond_time10_p0.2.dat" w l lw 1.5 lc rgb "red" title ""



unset key
unset title
unset xlabel
unset ylabel
unset xtics
unset ytics
unset log
unset label
set size 0.36,0.487
set origin 0.6,0.13

set key font ",15"
set key spacing 1.0
set key  at 3,3000
set xlabel font "Times-Roman, 18"     #Arial-Bold
set ylabel font "Times-Roman, 18"     #Arial-Bold
set xtics font "Times-Roman, 18"
set ytics font "Times-Roman, 18"
unset border
unset xlabel
unset ylabel
unset xtics
unset ytics

pl [3:8][-4:1]"grid_pos_10X10.dat" w p pt 6 lw 1.5 lc rgb "#7f7f7f" title "","bond_time10_p0.9.dat"  w l lw 1.5 lc rgb "red" title ""
