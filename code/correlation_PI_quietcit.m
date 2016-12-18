function corrPI = correlation_PI_quietcit(saved_data)
% Returns the correlation coeffecients between PI and the amount of rebels
% for different values of CI

corrPI = zeros(1, 11);

for i=0:0.1:1
    extractor = abs(saved_data(:,2)-i)<=0.01;
    temp = corrcoef([saved_data(extractor, 1) saved_data(extractor, 4)]);
    corrPI(int64(10*i+1)) = temp(1,end);
end
end