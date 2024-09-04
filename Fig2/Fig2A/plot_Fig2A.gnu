set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
#set terminal postscript eps color solid
set output 'Fig2A.eps'


set key font ",21"
set key spacing 1.2
set key at 0.75,1.0

set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 25"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"


labelFONT="font 'Arial, 22'"
set label '(A)' at 0.006,1.05 @labelFONT


set xlabel 'Connection probability p' offset 0,-0.2,0
set ylabel 'Effective diffusivity D_{eff}'  offset -0.5,0.6,0

   set bmargin 4 #/0.5
   set tmargin 2.5
   set lmargin 9
   set rmargin 2.0


set xtics 0.2
set ytics 0.2

set multiplot
set size 1.0,1.0  # main plot

pl "diffusion_prob_tau0.dat" u 1:($2/4) w lp pt 6 ps 2 lw 3 lc rgb "#8A2BE2" title "{/Symbol t}=0", "diffusion_prob_tau1.dat" u 1:($2/4) w lp pt 8 ps 2 lw 3 lc rgb "#0000FF" title "{/Symbol t}=1", "diffusion_prob_tau100.dat" u 1:($2/4) w lp pt 10 ps 2 lw 3 lc rgb "#00FFFF" title "{/Symbol t}=100}","diffusion_prob_tau_infinity.dat" u 1:($2/4) w lp pt 12 ps 2 lw 3 lc rgb "#00FF00" title "{{/Symbol t}={/Symbol\245}}"

  unset key
  unset title
  unset xlabel
  unset ylabel
  unset label
  unset xtics
  unset ytics
  unset log

  set size 0.36,0.46 #0.415,0.415
  set origin 0.035,0.5

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
  unset label
  unset xtics
  unset ytics
  pl [-4:1][-4:1]"grid_pos_10X10.dat" w p pt 6 ps 0.7 lw 1.5 lc rgb "#7f7f7f" title "","bond_time10_p0.2.dat" w l lw 1.5 lc rgb "red" title ""



  unset key
  unset title
  unset xlabel
  unset ylabel
  unset xtics
  unset ytics
  unset log

  set size 0.36,0.46
  set origin 0.62,0.021

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
  pl [-4:1][-4:1]"grid_pos_10X10.dat" w p pt 6 ps 0.7 lw 1.5 lc rgb "#7f7f7f" title "","bond_time10_p0.9.dat" w l lw 1.5 lc rgb "red" title ""


