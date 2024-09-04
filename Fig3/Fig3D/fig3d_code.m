clear all;
close all;
clc;

%maxd = 4;
maxd = 2;

data = load('fig3d_examplenetworkfile_maxd4.dat');

x_1 = mod(data(:,1)-1,21) + 1;
x_2 = mod(data(:,2)-1,21) + 1;
y_1 = floor((data(:,1)-1)/21) + 1;
y_2 = floor((data(:,2)-1)/21) + 1;

countarray(1:21,1:21) = 0;
for i=1:length(x_1)
    xi = x_1(i);
    yi = y_1(i);
    countarray(xi,yi) = countarray(xi,yi) + 1;

    xi = x_2(i);
    yi = y_2(i);
    countarray(xi,yi) = countarray(xi,yi) + 1;
end

%check if each bond exists
%bond_exists(1:840) = -1;
bond_exists(1:840) = 0;
imax = length(countarray(:,1));
jmax = length(countarray(1,:));

for i=1:(imax-1)
    for j=1:jmax
        bi = (j-1)*20 + i;
        for k = 1:length(x_1)
            if((x_1(k) == i) && (x_2(k) == (i+1)) && (y_1(k) == j) && (y_2(k) == j))
                bond_exists(bi) = 1;
            elseif((x_2(k) == i) && (x_1(k) == (i+1)) && (y_2(k) == j) && (y_1(k) == j))
                bond_exists(bi) = 1;
            end
        end
    end
end

for j=1:(jmax-1)
    for i=1:imax
        bi = 420 + (i-1)*20 + j;
        for k = 1:length(x_1)
            if((x_1(k) == i) && (x_2(k) == i) && (y_1(k) == j) && (y_2(k) == (j+1)))
                bond_exists(bi) = 1;
            elseif((x_2(k) == i) && (x_1(k) == i) && (y_2(k) == j) && (y_1(k) == (j+1)))
                bond_exists(bi) = 1;
            end
        end
    end
end

poss_connects = 0;
for i=1:(imax-1)
    for j=1:jmax
        bi = (j-1)*20 + i;
        if(bond_exists(bi) == 0)
            if((countarray(i,j) < maxd) && (countarray(i+1,j) < maxd))
                poss_connects = poss_connects + 1;
            end
        end
    end
end

for j=1:(jmax-1)
    for i=1:imax
        bi = 420 + (i-1)*20 + j;
        if(bond_exists(bi) == 0)
            if((countarray(i,j) < maxd) && (countarray(i,j+1) < maxd))
                poss_connects = poss_connects + 1;
            end
        end
    end
end

countcheck = sum(bond_exists) + poss_connects;

fraction = poss_connects/840;