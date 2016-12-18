function [ M, J, REB ] = update_cop(M, J, REB, index, CI)

cop = M(2:end, index);
GridSize = round(sqrt(size(M, 2)));

% Check Age - maybe die
if cop(2)==0
    M(2:end, index) = zeros(7,1);
    return
else
    cop(2)=cop(2)-1;
end

% Update arresting efficiency
% The intuition behind this function is the following: The efficiency of
% cops will grow very fast with the Cop-Investment CI. However at some
% point (~0.3 -> 30% of the state's total budget will be spent on police)
% it will only converge very slow to a maximum of 80%.
% On the other hand the cops efficiency will decrease suddenly by the time
% a certain level of Active to Cop ratio is reached (~12). He will be overpowered
% by the amount of Rebels. (Described by a Sigmoid function)
% Cops will never defect!
ActiveToCopRatio = active_cop_ratio(M, index, GridSize);
cop(3) = 0.8*((1 - exp(-5*CI))-(1/(1.25 + exp(-0.5*ActiveToCopRatio + 5))));

% Put back into grid
M(2:end, index) = cop;

% Maximum Jail Time
JTimeMax = 20;

% Arrest
neighbors=find_neighbors_1st_moore(index, GridSize);
for n=1:length(neighbors)
    if (M(2, neighbors(n)) == 3) && (rand<cop(3))
         JailTime = JTimeMax*rand;
         prisoner = [M(2:end, neighbors(n)); JailTime];
         J=[prisoner J];
         % No rebel anymore
         J(1,1)=1;
         M(2:end, neighbors(n))=zeros(7,1);
         % Delete index out of REB vector
         if length(REB)>1
             REB=REB(REB~=neighbors(n));
         else
             REB=0;
         end
         % only one rebel can be arrested per round
         return
    end
end

end