clear 

load('data/CS3_9_sysclima_no_heater_no_screen.mat')
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
x0_ic = climate_ic;
p_ic = climate_p;
%%
AR = 10; % m2
%% Datos de entrenamiento; 
Ti = ids.Tinv + 273.15;
Hi = ids.HRInt;


set_param('P413_1_model','StopTime','tspan(end)')
r = sim('P413_1_model');
%%
IC = r.logsout.getElement('Indoor Climate');
IC_st = parseIndoorClimate(IC,r.tout);
%%
Ti = IC_st.Temp.Tair;
Hi = IC_st.Gas.HRInt;
%
figure('unit','norm','pos',[0.5 0.5 0.5 0.5])
%
hold on
ssel = 1:4:length(ids.Tinv);
plot(r.tout,Ti-273.15)
plot(tspan(ssel),ids.Tinv(ssel),'o')
%%
