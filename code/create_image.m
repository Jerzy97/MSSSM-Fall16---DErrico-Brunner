function [ ] = create_image( M )
% This function plots an image given the length x 10 matrix describing all
% the citizens in the grid, according to the color code:

% STATE              IDENTITY_NUMBER  COLOR     RED   GREEN   BLUE
% empty cell         1                white     255   255     204
% inactive citizen   2                blue      0     153     153
% cop                3                green     76    153     0
% active citizen     4                red       204   0       0

% extract the size of the grid
length=sqrt(max(size(M)))
massimo = max(size(M))
% create color map
MAP = [255 255 255; 0 0 255; 0 255 0; 255 0 0]/255;

% create matrix describing the grid
GRID = zeros(length)
for i=1:1:max(size(M))
    [x,y] = coordinates(i,length)
    switch M(2,i) % check cell state 0-empty/ 1-citizen/ 2-cop
        case 0
            GRID(x,y)=1;
        case 1
            switch M(9,i) % check if citizen is an active rebel 0-quiet/ 1-rebel
                case 0
                    GRID(x,y)=2;
                case 1
                    GRID(x,y)=4;
            end
        case 2
            GRID(x,y)=3;
    end
end

clf
colormap(MAP)
image(GRID)

end


%GRID(mod(i,length),floor(i/length))=M(i,2)+1;

