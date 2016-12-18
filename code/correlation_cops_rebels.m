function corrCopsRebels = correlation_cops_rebels(saved_data)
% Returns the correlation coeffecients between the number of cops and
% rebels

corrCopsRebels = zeros(1, 11);

for i=0:0.1:1
    extractor = abs(saved_data(:,2)-i)<=0.01;
    temp = corrcoef([saved_data(extractor, 3) saved_data(extractor, 5)]);
    corrCopsRebels(int64(10*i+1)) = temp(1,end);
end
end