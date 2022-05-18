clear 

load('data/CS3_9_sysclima_with_heater.mat')
ids = ids_heater;
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
Windows = [];
Windows.signals.dimensions = 1;
Windows_data = ids.EstadoCenitalE*0.5 + ids.EstadoCenitalO*0.5;
Windows.signals.values = Windows_data;
Windows.time = tspan';
%%
Screen = [];
Screen.signals.dimensions = 1;
Screen_data = ids.EstadoPant1;
Screen.signals.values = Windows_data;
Screen.time = tspan';
%% Create heater params 
HP = heater_p;
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
load('P413_2_model_spesession')
params = SDOSessionData.Data.Workspace.LocalWorkspace.Exp.Parameters;

beta = params(1).Value;
gamma = params(2).Value;
%
p_ic.tau_c = params(3).Value;
p_ic.alpha_c = params(4).Value;
%%
Tmax = 273.15 + 20;
Tstart = 273.15 + 10;
%% Datos de entrenamiento; 
Ti = ids.Tinv + 273.15;
Hi = ids.HRInt;

%%
clear('P413_2_model_spesession')
clear('P413_1_model_spesession')

sim('P413_3_model')

