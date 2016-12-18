function create_plot_total_outbursts(SaveNum, CI, PI)
% This function plots the total outbursts
% We speak of a total outburst, when more 50 percent of the grid are rebels

SimuDuration = size(SaveNum, 2);

% Create a logical array, 1 if total outburst occured
outbursts = zeros(1, SimuDuration);

for i=1:SimuDuration
    TotalPop = sum(SaveNum([2 3 4], i));
    reb = SaveNum(4, i);
    if reb > (0.5*TotalPop)
        outbursts(i) = 1;
    end
end
    

fig=figure;
set(gcf,'visible','off')
% Plot results
p = plot(1:SimuDuration, outbursts, 'r');
p.LineWidth = 2;
title(['Total outbursts: CI = ' num2str(CI) ' PI = ' num2str(PI)])
axis([0 SimuDuration 0 2])
filename = fullfile('../data/Total Outburst Plots/', ['total_outburst_plot_CI=' num2str(CI) '_PI=' num2str(PI) '.png']);
saveas(fig, filename, 'png')

end