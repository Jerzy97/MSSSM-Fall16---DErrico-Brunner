function [M, E, ACTOR] = move_on_grid(CellIndex, M, E, ACTOR)
% This function can be called by any actor
% If there's an empty spot -> move with given probability
% Parameters are:
% CellIndex:         Moving actor's index
% M:                 Grid
% E:                 Array containing empty cells' indices (from indicize_people)
% ACTOR:             Array containing the moving actor's group indices

% Probability of moving - higher if more empty spots
Prob = 1;

GridSize=fix(sqrt(size(M, 2)));
neighbors = find_neighbors(CellIndex, GridSize);

for i=1:length(neighbors)
    if (M(2, neighbors(i))==0) && (rand()<Prob)
        % Swap columns
        M(:, [CellIndex neighbors(i)])=M(:, [neighbors(i) CellIndex]);
        M(E==neighbors(i))=CellIndex;
        ACTOR(ACTOR==CellIndex)=neighbors(i);
        break
    end
end  

end