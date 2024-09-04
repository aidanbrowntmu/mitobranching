set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig10B.eps'


set key font ",20"
set key spacing 1.01
set key top left

labelFONT="font 'Arial, 22'"
set label font "Arial-Bold, 45"
set label font "Arial-Bold, 20"
set label '(B)' at 0.045,5500000 @labelFONT

set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 25"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"

set ylabel 'MFPT' offset -1.2,-1.2,0

set xlabel 'Connection probability p'  offset -1.0,-0.8,0
set bmargin 4.5 #/0.5
set tmargin 2.25
set lmargin 8.5
set rmargin 2


set xtics 0.2

set format y "10^{%L}"

set multiplot
set size 1.0,1.0  # main plot
set log y
pl [0.05:][200:3600000] "MFPT_prob_tau0.1_differentmass441.dat" w lp pt 4 ps 2 lw 3 lc rgb "#008000" title "","MFPT_prob_tau0.1_samemass441.dat" w l dashtype 2 lw 3 lc rgb "#008000" title "","MFPT_prob_tau0.1_samemass625.dat" w l dashtype 4 lw 3 lc rgb "#008000" title "", "MFPT_prob_tau1_differentmass441.dat" w lp pt 8 ps 2 lw 3 lc rgb "#0000FF" title "","MFPT_prob_tau1_samemass441.dat" w l dashtype 2 lw 3 lc rgb "#0000FF" title "","MFPT_prob_tau0.1_samemass625.dat" w l dashtype 4 lw 3 lc rgb "#0000FF" title "","MFPT_prob_tau100_differentmass441.dat" w lp pt 10 ps 2 lw 3 lc rgb "#00FFFF" title "","MFPT_prob_tau100_samemass441.dat" w l dashtype 2 lw 3 lc rgb "#00FFFF" title "","MFPT_prob_tau100_samemass625.dat" w l dashtype 4 lw 3 lc rgb "#00FFFF" title "" 

unset key
unset title
unset xlabel
unset ylabel
unset label
unset xtics
unset ytics
unset log
unset format y
set size 0.54,0.58
set origin 0.41,0.36

set key font ",15"
set key spacing 1.10
set xlabel font "Times-Roman, 18"     #Arial-Bold
set ylabel font "Times-Roman, 18"     #Arial-Bold

set xtics font "Times-Roman, 18"
set ytics font "Times-Roman, 18"

set ytics 1
set xtics 0.2

set xlabel 'Connection probability p'  offset 1.0,0.2,0
set ylabel 'Lattice spacing' offset 0.1,0,0
pl[0:1.05][0.7:] "spacing_mass441.dat" w lp pt 6 ps 1.5 lw 2 lc rgb "red" title "mass=441", "spacing_mass625.dat" w lp pt 12 ps 1.5 lw 2 lc rgb "#4B0082" title "mass=625",1 w l dashtype 2 lw 3 lc rgb "black" title ""

