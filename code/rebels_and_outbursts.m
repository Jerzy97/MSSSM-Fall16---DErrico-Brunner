function new_row_data = rebels_and_outbursts(SaveM,CI,PI)

CITQUIET = 0;
COP = 0;
REB = 0;

for i=0:30
    M = SaveM(:,:,end-i);
    for j=1:1600
        switch M(2,j)
            case 1
                CITQUIET = CITQUIET+1;
            case 2
                COP = COP+1;
            case 3
                REB = REB+1;
        end
    end
end
TotPop=REB+CITQUIET+COP;
new_row_data=[CI,PI,REB/TotPop,CITQUIET/TotPop,COP/TotPop];
end

% function new_row_data = rebels_and_outbursts(SaveM,CI,PI)
% E = [];
% REB = [];
% CITQUIET = [];
% COP = [];
% for i=0:1:30
%     [ Eback, CITQUIETback, COPback, REBback ] indicize_people(SaveM(:,:,end-i));
%     E = [E;Eback];
%     REB = [REB;REBback];
%     COP = [COP;COPback];
%     CITQUIET = [CITQUIET;CITQUIETback];
% end
% TotPop=size(CITQUIET)+size(COP)+size(REB);
% new_row_data=[CI,PI,size(REB)/TotPop,size(CITQUIET)/TotPop,size(COP)/TotPop];
% end