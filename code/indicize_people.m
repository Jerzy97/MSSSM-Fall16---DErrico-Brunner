function [ empty_cell_position , citizens_cell_position, cops_cell_position, rebels_cell_position ] = indicize_people( M )
% This function creates four arrays 
% - empty_cell_position : containing all the cell numbers that are free
% - citizens_cell_position : containing all the cell numbers that are
% occupied by a quiet citizen
% - cops_cell_position : containing all the cell numbers that are occupied
% by a cop
% - rebels_cell_position : containing all the cell numbers that are
% occupied by a rebel
empty_cell_position = [];
citizens_cell_position = [];
cops_cell_position = [];
rebels_cell_position = [];

for i=1:size(M, 2)
    switch M(2,i) % let's check identification value
        case 0 % we have an empty cell
            empty_cell_position(end+1) = i;
        case 1 % we have a citizen
                citizens_cell_position(end+1) = i;
        case 2 % we have a cop
            cops_cell_position(end+1) = i;
        case 3 % rebell
            rebels_cell_position(end+1) = i;
    end
end
end

