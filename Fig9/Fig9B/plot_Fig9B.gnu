set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig9B.eps'


set key font ",21"
set key spacing 1.1
set key at 0.6,800000

set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 25"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"

labelFONT="font 'Arial, 22'"
set label '(B)' at 0.1,1400000.0 @labelFONT



set xlabel '{/Symbol l}_{add}/({/Symbol l}_{add}+{/Symbol l}_{remove})' offset 0,-0.5,0
set ylabel 'MFPT'  offset -1.2,1,0

set bmargin 4.5 #/0.5
set tmargin 2.2
set lmargin 8.5
set rmargin 1.5


set xtics 0.2 

set format y "10^{%L}"

set multiplot
set size 1.0,1.0  # main plot

set log y 
plot [0.1:][300:] "MFPT_tau1_3connection.dat"  w l lw 4 dashtype 2 lc rgb "#0000FF" title "","MFPT_tau1_4connection.dat" w lp pt 8 ps 2 lw 3 lc rgb "#0000FF" title "", "MFPT_tau100_3connection.dat" w l lw 4 dashtype 2 lc rgb "#00FFFF" title "","MFPT_tau100_4connection.dat" w lp pt 10 ps 2 lw 3 lc rgb "#00FFFF" title ""

unset key
unset title
unset xlabel
unset ylabel
unset xtics
unset ytics
unset log
unset label
set size 0.55,0.56
set origin 0.4,0.38

set key font ",15"
set key spacing 1.05
set key  at 0.35,50000.0
set xlabel font "Times-Roman, 18"     #Arial-Bold
set ylabel font "Times-Roman, 18"     #Arial-Bold

set xtics font "Times-Roman, 18"
set ytics font "Times-Roman, 18"
set format y "10^{%L}"
set format x "10^{%L}"
set xlabel '{D_{eff}}' offset 0.7,0.1,0
set ylabel 'MFPT'  offset 0.5,0.6,0

set log
pl[:][400:] "search_diffusion_tau1.dat" u ($2/4):3 w p pt 8 lw 2 lc rgb "#0000FF" title "","search_diffusion_tau100.dat" u ($2/4):3 w p pt 10 lw 2 lc rgb "#00FFFF" title "", 250/x w l lw 2 dashtype 2 lc rgb "black" title "\\~1/D_{eff}"
