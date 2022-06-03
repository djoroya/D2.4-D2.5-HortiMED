clear 

clear
%load('src/data/CS3_1_Sysclima.mat')
load('CS3_7_all_cum_production.mat')
ds_crop = new_ds_prod_2{3};

%% Señal de predicción a 24 horas 


%%
load('CS3_2_ExteriorClima.mat')


%%
t0 = datetime("15-Feb-"+ds_crop.DateTime(1).Year);
tend = ds_crop.DateTime(end);
tend = tend - days(150);
ind_b = logical((ds.DateTime > t0).*(ds.DateTime < tend));
ods = ds(ind_b,:);
ids = ods;
%
ods(days(diff(ods.DateTime)) == 0,:) = [];

new_tspan = ods.DateTime(1):minutes(15):ods.DateTime(end);
new_ods = [];
new_ods.DateTime = new_tspan';
for ivar = ods.Properties.VariableNames(2:end)
    
    if strcmp(ivar{:},'temp')
        ods.(ivar{:}) = smoothdata(ods.(ivar{:}),'SmoothingFactor',0.05);
        method = 'spline';
    elseif strcmp(ivar{:},'wind_speed')
        method = 'spline';
        ods.(ivar{:}) = smoothdata(ods.(ivar{:}),'SmoothingFactor',0.05);
    else
        method = 'linear';
    end
    new_ods.(ivar{:}) = interp1(ods.DateTime,ods.(ivar{:}),new_tspan,method)';
    
    if strcmp(ivar{:},'wind_speed')
        new_ods.(ivar{:})(new_ods.(ivar{:}) < 1e-3) = 0;
    end
end
new_ods = struct2table(new_ods);
ods = new_ods;

%%

%% create exterior climate signal

%
%
t0 = ods.DateTime(1);
tspan = days(ods.DateTime - t0);

t0_12_00 = t0;
t0_12_00.Hour = 0;
t0_12_00.Minute = 0;
t0_12_00.Second = 0;

t0_shift = days(t0-t0_12_00);
%%
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
HP.A_i = 5e-3;

HP.A_e = 1e-6;
HP.c   = 5e-10;
%HP.c   = 5e-10;
%HP.c   = 5e-12;

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




dd = days(ds.DateTime - t0);
ds.DateTime_days = dd;
save('prediction_file.mat','ds')
   % Te_mu = mean(ds.temp(logical((dd > t).*(dd < (t+1)))));
%%
r = sim('D24P414_1_model02');
%%

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
clc

plot(Days,IC.Temp.Tair)
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

%%

fig = figure('unit','norm','pos',[0.5 0.5 0.5 1])
uip = uipanel('parent',fig,'unit','norm','pos',[-0.05 -0.05 1.1 1.1],'BackgroundColor','w')
subplot(3,1,1,'parent',uip)
hold on
plot(r.tout,IC.Temp.Tair-273.15,'LineWidth',2)
%plot(r.tout,IC.Temp.Tair-273.15,'LineWidth',2)

%
Nt = length(new_tspan);
plot(days(new_tspan - new_tspan(1)),ods.temp - 273.15,'LineWidth',2)

TTh =r.logsout.getElement('Th');
Th = TTh{1}.Values.Data - 273.15;
plot(r.tout,Th,'LineWidth',2)

yline(Tmax-273.15,'LineStyle','--','LineWidth',2)
yline(Tstart-273.15,'LineStyle',':','LineWidth',2)
legend('$T_i(sim)$','$T_e$','$T_h$','$T_{max}$','$T_{start}$','FontSize',15,'Interpreter','latex')
grid on
xlabel('days')
title('Temperature[ºC]','FontSize',12)
xlim([r.tout(1) r.tout(end)])




subplot(3,1,2,'parent',uip)


Heater = r.logsout.getElement('Heater').Values.Data;
ComH = r.logsout.getElement('HeaterCon').Values.Data;
hold on
plot(r.tout,Heater,'LineWidth',2)
plot(r.tout,ComH,'LineWidth',2)

grid on 
title('Heater [kW]','FontSize',12)
xlabel('days')
xlim([r.tout(1) r.tout(end)])
%

subplot(3,1,3,'parent',uip)

plot(r.tout,C.Windows.value,'LineWidth',2)



%%

figure('Color','w')
FontSize = 15;
hold on
ax = plot(r.tout,Th,'LineWidth',2)


plot(r.tout,IC.Temp.Tair-273.15,'LineWidth',2)
plot(days(new_tspan - new_tspan(1)),ods.temp - 273.15,'LineWidth',2)
grid on

yline(10,'LineWidth',2,'LineStyle','--')
yline(20,'LineWidth',2,'LineStyle','-.')

legend('T_{heater}','T_{air}','T_{ext}','T_{start}','T_{stop}','FontSize',FontSize)

xlim([0 7])
xlabel('days')
ylabel('Temperature[ºC]')
ax.Parent.FontSize = FontSize;
box on

%%


figure('Color','w')
FontSize = 15;
hold on

T_h_start = r.logsout.getElement('T_h_start').Values.Data;
T_h_stop = r.logsout.getElement('T_h_stop').Values.Data;

Tmin = r.logsout.getElement('Tmin').Values.Data;
Toptmin = r.logsout.getElement('Toptmin').Values.Data;

ax = plot(r.tout,IC.Temp.Tair-273.15,'LineWidth',2)
 plot(r.tout,Th,'LineWidth',2)

plot(days(new_tspan - new_tspan(1)),ods.temp - 273.15,'LineWidth',2)
grid on

plot(r.tout,Tmin,'LineWidth',2,'LineStyle','-.')
plot(r.tout,Toptmin,'LineWidth',2,'LineStyle','-.')

%yline(10,'LineWidth',2,'LineStyle','--')
%yline(20,'LineWidth',2,'LineStyle','-.')

legend('T_{air}','T_{h}','T_{ext}','T_{min}^{opt}','T_{min}','FontSize',FontSize)

xlim([0 7])
xlabel('days')
ylabel('Temperature [ºC]')
ax.Parent.FontSize = FontSize;
box on


%%


figure('Color','w')
FontSize = 15;
hold on

T_h_start = r.logsout.getElement('T_h_start').Values.Data;
T_h_stop = r.logsout.getElement('T_h_stop').Values.Data;

Tmin = r.logsout.getElement('Tmin').Values.Data;
Toptmin = r.logsout.getElement('Toptmin').Values.Data;

ax = plot(r.tout,IC.Temp.Tair-273.15,'LineWidth',2)
 plot(r.tout,Th,'LineWidth',2)

plot(days(new_tspan - new_tspan(1)),ods.temp - 273.15,'LineWidth',2)
grid on

plot(r.tout,Tmin,'LineWidth',2,'LineStyle','-.')
plot(r.tout,Toptmin,'LineWidth',2,'LineStyle','-.')

plot(r.tout,T_h_start,'LineWidth',2,'LineStyle','-.')
plot(r.tout,T_h_stop,'LineWidth',2,'LineStyle','-.')

%yline(10,'LineWidth',2,'LineStyle','--')
%yline(20,'LineWidth',2,'LineStyle','-.')

legend('T_h','T_{air}','T_{ext}','T_{min}^{opt}','T_{min}','T_{start}^{heater}','T_{stop}^{heater}','FontSize',FontSize,'location','bestoutside')

xlim([0 8])
xlabel('days')
ylabel('Temperature [ºC]')
ax.Parent.FontSize = FontSize;
box on

%%

figure('Color','w')
FontSize = 15;

T_h_start = r.logsout.getElement('T_h_start').Values.Data;
T_h_stop = r.logsout.getElement('T_h_stop').Values.Data;

Tmin = r.logsout.getElement('Tmin').Values.Data;
Toptmin = r.logsout.getElement('Toptmin').Values.Data;
subplot(2,1,1)
hold on

ax = plot(r.tout,IC.Temp.Tair-273.15,'LineWidth',2);
 plot(r.tout,Th,'LineWidth',2)

%plot(days(new_tspan - new_tspan(1)),ods.temp - 273.15,'LineWidth',2)
grid on

plot(r.tout,Tmin,'LineWidth',1.5,'LineStyle','-')
plot(r.tout,Toptmin,'LineWidth',1.5,'LineStyle','-')

plot(days(new_tspan - new_tspan(1)),ods.temp - 273.15,'LineWidth',2)

%yline(10,'LineWidth',2,'LineStyle','--')
%yline(20,'LineWidth',2,'LineStyle','-.')

legend('T_{air}','T_h','T_{min}^{opt}','T_{min}','T_{ext}','FontSize',FontSize,'location','bestoutside')

xlim([2 8])
xlabel('days')
ylabel('Temperature [ºC]')
ax.Parent.FontSize = FontSize;
box on


subplot(2,1,2)
hold on
ax = plot(r.tout,IC.Temp.Tair-273.15,'LineWidth',2)

 plot(r.tout,Th,'LineWidth',2)
plot(r.tout,T_h_start,'LineWidth',1.5,'LineStyle','-')
plot(r.tout,T_h_stop,'LineWidth',1.5,'LineStyle','-')
plot(days(new_tspan - new_tspan(1)),ods.temp - 273.15,'LineWidth',2)
xlim([2 8])
xlabel('days')
ylabel('Temperature [ºC]')
grid on
ax.Parent.FontSize = FontSize;

legend('T_{air}','T_h','T_{start}^{heater}','T_{stop}^{heater}','T_{ext}','FontSize',FontSize,'location','bestoutside')
