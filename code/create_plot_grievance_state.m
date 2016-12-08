function  create_plot_grievance_state( M )
% This function plots the level of grievance f each agent in addition to
% the state. Colourcode:

% STATE              IDENTITY_NUMBER  COLOR     RED   GREEN   BLUE
% empty cell         1                white     255   255     204
% inactive citizen   2                blue      0     153     153
% cop                3                green     76    153     0
% active citizen     4                red       204   0       0

% extract the size of the grid
GridSize=sqrt(size(M,2));

% create color map
MapState = [255 255 255; 0 0 255; 0 255 0; 255 0 0]/255;
% MapGrievance = [linspace(1, 0, 64)' zeros(64, 2)];
% In order for the cops to be colored green and empty spots white
% MapGrievance(2,:)=[1 1 1];
MapGrievance(1:100,:) = [zeros(100,1) ones(100,1) zeros(100,1)];
MapGrievance(101:199,:) = ones(99,3);
MapGrievance(200:300,:) = [linspace(1, 0, 101)' zeros(101, 2)];

% create matrices describing each agent's state and grievance
GridState = zeros(GridSize);
GridGrievance = zeros(GridSize);
for i=1:size(M, 2)
    [x,y] = coordinates(i, GridSize);
    GridState(y, x) = M(2, i) + 1;
    if M(6, i) == -1
        GridGrievance(y, x) = 0;
    elseif M(6, i) == 0
        GridGrievance(y, x) = 150;
    else
        GridGrievance(y, x) = 100*M(6, i)+200;
    end
end

clf
x1 = subplot(1, 2, 1);
colormap(x1, MapState)
image(GridState)

x2 = subplot(1, 2, 2);
% caxis defines the range for the colormap
% Guarantees an absolute scale
caxis([-150 150])
colormap(x2, MapGrievance)
image(GridGrievance)

end