function create_phase_diagram(saved_data)
% Create a phase diagram for the results of the simulation

[CI,PI]=meshgrid(0:0.025:1);
results = zeros(size(CI));
for m=0:25:1000
        extractor = abs(saved_data(:,1)-(m/1000))<=0.01;
        results(round(m/25 + 1), 1:sum(extractor)) = saved_data(extractor, 3)';
end
hold on;
view(0,90);
surf(CI,PI,results,'EdgeColor','none');
colorbar;
set(gca,'FontSize',16)
xlabel('Cop Investment');
ylabel('Propaganda Investment');
caxis([0 1])
end