set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig6.eps'


set key font ",21"
set key spacing 1.2
set key bottom right

set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 25"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"


labelFONT="font 'Arial, 21'"


set xlabel 'time' offset 0,-0.2,0
set yl  "{/Symbol \341}r^{2}{/Symbol \361}"  offset -1.0,1,0

set bmargin 4 #/0.5
set tmargin 1
set lmargin 9
set rmargin 4


set multiplot
set size 1.0,1.0  # main plot
pl [:160][:85]"diffusion_time.dat" u 1:4 w lp pt 6 ps 1.5 lw 2 lc rgb "#0000FF" title "{/Symbol \341}r^{2}{/Symbol \361}", 1.661897E+00*x+0.899 w l lw 3 lc rgb "red" title "Best fit line",36.6 w l dashtype 2 lw 3 lc rgb "black" title "Saturation/2", 73.2 w l lw 3 lc rgb "black" title "Saturation"

