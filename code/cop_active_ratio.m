function caRatio = cop_active_ratio(M, index, GridSize)
% Count Cops and Rebels in sight and compute Ratio
% This is called by citizen to compute the estimated arresting probability

% 2nd Moore neighborhood, since one's vision is typically greater than ones
% scope of action

neighbors=find_neighbors_2nd_moore(index, GridSize);
neighborCops=0;
% Since, when counting the agent always includes himself as active
neighborRebels=1;
    for n=1:length(neighbors)
        if M(2, neighbors(n))==2
            neighborCops=neighborCops+1;
        elseif M(2, neighbors(n))==3
            neighborRebels=neighborRebels+1;
        end
    end
    
caRatio=neighborCops/neighborRebels;

end