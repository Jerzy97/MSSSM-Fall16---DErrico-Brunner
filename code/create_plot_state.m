function  create_plot_state( M )
% This function plots an image given the length x 10 matrix describing all
% the citizens in the grid, according to the color code:

% STATE              IDENTITY_NUMBER  COLOR     RED   GREEN   BLUE
% empty cell         1                white     255   255     204
% inactive citizen   2                blue      0     153     153
% cop                3                green     76    153     0
% active citizen     4                red       204   0       0

% extract the size of the grid
GridSize=sqrt(size(M,2));

% create color map
MAP = [255 255 255; 0 0 255; 0 255 0; 255 0 0]/255;

% create matrix describing the grid
GRID = zeros(GridSize);
for i=1:max(size(M))
    [x,y] = coordinates(i,GridSize);
    GRID(y, x) = M(2, i) + 1;
end

clf
colormap(MAP)
image(GRID)

end