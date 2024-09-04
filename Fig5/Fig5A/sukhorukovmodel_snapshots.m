clear all;
close all;
clc;
rng("shuffle");

mitonum = 50;
fusionrateperendpair = 10.0;
fissionrateperpair = 0.1;

fusionrateperendside = 0.01;
fissionrateperendside = ((3/2)*fissionrateperpair);
diffusionrate = 1;
tau = 1/(fusionrateperendpair + fissionrateperpair);
end1_numattached(1:mitonum) = 0;

end1_firstbond(1:mitonum) = -1;
end2_firstbond(1:mitonum) = -1;
end1_othermitoend_firstbond(1:mitonum) = -1;
end2_othermitoend_firstbond(1:mitonum) = -1;

end1_secondbond(1:mitonum) = -1;
end2_secondbond(1:mitonum) = -1;
end1_othermitoend_secondbond(1:mitonum) = -1;
end2_othermitoend_secondbond(1:mitonum) = -1;

numruns = 1;

% end1_firstbond(1) = 2;    %end1 of 2nd mito is going to fuse with 3rd mito
% end1_othermitoend_firstbond(1) = 1;%2; %fused to end2 of other mito
% 
% % end1 of 2nd mito is going to fuse with 2nd end of 3rd mito
% 
% end1_firstbond(2) = 1;  %end2 of 3nd mit0 is going to fuse with 2nd mit
% end1_othermitoend_firstbond(2) = 1; %fused to end1 of other mito
% 
% end2_firstbond(3) = 4;
% end2_othermitoend_firstbond(3) = 2;
% end2_firstbond(4) = 3;
% end2_othermitoend_firstbond(4) = 2;

%======================================
% end1_firstbond(6) = 7;
% end1_othermitoend_firstbond(6) = 1;
% end1_firstbond(7) = 6;
% end1_othermitoend_firstbond(7) = 1;
% 
% end1_secondbond(6) = 8;
% end1_othermitoend_secondbond(6) = 1;
% end1_secondbond(7) = 8;
% end1_othermitoend_secondbond(7) = 1;
% 
% end1_firstbond(8) = 6;
% end1_othermitoend_firstbond(8) = 1;
% end1_secondbond(8) = 7;
% end1_othermitoend_secondbond(8) = 1;

%=========================================
% end2_firstbond(9) = 10;
% end2_othermitoend_firstbond(9) = 2;
% end2_firstbond(10) = 9;
% end2_othermitoend_firstbond(10) = 2;
% 
% end2_secondbond(9) = 11;
% end2_othermitoend_secondbond(9) = 2;
% end2_secondbond(10) = 11;
% end2_othermitoend_secondbond(10) = 2;
% 
% end2_firstbond(11) = 9;
% end2_othermitoend_firstbond(11) = 2;
% end2_secondbond(11) = 10;
% end2_othermitoend_secondbond(11) = 2;
%====================================
%location = floor(rand()*mitonum) + 1;

maxtime_list = linspace(1,1,1);
%for mi=1:length(maxtime_list) 
 for ri=1:numruns
    location = floor(rand()*mitonum) + 1;
    location_target = floor(rand()*mitonum) + 1;

    maxtime = 1;%1e6;%maxtime_list(mi);
    t = 0;
    found_target = 0;
    relaxed = 0;
    started = 0;
%while(t < maxtime)
 while((found_target == 0) || (relaxed == 0))
   totalendsunfused = 0;
   totalendsunfused_mito(1:mitonum) = 0;
   totalendsfused = 0;
   totalendsfused_mito(1:mitonum) = 0;

   totalendsidesunfused = 0;
   totalendsidesunfused_mito(1:mitonum) = 0;
   totalendsidesfused = 0;
   totalendsidesfused_mito(1:mitonum) = 0;

%===========  count unfused and fused ends for tip-to-tip fusion/fission ==============
  for i=1:mitonum
    totalendsunfused_mito(i) = 0;
    totalendsfused_mito(i) = 0;

    if(end1_firstbond(i) < 0)
        for j=(i+1):mitonum
            if(end1_firstbond(j) < 0)
                totalendsunfused = totalendsunfused + 1;
                totalendsunfused_mito(i) = totalendsunfused_mito(i) + 1;
            end

            if(end2_firstbond(j) < 0)
                totalendsunfused = totalendsunfused + 1;
                totalendsunfused_mito(i) = totalendsunfused_mito(i) + 1; 
            end
        end
    elseif((end1_firstbond(i) < 0) && (end1_secondbond(i) > 0) || (end1_firstbond(i) > 0) && (end1_secondbond(i) < 0))
        totalendsfused_mito(i) = totalendsfused_mito(i) + 1;
        totalendsfused = totalendsfused + 1;
    end


    if(end2_firstbond(i) < 0)
        for j=(i+1):mitonum
            if(end1_firstbond(j) < 0)
                totalendsunfused = totalendsunfused + 1;
                totalendsunfused_mito(i) = totalendsunfused_mito(i) + 1;
            end
            if(end2_firstbond(j) < 0)
                totalendsunfused = totalendsunfused + 1;
                totalendsunfused_mito(i) = totalendsunfused_mito(i) + 1;
            end
        end
        
    elseif((end2_firstbond(i) > 0) && (end2_secondbond(i) < 0) || (end2_firstbond(i) < 0) && (end2_secondbond(i) > 0))
        totalendsfused_mito(i) = totalendsfused_mito(i) + 1;
        totalendsfused = totalendsfused + 1;
    end
 end

totalendsfused = totalendsfused/2;

%================ count unfused and fused ends for tip-to-side fusion/fission ===========================
   total_endtoendonlypairs = 0;
   total_endtoendonlypairs_mito(1:mitonum) = 0;
   total_tiptosidecandidates = 0;
   total_tiptosidecandidates_mito(1:mitonum) = 0;
   total_threewayjunctions = 0;
   total_threewayjunctions_mito(1:mitonum) = 0;
for i=1:mitonum
    total_endtoendonlypairs_mito(i) = 0;
    total_tiptosidecandidates_mito(i) = 0;
    total_threewayjunctions_mito(i) = 0;

    if((end1_firstbond(i) > 0) && (end1_secondbond(i) < 0))
        total_endtoendonlypairs = total_endtoendonlypairs + 1;
        total_endtoendonlypairs_mito(i) = total_endtoendonlypairs_mito(i) + 1;
       % i,total_endtoendonlypairs
        for j=1:mitonum
            if((j ~= end1_firstbond(i)) && (j ~= end2_firstbond(i)) && (j ~= end2_secondbond(i)) && (j~=i))
                if(end1_firstbond(j) < 0)
                    total_tiptosidecandidates = total_tiptosidecandidates + 1;
                    total_tiptosidecandidates_mito(i) = total_tiptosidecandidates_mito(i) + 1;
                end

                if(end2_firstbond(j) < 0)
                    total_tiptosidecandidates = total_tiptosidecandidates + 1;
                    total_tiptosidecandidates_mito(i) = total_tiptosidecandidates_mito(i) + 1;
                end
            end  
            
        end
    elseif ((end1_firstbond(i) > 0) && (end1_secondbond(i) > 0))
        total_threewayjunctions = total_threewayjunctions + 1;
        total_threewayjunctions_mito(i) = total_threewayjunctions_mito(i) + 1;
    end


    if((end2_firstbond(i) > 0) && (end2_secondbond(i) < 0))
        total_endtoendonlypairs = total_endtoendonlypairs + 1;
        total_endtoendonlypairs_mito(i) = total_endtoendonlypairs_mito(i) + 1;
        for j=1:mitonum
            if((j ~= end2_firstbond(i)) && (j ~= end1_firstbond(i)) && (j ~= end1_secondbond(i)) && (j~=i))
                if(end1_firstbond(j) < 0)
                    total_tiptosidecandidates = total_tiptosidecandidates + 1;
                    total_tiptosidecandidates_mito(i) = total_tiptosidecandidates_mito(i) + 1;
                end

                if(end2_firstbond(j) < 0)
                    total_tiptosidecandidates = total_tiptosidecandidates + 1;
                    total_tiptosidecandidates_mito(i) = total_tiptosidecandidates_mito(i) + 1;               
                end
            end
            
        end
    elseif ((end2_firstbond(i) > 0) && (end2_secondbond(i) > 0))
        total_threewayjunctions = total_threewayjunctions + 1;
        total_threewayjunctions_mito(i) = total_threewayjunctions_mito(i) + 1;
    end
end

total_endtoendonlypairs = total_endtoendonlypairs/2;
total_threewayjunctions = total_threewayjunctions/3;
total_tiptosidecandidates = total_tiptosidecandidates/2;


total_rate = totalendsunfused*fusionrateperendpair + totalendsfused*fissionrateperpair + total_tiptosidecandidates*fusionrateperendside + total_threewayjunctions*fissionrateperendside + diffusionrate;
Delta_t = (1/total_rate)*log(1/rand());
t = t + Delta_t;

%================relaxation of the network============================
if((t > 10*tau) && (started == 0))
%location = floor(rand()*mitonum) + 1;
%location
found_target = 0 ;
relaxed = 1;
t = Delta_t;
started = 1;
end

%================================================================

%if(t < maxtime)
pickedaprocess = 0;
cum_rate = 0;
ran_num = rand();
%======================================================================

cum_rate = cum_rate + totalendsunfused*fusionrateperendpair;
if((ran_num < (cum_rate/total_rate)) && (pickedaprocess == 0))
 %   disp('picked fusion');
    %fprintf('time = %d',t);
    pickedaprocess = 1;
    %pick a mitochondria for first side of pair
    ran_num2 = rand();
    for i=1:mitonum
        cum_pairs(i) = sum(totalendsunfused_mito(1:i))/totalendsunfused;
    end
    selectedmito1 = -1;
    for i=1:mitonum
        if((cum_pairs(i) > ran_num2) && (selectedmito1 < 0))
            selectedmito1 = i;   %select mito1 which is going to fuse
        end
    end
    
    
    %pick mitochondria end for first side of pair
    if((end1_firstbond(selectedmito1) == -1) && (end2_firstbond(selectedmito1) == -1))  % if both ends of mito1 are free
        if(rand() < 0.5)           %then with 1/2 prob
            selectedend1 = 1;      % it takes 1st end
        else
            selectedend1 = 2;      % otherwise it takes 2nd end
        end
    elseif(end1_firstbond(selectedmito1) == -1)  % if only  end1 is free
        selectedend1 = 1;    % then select end1
    else                         % otherwise
        selectedend1 = 2;        % select end2
    end

  %  selectedmito1, selectedend1
%======now we have selected which end of mito1 will fuse=========== 
    %pick a mitochondria and end for second side of pair
    selectedmito2 = -1;            %select no mito has been picked
    if((end1_firstbond(selectedmito1) == -1) && (end2_firstbond(selectedmito1) == -1)) % both ends of selected mito1 are free
        denominator = totalendsunfused_mito(selectedmito1)/2; %both ends can not fuse to any end of mito2
    else
        denominator = totalendsunfused_mito(selectedmito1);
    end
    ran_num3 = rand();
    totalendscounted = 0;
    for i=(selectedmito1+1):mitonum   %check every another mito other than selected mito1
        if(end1_firstbond(i) < 0)   % if 1st end of mito 2 is free
            totalendscounted = totalendscounted + 1;
            if((ran_num3 < totalendscounted/denominator) && (selectedmito2 < 0)) %choose the process of choosing 'i' as the second mito
                selectedmito2 = i;   %if process passes i is the mito2
                selectedend2 = 1;    % selected end of mito2 is 1
            end
        end
        if(end2_firstbond(i) < 0)   %if 2st end of mito 2 is free
            totalendscounted = totalendscounted + 1;
            if((ran_num3 < totalendscounted/denominator) && (selectedmito2 < 0))
                selectedmito2 = i;
                selectedend2 = 2; % otherwise selected end of mito2 is 2
            end
        end
    end
    

%======================================================================    
    if(selectedend1 == 1)
        end1_firstbond(selectedmito1) = selectedmito2;                
        end1_othermitoend_firstbond(selectedmito1) = selectedend2;   
    else
        end2_firstbond(selectedmito1) = selectedmito2;               
        end2_othermitoend_firstbond(selectedmito1) = selectedend2;  
    end
    
    if(selectedend2 == 1)
        end1_firstbond(selectedmito2) = selectedmito1;                
        end1_othermitoend_firstbond(selectedmito2) = selectedend1;  
    else
        end2_firstbond(selectedmito2) = selectedmito1;
        end2_othermitoend_firstbond(selectedmito2) = selectedend1;
    end
   % selectedmito2, selectedend2
end          %end if for fusion

%========================pick fission process============================ 
cum_rate = cum_rate + totalendsfused*fissionrateperpair;
    if((ran_num < (cum_rate/total_rate)) && (pickedaprocess == 0))
 %   disp('picked fission');
        

  %  fprintf('time = %d',t);
        pickedaprocess = 1;
     %do fission
     %pick a mitochondria for first side of fused pair
    ran_num4 = rand();
    for i=1:mitonum
      cum_fission_pairs(i) = sum(totalendsfused_mito(1:i))/(2*totalendsfused);
    end
    
    selectedmito1_fission = -1;
    for i=1:mitonum
        if((cum_fission_pairs(i) > ran_num4) && (selectedmito1_fission < 0))
            selectedmito1_fission = i;
                        
        end
    end
    
 %pick mitochondria end for first side of pair to unfuse

    if((end1_firstbond(selectedmito1_fission) > 0) && (end1_secondbond(selectedmito1_fission) < 0) && (end2_firstbond(selectedmito1_fission) > 0) && (end2_secondbond(selectedmito1_fission) < 0))
         if(rand() < 0.5)       
             selectedend1_fission = 1;      

         else
             selectedend1_fission = 2;
         end
    elseif((end1_firstbond(selectedmito1_fission) > 0) && (end1_secondbond(selectedmito1_fission) < 0))
         selectedend1_fission = 1;
     else
         selectedend1_fission = 2;

     end


   % if((end1_firstbond(selectedmito1_fission) > 0) && (end2_firstbond(selectedmito1_fission) > 0))
   %      if(rand() < 0.5)           
   %          selectedend1_fission = 1;      
   %      else
   %          selectedend1_fission = 2;
   %      end
   %     elseif(end1_firstbond(selectedmito1_fission) > 0) 
   %      selectedend1_fission = 1;
   %    else
   %      selectedend1_fission = 2;
   %  end

  
 %  selectedmito1_fission, selectedend1_fission
    if(selectedend1_fission == 1)
        selectedmito2_fission = end1_firstbond(selectedmito1_fission);
        selectedend2_fission = end1_othermitoend_firstbond(selectedmito1_fission);
        end1_firstbond(selectedmito1_fission) = -1;
        end1_othermitoend_firstbond(selectedmito1_fission) = -1;


    else
        selectedmito2_fission = end2_firstbond(selectedmito1_fission);
        selectedend2_fission = end2_othermitoend_firstbond(selectedmito1_fission);
        end2_firstbond(selectedmito1_fission) = -1;
        end2_othermitoend_firstbond(selectedmito1_fission) = -1;
    end

    if(selectedend2_fission == 1)
        selectedmito1_fission = end1_firstbond(selectedmito2_fission);
        selectedend1_fission = end1_othermitoend_firstbond(selectedmito2_fission);
        end1_firstbond(selectedmito2_fission) = -1;
        end1_othermitoend_firstbond(selectedmito2_fission) = -1;

    else
        selectedmito1_fission = end2_firstbond(selectedmito2_fission);
        selectedend1_fission = end2_othermitoend_firstbond(selectedmito2_fission);
        end2_firstbond(selectedmito2_fission) = -1;
        end2_othermitoend_firstbond(selectedmito2_fission) = -1;
    end
    
   %selectedmito2_fission, selectedend2_fission        
    end           % end if for fission


%+++++++++++++++++pick tip-to-side fusion +++++++++++++++++++++++++++++++++++++++++++++
    cum_rate = cum_rate + total_tiptosidecandidates*fusionrateperendside;
if((ran_num < (cum_rate/total_rate)) && (pickedaprocess == 0))
   % disp('picked tip-to-side fusion');
   % fprintf('time = %d',t);
    pickedaprocess = 1;

    %pick a mitochondria for side to fuse
    ran_num5 = rand();
    for i=1:mitonum
        cum_sidefusion_pairs(i) = sum(total_tiptosidecandidates_mito(1:i))/(2*total_tiptosidecandidates);
    %cum_sidefusion_pairs(i) = sum(total_endtoendonlypairs_mito(1:i))/total_endtoendonlypairs;
    end

    selectedmito1_sideunfused = -1;
    for i=1:mitonum
        if((cum_sidefusion_pairs(i) > ran_num5) && (selectedmito1_sideunfused < 0))
          selectedmito1_sideunfused = i;   %select mito1 which is going to fuse  
        end
    end

    %pick mitochondria end for first side of pair to fuse
    if((end1_firstbond(selectedmito1_sideunfused) > 0) && (end1_secondbond(selectedmito1_sideunfused) < 0) && (end2_firstbond(selectedmito1_sideunfused) > 0) && (end2_secondbond(selectedmito1_sideunfused) < 0))  % if both ends of mito1 are free
        if(rand() < 0.5)           %then with 1/2 prob
            selectedend1_sideunfused = 1;      % it takes 1st end
        else
            selectedend1_sideunfused = 2;      % otherwise it takes 2nd end
        end
    elseif((end1_firstbond(selectedmito1_sideunfused) < 0) || ((end1_firstbond(selectedmito1_sideunfused) > 0) && (end1_secondbond(selectedmito1_sideunfused) > 0)))  % if only  end1 is free
           selectedend1_sideunfused = 2;    % then select end1
    else                         % otherwise
           selectedend1_sideunfused = 1;        % select end2   
    end

%selectedmito1_sideunfused,  selectedend1_sideunfused

% choose the end from already end-to-end fused mitos
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    %pick a mitochondria end for side-fusion
    selectedmito2_sideunfused = -1;            % no second mito has been picked to side fuse

    denominator = total_tiptosidecandidates_mito(selectedmito1_sideunfused);
    denominator = 0;
    if((end1_firstbond(selectedmito1_sideunfused) > 0) && (end1_secondbond(selectedmito1_sideunfused) < 0) && (end2_firstbond(selectedmito1_sideunfused) > 0) && (end2_secondbond(selectedmito1_sideunfused) < 0)) % both ends of selected mito1 are free
        denominator = total_tiptosidecandidates_mito(selectedmito1_sideunfused)/2;
    else
        denominator = total_tiptosidecandidates_mito(selectedmito1_sideunfused);
    end
    
   
    ran_num6 = rand();
    total_tiptosidecandidates_counted = 0;
    for i=1:mitonum
        if(selectedend1_sideunfused == 1)
            if((i~=selectedmito1_sideunfused) && (i~= end1_firstbond(selectedmito1_sideunfused)) && (i~= end2_firstbond(selectedmito1_sideunfused)) && (i~= end2_secondbond(selectedmito1_sideunfused)))
                if(end1_firstbond(i) < 0)   
                    total_tiptosidecandidates_counted = total_tiptosidecandidates_counted + 1;
                    if((ran_num6 < (total_tiptosidecandidates_counted/denominator)) && (selectedmito2_sideunfused < 0)) %choose the process of choosing 'i' as the second mito
                        selectedmito2_sideunfused = i;   
                        selectedend2_sideunfused = 1;    
                    end
                end
                if(end2_firstbond(i) < 0)   
                    total_tiptosidecandidates_counted = total_tiptosidecandidates_counted + 1;
                    if((ran_num6 < (total_tiptosidecandidates_counted/denominator)) && (selectedmito2_sideunfused < 0)) %choose the process of choosing 'i' as the second mito
                        selectedmito2_sideunfused = i;   
                        selectedend2_sideunfused = 2;    
                    end
                end
            end
        end

        if(selectedend1_sideunfused == 2)
            if((i~=selectedmito1_sideunfused) && (i~= end2_firstbond(selectedmito1_sideunfused)) && (i~= end1_firstbond(selectedmito1_sideunfused)) && (i~= end1_secondbond(selectedmito1_sideunfused)))
                if(end1_firstbond(i) < 0)   
                    total_tiptosidecandidates_counted = total_tiptosidecandidates_counted + 1;
                    if((ran_num6 < (total_tiptosidecandidates_counted/denominator)) && (selectedmito2_sideunfused < 0)) %choose the process of choosing 'i' as the second mito
                        selectedmito2_sideunfused = i;   
                        selectedend2_sideunfused = 1;    
                    end
                end
                if(end2_firstbond(i) < 0)   
                    total_tiptosidecandidates_counted = total_tiptosidecandidates_counted + 1;
                    if((ran_num6 < (total_tiptosidecandidates_counted/denominator)) && (selectedmito2_sideunfused < 0)) %choose the process of choosing 'i' as the second mito
                        selectedmito2_sideunfused = i;   
                        selectedend2_sideunfused = 2;    
                    end
                end
            end
        end
    end
%==========================================================================
   if(selectedend1_sideunfused == 1)
       end1_secondbond(selectedmito1_sideunfused) = selectedmito2_sideunfused;                
       end1_othermitoend_secondbond(selectedmito1_sideunfused) = selectedend2_sideunfused;   
    else
        end2_secondbond(selectedmito1_sideunfused) = selectedmito2_sideunfused;               
        end2_othermitoend_secondbond(selectedmito1_sideunfused) = selectedend2_sideunfused;  
    end

    if(selectedend2_sideunfused == 1)
        end1_firstbond(selectedmito2_sideunfused) = selectedmito1_sideunfused;                
        end1_othermitoend_firstbond(selectedmito2_sideunfused) = selectedend1_sideunfused;  
    else
        end2_firstbond(selectedmito2_sideunfused) = selectedmito1_sideunfused;
        end2_othermitoend_firstbond(selectedmito2_sideunfused) = selectedend1_sideunfused;
    end
    
    %find mito initially paired with selectedmito1_sideunfused (initially
    %paired mito, ipm)
    if(selectedend1_sideunfused == 1)
        ipm = end1_firstbond(selectedmito1_sideunfused);
        ipm_end = end1_othermitoend_firstbond(selectedmito1_sideunfused);
    else
        ipm = end2_firstbond(selectedmito1_sideunfused);
        ipm_end = end2_othermitoend_firstbond(selectedmito1_sideunfused);
    end
    
    if(ipm_end == 1)
        end1_secondbond(ipm) = selectedmito2_sideunfused;
        end1_othermitoend_secondbond(ipm) = selectedend2_sideunfused;  
    else
        end2_secondbond(ipm) = selectedmito2_sideunfused;
        end2_othermitoend_secondbond(ipm) = selectedend2_sideunfused;  
    end
    
    if(selectedend2_sideunfused == 1)
        end1_secondbond(selectedmito2_sideunfused) = ipm;                
        end1_othermitoend_secondbond(selectedmito2_sideunfused) = ipm_end;    
    else
        end2_secondbond(selectedmito2_sideunfused) = ipm;
        end2_othermitoend_secondbond(selectedmito2_sideunfused) = ipm_end;
    end
    
%selectedmito2_sideunfused,  selectedend2_sideunfused

end          %end if for side-fusion
%======================================================================
   
%==============================tip-to-side fission==========================================
     cum_rate = cum_rate + total_threewayjunctions*fissionrateperendside;
 if((ran_num < (cum_rate/total_rate)) && (pickedaprocess == 0))
%    disp('picked tip-to-side fission');
    pickedaprocess = 1;

    ran_num7 = rand();
    for i=1:mitonum
      cum_sidefission_pairs(i) = sum(total_threewayjunctions_mito(1:i))/(3*total_threewayjunctions);
    end
    selectedmito1_sidefused = -1;
    for i=1:mitonum
        if((cum_sidefission_pairs(i) > ran_num7) && (selectedmito1_sidefused < 0))
            selectedmito1_sidefused = i; 
        end
    end 


    if((end1_firstbond(selectedmito1_sidefused) > 0) && (end1_secondbond(selectedmito1_sidefused) > 0) && (end2_firstbond(selectedmito1_sidefused) > 0) && (end2_secondbond(selectedmito1_sidefused) > 0))
        if(rand() < 0.5)       
            selectedend1_sidefused = 1;      
            
        else
            selectedend1_sidefused = 2;
        end
    elseif((end1_firstbond(selectedmito1_sidefused) > 0) && (end1_secondbond(selectedmito1_sidefused) > 0))
        selectedend1_sidefused = 1;
    else
        selectedend1_sidefused = 2;
    end
    
  %  selectedmito1_sidefused, selectedend1_sidefused
   


      if(selectedend1_sidefused == 1)
          if(rand() < 0.5)
            selectedmito2_sidefused = end1_firstbond(selectedmito1_sidefused);
            selectedend2_sidefused = end1_othermitoend_firstbond(selectedmito1_sidefused);
            thirdmito = end1_secondbond(selectedmito1_sidefused);
            thirdmitoend = end1_othermitoend_secondbond(selectedmito1_sidefused);
          else
              selectedmito2_sidefused = end1_secondbond(selectedmito1_sidefused);
              selectedend2_sidefused = end1_othermitoend_secondbond(selectedmito1_sidefused);
              thirdmito = end1_firstbond(selectedmito1_sidefused);
              thirdmitoend = end1_othermitoend_firstbond(selectedmito1_sidefused);
              %end1_secondbond(selectedmito1_sidefused) = -1; 
          end
      else
          if (rand() < 0.5)
              selectedmito2_sidefused = end2_firstbond(selectedmito1_sidefused);
              selectedend2_sidefused = end2_othermitoend_firstbond(selectedmito1_sidefused);
              thirdmito = end2_secondbond(selectedmito1_sidefused);
              thirdmitoend = end2_othermitoend_secondbond(selectedmito1_sidefused);
              %end2_firstbond(selectedmito1_sidefused) = -1;
       %   end2_othermitoend_firstbond(selectedmito1_sidefused) = -1;
          else
           selectedmito2_sidefused = end2_secondbond(selectedmito1_sidefused);
           selectedend2_sidefused = end2_othermitoend_secondbond(selectedmito1_sidefused);
           thirdmito = end2_firstbond(selectedmito1_sidefused);
           thirdmitoend = end2_othermitoend_firstbond(selectedmito1_sidefused);
           %end2_secondbond(selectedmito1_sidefused) = -1;
          end
      end
       
      % selectedmito2_sidefused
      % selectedend2_sidefused
      % thirdmito
      % thirdmitoend
      % 
      %completely disconnect the end of the mitochondria initially picked
      if(selectedend1_sidefused == 1)
          end1_firstbond(selectedmito1_sidefused) = -1;
          end1_othermitoend_firstbond(selectedmito1_sidefused) = -1;
          end1_secondbond(selectedmito1_sidefused) = -1;
          end1_othermitoend_secondbond(selectedmito1_sidefused) = -1;
      else
          end2_firstbond(selectedmito1_sidefused) = -1;
          end2_othermitoend_firstbond(selectedmito1_sidefused) = -1;
          end2_secondbond(selectedmito1_sidefused) = -1;
          end2_othermitoend_secondbond(selectedmito1_sidefused) = -1;
      end

      %then disconnect the other 2 mitos from the mito initially picked
      
      if(selectedend2_sidefused == 1)
          if((end1_firstbond(selectedmito2_sidefused) == selectedmito1_sidefused) && (end1_othermitoend_firstbond(selectedmito2_sidefused) == selectedend1_sidefused))
              end1_firstbond(selectedmito2_sidefused) = end1_secondbond(selectedmito2_sidefused);
              end1_othermitoend_firstbond(selectedmito2_sidefused) = end1_othermitoend_secondbond(selectedmito2_sidefused);
              end1_secondbond(selectedmito2_sidefused) = -1;
              end1_othermitoend_secondbond(selectedmito2_sidefused) = -1;
          else
              end1_secondbond(selectedmito2_sidefused) = -1;
              end1_othermitoend_secondbond(selectedmito2_sidefused) = -1;
          end
      else
          if((end2_firstbond(selectedmito2_sidefused) == selectedmito1_sidefused) && (end2_othermitoend_firstbond(selectedmito2_sidefused) == selectedend1_sidefused))
              end2_firstbond(selectedmito2_sidefused) = end2_secondbond(selectedmito2_sidefused);
              end2_othermitoend_firstbond(selectedmito2_sidefused) = end2_othermitoend_secondbond(selectedmito2_sidefused);
              end2_secondbond(selectedmito2_sidefused) = -1;
              end2_othermitoend_secondbond(selectedmito2_sidefused) = -1;
          else
              end2_secondbond(selectedmito2_sidefused) = -1;
              end2_othermitoend_secondbond(selectedmito2_sidefused) = -1;
          end
      end
      
      if(thirdmitoend == 1)
          if((end1_firstbond(thirdmito) == selectedmito1_sidefused) && (end1_othermitoend_firstbond(thirdmito) == selectedend1_sidefused))
              end1_firstbond(thirdmito) = end1_secondbond(thirdmito);
              end1_othermitoend_firstbond(thirdmito) = end1_othermitoend_secondbond(thirdmito);
              end1_secondbond(thirdmito) = -1;
              end1_othermitoend_secondbond(thirdmito) = -1;
          else
              end1_secondbond(thirdmito) = -1;
              end1_othermitoend_secondbond(thirdmito) = -1;
          end
      else
          if((end2_firstbond(thirdmito) == selectedmito1_sidefused) && (end2_othermitoend_firstbond(thirdmito) == selectedend1_sidefused))
              end2_firstbond(thirdmito) = end2_secondbond(thirdmito);
              end2_othermitoend_firstbond(thirdmito) = end2_othermitoend_secondbond(thirdmito);
              end2_secondbond(thirdmito) = -1;
              end2_othermitoend_secondbond(thirdmito) = -1;
          else
              end2_secondbond(thirdmito) = -1;
              end2_othermitoend_secondbond(thirdmito) = -1;
          end
      end
      
      
       
 end

 %=======================================================================

 %======================diffusion process ==============================
cum_rate = cum_rate + diffusionrate;
selectedmito = -1;
  if((ran_num < (cum_rate/total_rate)) && (pickedaprocess == 0))
  %   disp('diffusion')
     pickedaprocess = 1;
     
     numconnected = 0;
     if(end1_firstbond(location) > 0)
         numconnected = numconnected + 1;
         connectedlist(numconnected) = end1_firstbond(location);
     end
     if(end2_firstbond(location) > 0)
         numconnected = numconnected + 1;
         connectedlist(numconnected) = end2_firstbond(location);
     end
     if(end1_secondbond(location) > 0)
         numconnected = numconnected + 1;
         connectedlist(numconnected) = end1_secondbond(location);
     end
     if(end2_secondbond(location) > 0)
         numconnected = numconnected + 1;
         connectedlist(numconnected) = end2_secondbond(location);
     end
        
     if(numconnected > 0)
         if(numconnected < 1.5)
             location = connectedlist(1);
         else
             indextopick = floor(numconnected*rand()) + 1;
             location = connectedlist(indextopick);
         end  
     end
    
  end   % end of ran_num < (cum_rate/total_rate) 'if'loop

  %===================end diffusion process===============================
 
    if((location == location_target) && (started == 1))
         found_target = 1;
         t_find(ri) = t;
        % t_find(ri), location_target
       
     end
  

  
 % else
  %        t = maxtime;

%=========================================================================
%end  % end if loop for t<maxtime loop
  end % while loop

       % file_id = fopen('search_time.txt', 'w');
       % fprintf(file_id,'%6.2f %12.8f\n',ri, t_find(ri));
       % fclose(file_id);

  mean_t = mean(t_find);

  %**********0pen & write into a file******************
 % file_id = fopen('mean_time.txt', 'w');
 % fprintf(file_id,'%6.5f %12.8f\n',fissionrateperpair, mean_t);
 % fclose(file_id);

%fprintf(file_id,'%.4f', fissionrateperpair, mean_t);
  %***************************************************
  % plot(ri,t,'.b');
  % hold on
 end % run loop
 % figure
%  plot(mean_t , '.k')
%end  % mi time loop

% attachedtomito1(1:mitonum) = 0;
% attachedtomito1(1) = 1;
% numinlist = 0;
% listattached = -1;
% if(end1_firstbond(1) > 0)
%     numinlist = numinlist + 1;
%     listattached(numinlist) = end1_firstbond(1);
% end
% if(end1_secondbond(1) > 0)
%     numinlist = numinlist + 1;
%     listattached(numinlist) = end1_secondbond(1);
% end
% if(end2_firstbond(1) > 0)
%     numinlist = numinlist + 1;
%     listattached(numinlist) = end2_firstbond(1);
% end
% if(end2_secondbond(1) > 0)
%     numinlist = numinlist + 1;
%     listattached(numinlist) = end2_secondbond(1);
% end

% count = 0;
% while(length(listattached > 0))
%     nexttocheck = listattached(1)
%     listattached
%     count = count + 1
%     if(end1_firstbond(nexttocheck) > 0)
%         if(attachedtomito1(end1_firstbond(nexttocheck)) == 0)
%             numinlist = numinlist + 1;
%             listattached(numinlist) = end1_firstbond(nexttocheck)
%         end
%     end
%     if(end1_secondbond(nexttocheck) > 0)
%         if(attachedtomito1(end1_secondbond(nexttocheck)) == 0)
%             numinlist = numinlist + 1;
%             listattached(numinlist) = end1_secondbond(nexttocheck)
%         end
%     end
%     if(end2_firstbond(nexttocheck) > 0)
%         if(attachedtomito1(end2_firstbond(nexttocheck)) == 0)
%             numinlist = numinlist + 1;
%             listattached(numinlist) = end2_firstbond(nexttocheck)
%         end
%     end
%     if(end2_secondbond(nexttocheck) > 0)
%         if(attachedtomito1(end2_secondbond(nexttocheck)) == 0)
%             numinlist = numinlist + 1;
%             listattached(numinlist) = end2_secondbond(nexttocheck)
%         end
%     end
%     attachedtomito1(nexttocheck) = 1;
%  listattached(1) = [];
%     numinlist = numinlist - 1;
% end
% 



for i=1:mitonum
    edgelist1(i) = 2*(i-1) + 1;
    edgelist2(i) = 2*(i-1) + 2;
end

for i=1:mitonum
    if(end1_firstbond(i) > 0)
        if(i < end1_firstbond(i))
            edgelist1(length(edgelist1)+1) = 2*(i-1) + 1;
            if(end1_othermitoend_firstbond(i) < 1.5)
                edgelist2(length(edgelist2)+1) = 2*(end1_firstbond(i)-1) + 1;
            else
                edgelist2(length(edgelist2)+1) = 2*(end1_firstbond(i)-1) + 2;
            end
        end
    end

    if(end2_firstbond(i) > 0)
        if(i < end2_firstbond(i))
            edgelist1(length(edgelist1)+1) = 2*(i-1) + 2;
            if(end2_othermitoend_firstbond(i) < 1.5)
                edgelist2(length(edgelist2)+1) = 2*(end2_firstbond(i)-1) + 1;
            else
                edgelist2(length(edgelist2)+1) = 2*(end2_firstbond(i)-1) + 2;
            end
        end
    end

    if(end1_secondbond(i) > 0)
        if(i < end1_secondbond(i))
            edgelist1(length(edgelist1)+1) = 2*(i-1) + 1;
            if(end1_othermitoend_secondbond(i) < 1.5)
                edgelist2(length(edgelist2)+1) = 2*(end1_secondbond(i)-1) + 1;
            else
                edgelist2(length(edgelist2)+1) = 2*(end1_secondbond(i)-1) + 2;
            end
        end
    end

    if(end2_secondbond(i) > 0)
        if(i < end2_secondbond(i))
            edgelist1(length(edgelist1)+1) = 2*(i-1) + 2;
            if(end2_othermitoend_secondbond(i) < 1.5)
                edgelist2(length(edgelist2)+1) = 2*(end2_secondbond(i)-1) + 1;
            else
                edgelist2(length(edgelist2)+1) = 2*(end2_secondbond(i)-1) + 2;
            end
        end
    end
end
f1 = fopen('edge_ends_a1_10_b1_0.1_a2_0.01.out','w');
for i=1:length(edgelist1)
    fprintf(f1,'%d %d\n', edgelist1(i),edgelist2(i));
end
    
