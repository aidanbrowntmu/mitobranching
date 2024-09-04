set terminal postscript  eps  enhanced color solid lw 1 size 4.2, 3.2 font 'Times-Roman'
set output 'Fig2B.eps'


set key font ",21"
set key spacing 1.2
set key at 0.4,900000

labelFONT="font 'Arial, 22'"
set label '(B)' at 0.1,1500000 @labelFONT

set xlabel font "Times-Roman, 25"     #Arial-Bold
set ylabel font "Times-Roman, 25"     #Arial-Bold
set xtics font "Times-Roman, 25"
set ytics font "Times-Roman, 25"

set ylabel 'MFPT' offset -1.2,-1.2,0
set xlabel 'Connection probability p'  offset -1.0,-0.8,0
set bmargin 4.5 #/0.5
set tmargin 2.5
set lmargin 8.5
set rmargin 2


set xtics 0.2
set format y "10^{%L}"

set multiplot
set size 1.0,1.0  # main plot
set log y
pl [0.1:][250:1000000]"MFPT_prob_tau0.dat"  w lp pt 6 ps 2 lw 3 lc rgb "#8A2BE2" title "{{/Symbol t}=0}", "MFPT_prob_tau1.dat" w lp pt 8 ps 2 lw 3 lc rgb "#0000FF" title "{{/Symbol t}=1}", "MFPT_prob_tau100.dat" w lp pt 10 ps 2 lw 3 lc rgb "#00FFFF" title "{{/Symbol t}=100}"

  unset key
  unset title
  unset xlabel
  unset ylabel
  unset label
  unset xtics
  unset ytics
  unset log

  set size 0.57,0.57
  set origin 0.406,0.39

  set key font ",15"
  set key spacing 1.0
  set key at 0.05,3000
  set xlabel font "Times-Roman, 18"     #Arial-Bold
  set ylabel font "Times-Roman, 18"     #Arial-Bold

  set xtics font "Times-Roman, 18"
  set ytics font "Times-Roman, 18"
  set xtics 0.1
  set format y "10^{%L}"
  set format x "10^{%L}"

  set xlabel 'Effective diffusivity D_{eff}'  offset 1.0,0.2,0
  set ylabel 'MFPT' offset 0.1,0,0
  set key spacing 1.1
  set log 
  plot [:][:]  "search_diffusion_tau0.dat" u ($2/4):3 w p pt 6 ps 2 lw 3 lc rgb "#8A2BE2" title "","search_diffusion_tau1.dat" u ($2/4):3 w p pt 8 ps 2 lw 3 lc rgb "#0000FF" title "", "search_diffusion_tau100.dat" u ($2/4):3 w p pt 10 ps 2 lw 3 lc rgb "#00FFFF" title "", 300.0/x w l lw 3 lc rgb "black" title "\\~1/D_{eff}"
