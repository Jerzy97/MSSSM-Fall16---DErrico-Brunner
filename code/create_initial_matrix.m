function [ M ] = create_initial_matrix(length, perc_cops , perc_occupied, CI, PI, treshhold)

% characterize each cell
fcts=[];
for i=1:length
    fcts(:,i)=[generate_actor(perc_cops, perc_occupied, CI, PI, treshhold)];
end

% define the initial matrix, first row numerated from 1 to size to address
% the cell position, second row containes the function of the actor in the cell
M = [1:length;fcts];

end




