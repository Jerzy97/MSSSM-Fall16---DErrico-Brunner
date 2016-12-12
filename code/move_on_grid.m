function [M, E, ACTOR] = move_on_grid(M, E, ACTOR)
% This function can be called by any actor
% If there's an empty spot -> move with given probability
% Parameters are:
% M:                 Grid
% E:                 Array containing empty cells' indices (from indicize_people)
% ACTOR:             Array containing the moving actor's group indices

% Since always the actor's last entry is updated, we know the CellIndex
index = ACTOR(end);

% Probability of moving - higher if more empty spots
Prob = 0.05;

GridSize=round(sqrt(size(M, 2)));
neighbors = find_neighbors_1st_moore(index, GridSize);

for n=1:length(neighbors)
    if (M(2, neighbors(n))==0) && (rand<Prob)
        % Swap columns
        M(2:end, [index neighbors(n)])=M(2:end, [neighbors(n) index]);
        E(E==neighbors(n))=index;
        ACTOR(end)=neighbors(n);
        return
    end
end  

end