function neighbors = find_neighbors_3rd_moore(index, GridSize)
% For a given Cell Index and the Grids size,
% find the cell indizes of the neighbors
% neighbors contains the indices of the Actor's neighbors

% 3rd order Moore neighborhood
k = [1 0; -1 0; 0 1; 0 -1; 1 1; 1 -1; -1 1; -1 -1;
     2 -2; 2 -1; 2 0; 2 1; 2 2; -2 -2; -2 -1; -2 0; -2 1; -2 2;
     1 -2; 1 2; 0 -2; 0 2; -1 -2; -1 2;
     3 -3; 3 -2; 3 -1; 3 0; 3 1; 3 2; 3 3;
     -3 -3; -3 -2; -3 -1; -3 0; -3 1; -3 2; -3 3;
     2 -3; 2 3; 1 -3; 1 3; 0 -3; 0 3; -1 -3; -1 3; -2 -3; -2 3];

[x,y] = coordinates(index, GridSize);
neighbors=[];

for i=1:size(k,1)
    xneigh=x+k(i,1);
    yneigh=y+k(i,2);
    if (xneigh>0) && (xneigh<=GridSize) && (yneigh>0) && (yneigh<=GridSize)
        neighbors(end+1) = cell_number(xneigh, yneigh, GridSize);
    end
end
end