function create_plot_CI_PI_dependency(saved_data)

[X, Y] = meshgrid(0:0.1:1);

dependency = zeros(11);
for i=1:size(saved_data, 1)
    dependency(int64((10*saved_data(i, 1)+1)), int64((10*saved_data(i, 2)+1))) = saved_data(i, 3);
end
surf(X, Y, dependency)
xlabel('CI')
ylabel('PI')
zlabel('Percentage of rebels')
end