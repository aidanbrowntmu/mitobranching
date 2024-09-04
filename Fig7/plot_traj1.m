clear all;
close all;

data_postime = readtable('pos_time_p0.2.dat');
data_grid = readtable('grid_pos_10X10.dat');
data_zero = readtable('zero.dat');
data_end = readtable('end_p0.2.dat');
zerox = data_zero.Var1;
zeroy = data_zero.Var2;
xpos = data_postime.Var4;
ypos = data_postime.Var5;
gridx = data_grid.Var1;
gridy = data_grid.Var2;

endx = data_end.Var1;
endy = data_end.Var2;

figure
plot(xpos,ypos,'color',[0.0 0.0 0.0],'linewidth',1);
hold on
plot(gridx,gridy,'linestyle','none','marker','o','color',[0.7 0.7 0.7],'LineWidth',1.5)
plot(zerox,zeroy, 'linestyle','none','marker','o','color',[1.0 0.0 0.0],'linewidth',2)
plot(endx,endy, 'linestyle','none','marker','o','color',[0.0 0.0 1.0],'linewidth',4)

set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])
box off
set(gca,'Visible','off')
