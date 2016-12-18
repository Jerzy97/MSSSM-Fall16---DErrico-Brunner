%%% This script loops the whole Model using different parameters %%%

saved_data = [];

for PI=0:0.025:1
    for CI=0:0.025:(1-PI)
        SaveM = simu(CI,PI);
        %filename = fullfile('../data/Property Matrices', ['CI=' num2str(CI) '_PI= ' num2str(PI) '.mat']);
        %save(filename, 'SaveM')
        new_row_data = rebels_and_outbursts(SaveM,CI,PI);
        saved_data = [saved_data ; new_row_data];
    end
end

save('../data/popdata.mat','saved_data')