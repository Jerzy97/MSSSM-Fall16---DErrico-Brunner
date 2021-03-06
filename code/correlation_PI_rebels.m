function corrPI = correlation_PI_rebels(saved_data)
% Returns the correlation coeffecients between CI and the amount of rebels
% for different values of PI
corrPI = zeros(1, 11);
for i=0:0.1:1
    extractor = abs(saved_data(:,1)-i)<=0.01;
    temp = corrcoef([saved_data(extractor, 2) saved_data(extractor, 3)]);
    corrPI(int64(10*i+1)) = temp(1,end);
end
end