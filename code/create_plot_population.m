function create_plot_population(SaveNum, CI, PI)
% This function plots the number of inhabitants belonging to each group,
% i.e. empty cell, citizen, cop, rebel, as a function of time
% Parameters:
%       - time: The simulations duration (intervall)
%       - num: the vector containing each groups pop. number (SaveNum)

SimuDuration = size(SaveNum, 2);

fig = figure;
%set(gcf,'visible','off')
hold on
p=plot(1:SimuDuration, SaveNum(1, :));
p.LineWidth=1.5;
p=plot(1:SimuDuration, SaveNum(2, :));
p.LineWidth=1.5;
p=plot(1:SimuDuration, SaveNum(3, :));
p.LineWidth=1.5;
p=plot(1:SimuDuration, SaveNum(4, :));
p.LineWidth=1.5;
p=plot(1:SimuDuration, SaveNum(5, :));
p.LineWidth=1.5;
xlabel('Time')
ylabel('Total share of population')
legend('Empty Cells', 'Quiet Citizen', 'Cops', 'Rebels', 'Prisoners')
title(['Population curves: CI = ' num2str(CI) ' PI=' num2str(PI)])
filename = fullfile('../data/Population Curve Plots/', ['population_plot_CI=' num2str(CI) '_PI=' num2str(PI) '.png']);
filename2 = fullfile('../data/Population Curve Plots/', ['population_plot_CI=' num2str(CI) '_PI=' num2str(PI) '.fig']);
saveas(fig, filename, 'png')
saveas(fig, filename2, 'fig')

end