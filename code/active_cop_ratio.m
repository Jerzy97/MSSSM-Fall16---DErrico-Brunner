function acRatio = active_cop_ratio(M, index, GridSize)
% Count Cops and Rebels in sight and compute Ratio
% This is called by a cop to compute arresting efficiency

% 2nd Moore neighborhood, since one's vision is typically greater than ones
% scope of action

neighbors=find_neighbors_2nd_moore(index, GridSize);
% A cop is calling this function
neighborCops=1;
neighborRebels=0;
    for n=1:length(neighbors)
        if M(2, neighbors(n))==2
            neighborCops=neighborCops+1;
        elseif M(2, neighbors(n))==3
            neighborRebels=neighborRebels+1;
        end
    end
    
acRatio=neighborRebels/neighborCops;

end