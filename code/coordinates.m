function [ x,y ] = coordinates( cell_number, GridSize )
% This function returns the cell coordinates given the cell number and the
% length of the square matrix
y = fix((cell_number-1)/GridSize)+1;
x = cell_number-(y-1)*GridSize;
end

