function [ M, J ] = update_free_cell(M, J, index, FreeCells, perc_cops, perc_occupied, CI, PI, threshold, taxes, num)
% Update scheme for a free cell -> 3 options
% 1. A new citizne is born
% 2. A prisoner is coming out of jail
% 3. Nothing happens

% Setting birth Rate
PBirth = 0.05*FreeCells/size(M,2);

FreePrisoner = 0;

% Search for prisoners who served their sentence
for i=1:size(J, 2)
    if J(8, end+1-i)<=0
        FreePrisoner = size(J,2)+1-i;
        break
    end
end

% Increase the probability for a cop to be born
perc_cops = perc_cops*(1+4*(num(4)/sum(num([2 3 4]))));

distr = rand;

if distr<PBirth
    M(2:end, index)=generate_actor(M, index, perc_cops, perc_occupied, CI, PI, threshold, taxes);
    
elseif FreePrisoner ~= 0
    M(2:end, index)=J(1:7, FreePrisoner);
    J=[J(:, 1:(FreePrisoner - 1)) J(:, (FreePrisoner + 1):end)];
end

end