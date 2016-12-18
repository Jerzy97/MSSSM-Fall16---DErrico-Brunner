function [ M ] = update_citizen(M, index, PI, threshold, taxes)
% Update Process for a citizen

GridSize = round(sqrt(size(M, 2)));
citizen = M(2:end, index);

% Check Age - maybe die
if citizen(2)==0
    M(2:end, index)=zeros(7,1);
    return
else
    citizen(2)=citizen(2)-1;
end
            
% Determine estimated arrest probability - Epstein
CopToActiveRatio=cop_active_ratio(M, index, GridSize);
% The constant 0.2 is chosen to ensure reasonable values
P = 1 - exp(-0.2*CopToActiveRatio);

% define legitimacy of government L
citizen(4) = PI*(1 - 100*taxes);
% define grievance G
citizen(5)=citizen(3)*(1-citizen(4));
% the agent's risk aversion is set for a lifetime
% define agent's net risk N
citizen(7)=citizen(6)*P;
% find rebels number in neighbourhood
rebelNumber=0;
neighbours = find_neighbors_1st_moore(index, GridSize);
for i=neighbours
    if M(2,i)==3
        rebelNumber = rebelNumber+1;
    end
end
% define state 
if (citizen(5)-citizen(7)+rebelNumber/8)<threshold
    citizen(1)=1;
else
    citizen(1)=3;
end
% update matrix
M(2:end, index) = citizen;

end