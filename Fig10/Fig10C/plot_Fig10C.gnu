set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig10C.eps'


set key font ",20"
set key spacing 1.12
set key at 0.64,0.4

set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 25"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"


labelFONT="font 'Arial, 22'"
set label font "Arial-Bold, 45"
set label font "Arial-Bold, 20"
set label '(C)' at 0.0,0.52 @labelFONT


set xlabel '{/Symbol l}_{add}/({/Symbol l}_{add}+{/Symbol l}_{remove})'  offset 0.0,-0.2,0
set ylabel 'Effective diffusivity D_{eff}'  offset -0.5,1,0

   set bmargin 4 #/0.5
   set tmargin 2.2
   set lmargin 10
   set rmargin 2


set xtics 0.2


set multiplot
set size 1.0,1.0  # main plot


pl [:][:0.5] "diffusion_prob_tau0.1_differentmass441.dat" u 1:($2/4) w lp pt 4 ps 2 lw 3 lc rgb "#008000" title "","diffusion_prob_tau0.1_samemass441.dat" u 1:($2/4) w l dashtype 2 lw 3 lc rgb "#008000" title "","diffusion_prob_tau0.1_samemass625.dat" u 1:($2/4) w l dashtype 4 lw 3 lc rgb "#008000" title "","diffusion_prob_tau1_differentmass441.dat" u 1:($2/4) w lp pt 8 ps 2 lw 3 lc rgb "#0000FF" title "","diffusion_prob_tau1_samemass441.dat" u 1:($2/4) w l dashtype 2 lw 3 lc rgb "#0000FF" title "", "diffusion_prob_tau1_samemass625.dat" u 1:($2/4) w l dashtype 4 lw 3 lc rgb "#0000FF" title "","diffusion_prob_tau100_differentmass441.dat" u 1:($2/4) w lp pt 10 ps 2 lw 3 lc rgb "#00FFFF" title "", "diffusion_prob_tau100_samemass441.dat" u 1:($2/4) w l dashtype 2 lw 3 lc rgb "#00FFFF" title "","diffusion_prob_tau100_samemass625.dat" u 1:($2/4) w l dashtype 4 lw 3 lc rgb "#00FFFF" title ""



  unset key
  unset title
  unset xlabel
  unset ylabel
  unset label
  unset xtics
  unset ytics
  unset log

 set size 0.35,0.41 #0.415,0.415
 set origin 0.04,0.56

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
pl [6:15][2:11]"grid_pos_20X20.dat" w p pt 6 ps 0.7 lw 1.5 lc rgb "#7f7f7f" title "","bond_topleftinset.dat" w l lw 1.5 lc rgb "red" title ""



#&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
unset key
  unset title
  unset xlabel
  unset ylabel
  unset label
  unset xtics
  unset ytics
  unset log

 set size 0.36,0.42 #0.415,0.415
 set origin 0.58,0.55

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
pl [7:12][6:11]"grid_pos_20X20.dat" w p pt 6 ps 0.7 lw 1.5 lc rgb "#7f7f7f" title "","bond_toprightinset.dat" w l lw 1.5 lc rgb "red" title ""
