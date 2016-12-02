function [ x,y ] = coordinates( cell_number, length )
% This function returns the cell coordinates given the cell number and the
% length of the square matrix
y = fix((cell_number-1)/length)+1;
x = cell_number-(y-1)*length;
end

