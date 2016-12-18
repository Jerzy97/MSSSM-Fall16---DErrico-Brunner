function [ def ] = generate_actor( M, index, perc_cops, perc_occupied, CI, PI, threshold, taxes)
% this function assignes a function to a cell
% 0     if the cell contains nobody
% 1     if the cell contains a citizen
% 2     if the cell contains a cop
% using the following parameters:
% perc_cops: (nr_cops)/(nr_citizens+nr_cops)
% perc: the percentual of grid we want to be occupied by someone

def=zeros(7,1);

GridSize = round(sqrt(size(M, 2)));

distr=rand;

if distr<(perc_occupied*perc_cops)
    % define cop function
    def(1)=2;
    % define age V
    def(2)=fix(rand*60+20);
    % define arrest probability P, for explanation see update_cop.m
    def(3)=0.8*(1 - exp(-5*CI));
    % set all other values to -1, so it can be distincted from an empty
    % cell, when necessary
    def(4:end)=-1;
    
elseif distr<perc_occupied
    % define age V
    def(2)=fix(rand*60+20);
    % define hardship from government H - heterogeneous amongst agents
    def(3)=rand;
    % define legitimacy of government L
    def(4)=PI*(1 - 100*taxes);
    % define grievance G
    def(5)=def(3)*(1-def(4));
    % define agent's risk aversion R 
    def(6)=rand;
    % define agent's net risk N
    def(7)=def(6)*rand;
    % find rebels number in neighbourhood
    rebelNumber=0;
    neighbours = find_neighbors_1st_moore(index, GridSize);
    for i=neighbours
        if M(2,i)==3
            rebelNumber = rebelNumber+1;
        end
    end
    % define state
    if (def(5)-def(7)+rebelNumber/8)<threshold
        def(1)=1;
    else
        def(1)=3;
    end
end
end

