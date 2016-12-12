function [ E, CITQUIET, COP, REB ] = indicize_people( M )
% This function creates four arrays 
% - E : containing all the cell numbers that are free
% - CITQUIET : containing all the cell numbers that are
% occupied by a quiet citizen
% - COP : containing all the cell numbers that are occupied
% by a cop
% - REB : containing all the cell numbers that are
% occupied by a rebel
E = [];
CITQUIET = [];
COP = [];
REB = [];

for i=1:size(M, 2)
    switch M(2,i) % let's check identification value
        case 0 % we have an empty cell
            E(end+1) = i;
        case 1 % we have a citizen
            CITQUIET(end+1) = i;
        case 2 % we have a cop
            COP(end+1) = i;
        case 3 % rebell
            REB(end+1) = i;
    end
end

% Exception for empty vectors (would cause error)
if isempty(E)
    E = 0;
end
if isempty(CITQUIET)
    CITQUIET = 0;
end
if isempty(COP)
    COP = 0;
end
if isempty(REB)
    REB = 0;
end

end

