function [ M ] = create_initial_matrix(GridSize, perc_cops , perc_occupied, CI, PI, threshold, taxes)

% characterize each cell
CellNumber = GridSize*GridSize;
M=zeros(8, CellNumber);
for i=1:CellNumber
    M(:,i)=[i;generate_actor(M, i, perc_cops, perc_occupied, CI, PI, threshold, taxes)];
end
end




