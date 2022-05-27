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
%
t0 = ods.DateTime(1);
tspan = days(ods.DateTime - t0);
%
EC = [];
EC.signals.values = [ods.temp ods.RadCloud ods.humidity ods.wind_speed];
EC.signals.dimensions = 4;
EC.time = tspan;

%%

%% Recogemos la señal de la ventana

%% Create heater params 
HP = heater_p;
%
HP.A_i = 8e-3;
HP.A_e = 1e-4;
HP.c   = 5e-9;
HP.c   = 5e-10;

HP.power = 6e7;

x0_H = heater_ic;

%% Tomamo los parametros estimados en P413_1
load('P413_1_model_spesession')
params = SDOSessionData.Data.Workspace.LocalWorkspace.Exp.Parameters;
%%
AR = params(1).Value;
%%

%%
x0_ic = climate_ic;
p_ic = climate_p;
p_ic.T_ss = params(2).Value;
p_ic.A_c = params(3).Value;
p_ic.A_f = params(4).Value;
p_ic.H = params(5).Value;
p_ic.alpha_f = params(6).Value;
p_ic.minWindows = params(7).Value;
%%
%%
load('P413_2_model_spesession')
params = SDOSessionData.Data.Workspace.LocalWorkspace.Exp.Parameters;

beta = params(1).Value;
gamma = params(2).Value;
%
p_ic.tau_c = params(3).Value;
p_ic.alpha_c = params(4).Value;
%%
Tmax = 296;
Tstart = 285.5;
%% Datos de entrenamiento; 
Ti = 12 + 273.15;
Hi = 80;

%%
p_ic.tau_c = 3;
p_ic.tau_c = 1;

%p_ic.alpha_i = 0.001;
%p_ic.minWindows = 0.05;
%%
clear('P413_2_model_spesession')
clear('P413_1_model_spesession')
%%
%%
win_p = windows_p;
win_p.AR = AR;
scr_p = screen_p;
%
scr_p.beta = beta;
scr_p.gamma_max = gamma;
%%
crop_params = crop_p;
x0_crop = crop_ic;
%%
x0_fruit = fruit_ic;
params_fruit = fruit_p;
%%
x0_substrate = substrate_ic;
substrate_params = substrate_p;
%%
BuildBusFlow;

%%
r = sim('P414_1_model02');
%%
C = r.logsout.getElement('Control');
C = parseIndoorClimate(C,r.tout);
%%
IC = parseIndoorClimate(r.logsout.getElement('Indoor Climate'),r.tout);
%%
CROP = parseIndoorClimate(r.logsout.getElement('Crop'),r.tout);

SUBS = parseSubstrate(r.logsout.getElement('Subs'),r.tout)
FERTI = parseFertirrigation(r.logsout.getElement('Ferti'),r.tout)
%%

plot(r.tout,CROP.Tsum)
%% Water
Days = days(r.tout) + ids.DateTime(1);


sty = {'LineWidth',2}
clf 
subplot(3,1,1)
hold on
plot(Days,CROP.Water.WaterState.VegWater,sty{:})
plot(Days,CROP.WC,sty{:})
legend('Content','Water Capacity')
grid on
ylabel('kg\{H_2O\}/m^2')

subplot(3,1,2)
hold on
plot(Days,CROP.Water.WaterFlows.WaterDemand,sty{:});
plot(Days,CROP.Water.WaterFlows.WaterUptake,sty{:});
plot(Days,FERTI.f,sty{:});
plot(Days,SUBS.Drainge.f,sty{:})

legend('Demand','Uptake','Irrigation','Drainge')
grid on
ylabel('kg\{H_2O\}/(sm^2)')

subplot(3,1,3)

plot(Days,CROP.Water.WaterFlows.MW_QT,sty{:});
legend('Transpiration')
ylabel('kg\{H_2O\}/(sm^2)')
%xlim([0 1])
grid on
xlabel('days')
%%
plot(ds_crop.DateTime,ds_crop.MatureFruit)

%%
Tomato = r.logsout.getElement('Tomato').Values.Data;
%%
clf
hold on
plot(Days,Tomato/(0.04));
plot(ds_crop.DateTime,ds_crop.MatureFruit/crop_params.A_v)
legend('sim','real')
% pathfile = which('P414_1_clima');
% pathfile = replace(pathfile,'P413_3_clima.m','');
% pathfile = fullfile(pathfile,'heater_pic.png');
% 
% print(fig,'-dpng',pathfile)

%print(fig,'')
