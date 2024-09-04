set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig2D.eps'
set key font ",21"
set key at 0.5,8700000

set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 25"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"

labelFONT="font 'Arial, 22'"
set label '(D)' at 0.12,18000000.0 @labelFONT



set xlabel '{/Symbol l}_{add}/({/Symbol l}_{add}+{/Symbol l}_{remove})' offset 0,-0.5,0
set ylabel 'MFPT'  offset -0.8,1,0

set bmargin 4.5 #/0.5
set tmargin 2.5
set lmargin 8.2
set rmargin 1.5


set xtics 0.2 
set format y "10^{%L}"

set multiplot
set size 1.0,1.0  # main plot

set log y 
plot [0.1:1.0][250:10000000] "MFPT_tau0.1_2connection.dat" w l lw 4 dashtype 2 lc rgb "#FF00FF" title "({/Symbol t}=0.1})_{degree-2}","MFPT_tau0.1_4connection.dat" w lp pt 4 ps 2 lw 3 lc rgb "#FF00FF" title "({/Symbol t}=0.1)_{degree-4}}","MFPT_tau1_2connection.dat"  w l lw 4 dashtype 2 lc rgb "#0000FF" title "({/Symbol t}=1})_{degree-2}","MFPT_tau1_4connection.dat" w lp pt 8 ps 2 lw 3 lc rgb "#0000FF" title "({/Symbol t}=1)_{degree-4}}", "MFPT_tau100_2connection.dat" w l lw 4 dashtype 2 lc rgb "#00FFFF" title "({/Symbol t}=100})_{degree-2}","MFPT_tau100_4connection.dat" w lp pt 10 ps 2 lw 3 lc rgb "#00FFFF" title "({/Symbol t}=100)_{degree-4}}"

unset key
unset title
unset xlabel
unset ylabel
unset xtics
unset ytics
unset log
unset label
set size 0.49,0.5
set origin 0.49,0.47

set key font ",15"
set key spacing 1.1
set key spacing 1.0
set key  at 0.2,300000.0
set xlabel font "Times-Roman, 18"     #Arial-Bold
set ylabel font "Times-Roman, 18"     #Arial-Bold

set xtics font "Times-Roman, 18"
set ytics font "Times-Roman, 18"
set format y "10^{%L}"
set format x "10^{%L}"
set xlabel '{D_{eff}}' offset 0.7,0.1,0
set ylabel 'MFPT'  offset 0.5,0.6,0

set log
pl[][500:]"search_diffusion_tau0.1.dat" u ($2/4):3 w p pt 4 lw 2 lc rgb "#FF00FF" title "", "search_diffusion_tau1.dat" u ($2/4):3 w p pt 8 lw 2 lc rgb "#0000FF" title "","search_diffusion_tau100.dat" u ($2/4):3 w p pt 10 lw 2 lc rgb "#00FFFF" title "", 240/x w l lw 3 dashtype 2 lc rgb "black" title "\\~1/D_{eff}"
