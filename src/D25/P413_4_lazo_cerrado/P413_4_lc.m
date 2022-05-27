clear 

load('data/CS3_9_sysclima_with_heater.mat')
ids = ids_heater;
ids(1:300,:) = [];
%

%ids = ids(1:1900,:);
%ids = ids(1:500,:);

%% Cargamos datos de clima exterior y fijamos el regilla de tiempo medido en días;

tspan = days(ids.DateTime - ids.DateTime(1));
Te = ids.Text + 273.15; % [Kelvin] !!!
Re = ids.RadExt;
Ve = ids.Vviento;
He = ids.HRExt;
%% Construimos una estrutura de matlab con el formato necesario para leer señales 
EC = [];
EC.signals.dimensions = 4;
EC.time = tspan';
EC.signals.values = [Te Re Ve He];
%% Recogemos la señal de la ventana

%% Create heater params 
HP = heater_p;
%
HP.A_i = 8e-3;
HP.A_e = 1e-4;
HP.c   = 5e-9;
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
Ti = ids.Tinv + 273.15;
Hi = ids.HRInt;

%%
p_ic.tau_c = 3;
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
r = sim('P413_4_model02');
%%
C = r.logsout{2};
C = parseIndoorClimate(C,r.tout)
%%
IC = parseIndoorClimate(r.logsout{1},r.tout)
%%
fig = figure('unit','norm','pos',[0.5 0.5 0.5 1])
uip = uipanel('parent',fig,'unit','norm','pos',[-0.05 -0.05 1.1 1.1],'BackgroundColor','w')
subplot(2,1,1,'parent',uip)
hold on
plot(r.tout,IC.Temp.Tair-273.15,'LineWidth',2)
%
Nt = length(tspan);
plot(tspan(1:2:Nt),ids.Tinv(1:2:Nt),'LineWidth',1.5)
plot(tspan,ids.Text,'LineWidth',2)
yline(Tmax-273.15,'LineStyle','--','LineWidth',2)
yline(Tstart-273.15,'LineStyle',':','LineWidth',2)
legend('$T_i(sim)$','$T_i(real)$','$T_e$','$T_{max}$','$T_{start}$','FontSize',15,'Interpreter','latex')
grid on
xlabel('days')
title('Temperature[ºC]','FontSize',12)
xlim([r.tout(1) r.tout(end)])


%
ax = axes('Parent',uip,'unit','norm','pos',[0.15 0.6 0.295 0.07])
%
box(ax,'on')
hold(ax,'on')
plot(r.tout,IC.Temp.Tair-273.15,'LineWidth',1.5)
plot(tspan(1:2:Nt),ids.Tinv(1:2:Nt),'LineWidth',2,'Parent',ax)
plot(tspan,ids.Text,'LineWidth',2,'Parent',ax)
yline(Tmax-273.15,'LineStyle','--','LineWidth',2,'Parent',ax)
yline(Tstart-273.15,'LineStyle',':','LineWidth',2,'Parent',ax)
grid on
xlim(ax,[1.7 2.4])
ylim(ax,[10 20])
yticks([])
xticks([])

subplot(2,1,2,'parent',uip)



plot(r.tout,C.Windows.value,'LineWidth',2)
grid on 
title('Heater [kW]','FontSize',12)
xlabel('days')
xlim([r.tout(1) r.tout(end)])
%

annotation(uip,'arrow',[0.444162436548223 0.413705583756345],...
    [0.670594351065673 0.78067823906551]);

% Create arrow
annotation(uip,'arrow',[0.154822335025381 0.331218274111675],...
    [0.669447643899008 0.77838482473218]);
%%

pathfile = which('P413_3_clima');
pathfile = replace(pathfile,'P413_3_clima.m','');
pathfile = fullfile(pathfile,'heater_pic.png');

print(fig,'-dpng',pathfile)

%print(fig,'')
