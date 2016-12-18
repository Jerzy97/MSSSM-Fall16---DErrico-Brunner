function create_error_plot_population(SaveNum, CI, PI)
% This function plots the number of inhabitants belonging to each group,
% i.e. empty cell, citizen, cop, rebel, as a function of time
% Parameters:
%       - time: The simulations duration (intervall)
%       - num: the vector containing each groups pop. number (SaveNum)

SimuDuration = size(SaveNum, 2);
InterpAcc = 1:5:SimuDuration;

% Interpolate the values
numInterp(1, :) = interp1(1:SimuDuration, SaveNum(1, :), InterpAcc, 'Spline');
numInterp(2, :) = interp1(1:SimuDuration, SaveNum(2, :), InterpAcc, 'Spline');
numInterp(3, :) = interp1(1:SimuDuration, SaveNum(3, :), InterpAcc, 'Spline');
numInterp(4, :) = interp1(1:SimuDuration, SaveNum(4, :), InterpAcc, 'Spline');
numInterp(5, :) = interp1(1:SimuDuration, SaveNum(5, :), InterpAcc, 'Spline');

meanError = zeros(5, size(numInterp, 2));
% Calculate errors
for i=1:(size(numInterp, 2)-1)
    interv = [5*i-2 5*i-1 5*i 5*i+1 5*i+2];
    meanError(1, i+1) = abs(mean(SaveNum(1, interv))-numInterp(1, i+1));
    meanError(2, i+1) = abs(mean(SaveNum(2, interv))-numInterp(2, i+1));
    meanError(3, i+1) = abs(mean(SaveNum(3, interv))-numInterp(3, i+1));
    meanError(4, i+1) = abs(mean(SaveNum(4, interv))-numInterp(4, i+1));
    meanError(5, i+1) = abs(mean(SaveNum(5, interv))-numInterp(5, i+1));
end

err = NaN(5, size(numInterp, 2));
err(1, mod(InterpAcc-1, 20)==0) = 5 * meanError(1, mod(InterpAcc-1, 20)==0);
err(2, mod(InterpAcc-1, 20)==0) = 5 * meanError(2, mod(InterpAcc-1, 20)==0);
err(3, mod(InterpAcc-1, 20)==0) = 5 * meanError(3, mod(InterpAcc-1, 20)==0);
err(4, mod(InterpAcc-1, 20)==0) = 5 * meanError(4, mod(InterpAcc-1, 20)==0);
err(5, mod(InterpAcc-1, 20)==0) = 5 * meanError(5, mod(InterpAcc-1, 20)==0);

fig = figure;
% set(gcf,'visible','off')
hold on
p=errorbar(InterpAcc, numInterp(1, :), err(1, :));
p.LineWidth=1.5;
p=errorbar(InterpAcc, numInterp(2, :), err(2, :));
p.LineWidth=1.5;
p=errorbar(InterpAcc, numInterp(3, :), err(3, :));
p.LineWidth=1.5;
p=errorbar(InterpAcc, numInterp(4, :), err(4, :));
p.LineWidth=1.5;
p=errorbar(InterpAcc, numInterp(5, :), err(5, :));
p.LineWidth=1.5;
xlabel('Time', 'FontSize', 16)
ylabel('Total share of population', 'FontSize', 16)
legend('Empty Cells', 'Quiet Citizen', 'Cops', 'Rebels', 'Prisoners')
title(['Population curves: CI = ' num2str(CI) ' PI=' num2str(PI)], 'FontSize', 16)
axis([0 300 -10 max(max(SaveNum))+50])
filename = fullfile('../data/Population Curve Plots/', ['population_plot_CI=' num2str(CI) '_PI=' num2str(PI) '.png']);
filename2 = fullfile('../data/Population Curve Plots/', ['population_plot_CI=' num2str(CI) '_PI=' num2str(PI) '.fig']);
saveas(fig, filename, 'png')
saveas(fig, filename2, 'fig')

end