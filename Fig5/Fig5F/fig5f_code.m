clear all;
close all;
clc;

data = load('fig5d_examplenetworkfile_a1_0.2_b1_0.1_a2_0_run1.out');

Nmito = 50;

datanew = data;

for i=(Nmito+1):length(datanew(:,1))
    replacefrom = datanew(i,2);
    replaceto = datanew(i,1);
    for j=1:length(datanew(:,1))
        if(datanew(j,1) == replacefrom)
            datanew(j,1) = replaceto;
        end
        if(datanew(j,2) == replacefrom)
            datanew(j,2) = replaceto;
        end
    end
end

for i=1:(2*Nmito)
    foundnum(i) = 0;
    countnum(i) = 0;
    for j=1:Nmito
        if(datanew(j,1) == i)
            foundnum(i) = 1;
            countnum(i) = countnum(i) + 1;
        end
        if(datanew(j,2) == i)
            foundnum(i) = 1;
            countnum(i) = countnum(i) + 1;
        end
    end
end

for i=1:(2*Nmito)
    mapnum(i) = sum(foundnum(1:i));
end

for i=1:Nmito
    datakeep(i,1) = mapnum(datanew(i,1));
    datakeep(i,2) = mapnum(datanew(i,2));
end


numnodes = max(max(datakeep));
for i=1:numnodes
    nodedegree(i) = 0;
    for j=1:length(datakeep(:,1))
        if((datakeep(j,1) == i) || (datakeep(j,2) == i))
            nodedegree(i) = nodedegree(i) + 1;
        end
    end
end

numonedegree = length(find(nodedegree == 1));

partners(1:numnodes) = 0;
for i=1:numnodes
    %i
    if(nodedegree(i) == 1)
        i1 = find(datakeep(:,1)==i,1);
        i2 = find(datakeep(:,2)==i,1);

        if(length(i1) == 0)
            ihere(i) = i2;
            col(i) = 1;
        elseif(length(i2) == 0)
            ihere(i) = i1;
            col(i) = 2;
        else
            ihere(i) = min(i1,i2);
            if(i1 < i2)
                ihere(i) = i1;
                col(i) = 2;
            else
                ihere(i) = i2;
                col(i) = 1;
            end
        end

        if(nodedegree(datakeep(ihere(i),col(i))) == 1)
            partners(i) = numonedegree - 2;
        else
            partners(i) = numonedegree - 1;
        end
    end
end

partners_all = sum(partners);
partners_all_norm = partners_all/(2*Nmito*(2*Nmito-2))