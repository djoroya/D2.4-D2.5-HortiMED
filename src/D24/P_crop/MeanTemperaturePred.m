function Te_mu = MeanTemperaturePred(t)

    load('prediction_file.mat')
    %ds = load('prediction_file.mat');
    %ds = ds.ds;
    dd = ds.DateTime_days;
    Te_mu = mean(ds.temp(logical((dd > t).*(dd < (t+1)))));
end

