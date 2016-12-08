function [ n ] = cell_number( x,y,GridSize )
% given the coordinates this function gives the cell number back
% x and y are the coordinates
% size is the size of the grid (ex.: size=100 -> grid is 100x100)
n = GridSize*(y-1)+x;
end