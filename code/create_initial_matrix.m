function [ M ] = create_initial_matrix(GridSize, perc_cops , perc_occupied, CI, PI, treshhold)

% characterize each cell
CellNumber = GridSize*GridSize;
M=zeros(8, CellNumber);
for i=1:CellNumber
    M(:,i)=[i;generate_actor(perc_cops, perc_occupied, CI, PI, treshhold)];
end
end




