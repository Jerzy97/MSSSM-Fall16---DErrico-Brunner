function [ def ] = generate_actor( perc_cops, perc_occupied, CI, PI, threshold)
% this function assignes a function to a cell
% 0     if the cell contains nobody
% 1     if the cell contains a citizen
% 2     if the cell contains a cop
% using the following parameters:
% perc_cops: (nr_cops)/(nr_citizens+nr_cops)
% perc: the percentual of grid we want to be occupied by someone

def=zeros(7,1);

distr=rand;

if distr<(perc_occupied*perc_cops)
    % define cop function
    def(1)=2;
    % define age V [Days]
    def(2)=360*fix(rand*60+20);
    % define arrest probability P, for explanation see update_cop.m
    def(3)=0.8*(1 - exp(-10*CI));
    % set all other values to -1, so it can be distincted from an empty
    % cell, when necessary
    def(4:end)=-1;
    
elseif distr<perc_occupied
    % define age V [Days]
    def(2)=360*fix(rand*60+20);
    % define hardship from government H  ---> now set it random
    def(3)=rand;
    % define legitimacy of government L  ---> now set it random
    def(4)=0.7;
    % define grievance G
    def(5)=def(3)*(1-def(4));
    % define agent's risk aversion R 
    def(6)=rand;
    % define agent's net risk N
    def(7)=def(6)*rand;
    % define state
    if (def(5)-def(7))<threshold
        def(1)=1;
    else
        def(1)=3;
    end
end
end

