function create_plot_population(time, num)
% This function plots the number of inhabitants belonging to each group,
% i.e. empty cell, citizen, cop, rebel, as a function of time
% Parameters:
%       - time: The simulations duration (intervall)
%       - num: the vector containing each groups pop. number (SaveNum)

figure
hold on
plot(1:time, num(1, :))
plot(1:time, num(2, :))
plot(1:time, num(3, :))
plot(1:time, num(4, :))
plot(1:time, num(5, :))
legend('Empty Cells', 'Quiet Citizen', 'Cops', 'Rebels', 'Prisoners')
title('Population curves')

end