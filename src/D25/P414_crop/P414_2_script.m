clear 

clear
%load('src/data/CS3_1_Sysclima.mat')
load('CS3_7_all_cum_production.mat')
ds_crop = new_ds_prod_2{3};

%%
%%
load('CS3_2_ExteriorClima.mat')

t0 = datetime("15-Feb-"+ds_crop.DateTime(1).Year);
tend = ds_crop.DateTime(end);
ind_b = logical((ds.DateTime > t0).*(ds.DateTime < tend));
ods = ds(ind_b,:);
ids = ods;
%% create exterior climate signal

%
t0 = ods.DateTime(1);
tspan = days(ods.DateTime - t0);
%
EC = [];
EC.signals.values = [ods.temp ods.RadCloud ods.humidity ods.wind_speed];
EC.signals.dimensions = 4;
EC.time = tspan;

open_system('P414_1_model02')

%%
BuildBusFlow;
load('src/D25/P414_crop/params.mat')
%%
r = sim('P414_1_model02');
%%
C = r.logsout.getElement('Control');
C = parseIndoorClimate(C,r.tout);
%%
IC = parseIndoorClimate(r.logsout.getElement('Indoor Climate'),r.tout);
%%
CROP = parseIndoorClimate(r.logsout.getElement('Crop'),r.tout);

SUBS = parseSubstrate(r.logsout.getElement('Subs'),r.tout);
FERTI = parseFertirrigation(r.logsout.getElement('Ferti'),r.tout);
%%

%%
