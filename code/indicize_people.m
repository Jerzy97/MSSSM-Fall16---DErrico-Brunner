function [ empty_cell_position , citizens_cell_position, rebels_cell_position, cops_cell_position ] = indicize_people( M )
% This function creates four arrays 
% - empty_cell_position : containing all the cell numbers that are free
% - citizens_cell_position : containing all the cell numbers that are
% occupied by a quiet citizen
% - rebels_cell_position : containing all the cell numbers that are
% occupied by a rebel
% - cops_cell_position : containing all the cell numbers that are occupied
% by a cop
empty_cell_position = [];
citizens_cell_position = [];
rebels_cell_position = [];
cops_cell_position = [];

for i=1:size(M, 2)
    switch M(2,i) % let's check identification value
        case 0 % we have an empty cell
            empty_cell_position(end+1) = i;
        case 2 % we have a cop
            cops_cell_position(end+1) = i;
        case 1 % we have a citizen
            if M(10,i) == 0
                citizens_cell_position(end+1) = i;
            else
                rebels_cell_position(end+1) = i;
            end
    end
end
end

