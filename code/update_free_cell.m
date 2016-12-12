function [ M, J ] = update_free_cell(M, J, index, FreeCells, perc_cops, perc_occupied, CI, PI, threshold)
% Update scheme for a free cell -> 3 options
% 1. A new citizne is born
% 2. A prisoner is coming out of jail
% 3. Nothing happens

% Setting birth Rate
PBirth = 0.05*FreeCells/size(M,2);

% Probability to come out of jail
PJail=0.05;
            
distr = rand;

if distr<PBirth
    M(2:end, index)=generate_actor(perc_cops, perc_occupied, CI, PI, threshold);
    
elseif distr<(PBirth+PJail) && size(J, 2)>1
    M(2:end, index)=J(:,end);
    J=J(:,1:(end-1));
end

end