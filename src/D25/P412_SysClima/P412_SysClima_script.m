clear

load('CS3_8_sysclima_clean.mat')

for i = 1:26
    ds_cell{i}.AlarmaLluvia = [];
    ds_cell{i}.AlarmaVto = [];
    ds_cell{i}.DireccinViento = [];
    ds_cell{i}.EstadoCenitalO = [];
end
%%
ids = arrayfun(@(i)TableSeries(ds_cell{i}),1:26);
%%
clf
ShowData(ids)