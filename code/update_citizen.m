function [ M ] = update_citizen(M, index, threshold)
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

% define hardship from government H
citizen(3)=rand;
% define legitimacy of government L  ---> now set it random
%citizen(4)=rand;
% define grievance G
citizen(5)=citizen(3)*(1-citizen(4));
% the agent's risk aversion is set for a lifetime
% define agent's net risk N
citizen(7)=citizen(6)*P;
% define state
if (citizen(5)-citizen(7))<threshold
    citizen(1)=1;
else
    citizen(1)=3;
end
% update matrix
M(2:end, index) = citizen;

end