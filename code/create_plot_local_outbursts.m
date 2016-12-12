function create_plot_local_outbursts(SaveM)
% This function plots the maximum local outburst per timestep
% Local means a subgrid 7x7 (3rd order Moore). On each subgrid of the total
% grid the rebels are counted and the maximum is plotted later

CellNumber = size(SaveM, 2);
GridSize = round(sqrt(CellNumber));
intervall = size(SaveM, 3);
outbursts = zeros(1, intervall);
rebels = zeros(1, CellNumber);

% Iterate through whole Simulation
for t=1:intervall
    
    % Extract current state of the Grid
    M=SaveM(:,:,t);
    
    % Iterate through grid and search for local outbursts
    for i=1:CellNumber
        neighbors = find_neighbors_3rd_moore(i, GridSize);
        rebels(i) = 0;
        for n=1:length(neighbors)
            if M(2, neighbors(n))==3
                rebels(i) = rebels(i) + 1;
            end
        end
        
        outbursts(t) = max(rebels);
    end
end

f=figure;
% Plot results
p=plot(1:intervall, outbursts, 'r');
% p.LineWidth=2;
title('Local outbursts')
axis([0 intervall -0.01 40])
saveas(f, 'LocalOutbursts.png', 'png')

end