clear
load('src/D25/P414_crop/params.mat')
load('src/D25_grafana/T01/xrim_params')
delete('P414_1_model03_comp.mat')

%Tend = 200;
Tend = 300;
%Tend = 90;

%%
build_data_menaka = false;
DateInit = datetime('2022-Feb-15');
DateInit = datetime('2022-Feb-01');

if build_data_menaka
    ds = ExternalClimateBuilderMenaka(DateInit);
    save('src/D25_grafana/T01/ds_EC','ds')
else
    load('src/D25_grafana/T01/ds_EC')
end
%%
%ds = ds(ds.DateTime < datetime('2022-Oct-15'),:);
%ds = ds(ds.DateTime < datetime('2022-Mar-15'),:);

%% create exterior climate signal
%
t0 = ds.DateTime(1);
tspan = days(ds.DateTime - t0);

wind_values = ds.wind;
wind_values(isnan(wind_values))= [];
%
S01_EC = [];
S01_EC.signals.values = [ds.temperature+273.15 ds.radiation+5 wind_values ds.humidity ];
S01_EC.signals.dimensions = 4;
S01_EC.time = tspan;
%%


%
if build_data_menaka
    r = MenakaDataCall_ECF([ds.DateTime(1) - hours(1) ds.DateTime(1)+days(Tend)]);
    save('src/D25_grafana/T01/r_Menaka','r')
else
    load('src/D25_grafana/T01/r_Menaka')
end
%%
r((isnan(sum(r{:,2:end},2))),:) = [];

tspan = days(r.DateTime - t0);
values = r.Inclinom_Inclinom;
%

tspan(isnan(values))= [];
values(isnan(values))= [];

S02_W = [];
S02_W.signals.values = values;
S02_W.signals.dimensions = 1;
S02_W.time = tspan;
%%
tspan = days(r.DateTime - t0);
RIC = [r.Temperatura_Temperatura + 273.15 r.Radiacion_Radiacion r.Humedad_Humedad r.CO2_CO2];

tspan(isnan(sum(RIC,2)))= [];
RIC(isnan(sum(RIC,2)),:)= [];

S03_W = [];
S03_W.signals.values = RIC;
S03_W.signals.dimensions = 4;
S03_W.time = tspan;

%%
save('input_rsim.mat','S01_EC','S02_W')
%%
% creamos estruturas de matlab para la modificacion de los parámtros 
paramsvars2struct;
%
% modificamos 
clima.T0 = r.Temperatura_Temperatura(1) + 273.15;
heater.power = 2e6;
heater.A_e = 5e-4;
heater.A_i = 5e-2;
heater.c = 5e-9;
clima.tau_c = 0.5;

Tstart = 9 + 273.15;
Tmax = 12 + 273.15;
WinAR = 40;
clima.minWindows = 0.4;
clima.T_ss = 8 + 273.15;

CO2_ppm_ext = 450;
%subtrate.Vmin_subs = 0.1;
%subtrate.Nmin_subs = 1e-6;
subtrate.DraingeConst = 1e-5;
%
irrigation.IrrigationFlow = 3.5e-3;
irrigation.Xnutrients = 30*[1.3000e-05 8.6671e-06 4.3329e-06 1.7329e-06 1.7329e-06 8.6710e-07 0 0];
irrigation.percent_irrigation = 10;

today_days = floor(days(r.DateTime(end) - t0));
crop.A_v = 2800;
maxvelocity = 1;
crop.VelocityAbsortion = 2;
%crop.C = [0 0 0 0];
tau_win = 4800;
%crop.tinit = 1;

tinit_crop1 = -days(t0-datetime('16-Feb-2022'));
tend_crop1 = -days(t0-datetime('15-Aug-2022'));

tinit_crop2 = -days(t0-datetime('10-Jul-2022'));
tend_crop2 = -days(t0-datetime('10-Dec-2022'));

%
% desde la estrutura lo seteamos al modelo;
structparams2file;
clear *__*
%%
system("./P414_1_model03_comp -i input_rsim.mat -p params_rsim.mat -tf "+num2str(Tend))
%
%%
parsevars_P414;
%%

%consumo = ComputeCost(PowerH2COM,cc_st,rt_tout,crop,ft_st);

consumo_cum = ComputeCostCumulative(PowerH2COM,cc_st,DT_span,crop,ft_st,tomato);
consumo_monthly = ReshapeConsume(consumo_cum);
%
%%
%xlims = [DT_span(1) DT_span(end)];
%xlims = [datetime('13-Jun-2022 18:00') datetime('14-Jun-2022') ];
%xlims = [datetime('14-Jun-2022 06:00') datetime('14-Jun-2022 6:10') ];
%xlims = [datetime('11-Jun-2022 18:00') datetime('15-Jun-2022') ];
%xlims = [datetime('17-Mar-2022 18:00') datetime('30-May-2022') ];
xlims = [datetime('01-Feb-2022 18:00') datetime('30-Oct-2022') ];

%%
clf
% nutrientes

%xlims = [DT_span(1000) DT_span(4000)];

%plot_P414_graph_18
xlims = [DT_span(1) DT_span(end)];
plot_P414_graph_11
%%
% consumo


%%
%xlims = [datetime('16-May-2022 00:00') datetime('16-May-2022 6:15') ];
% xlims = [DT_span(100) DT_span(end)];
% xlims = [datetime('19-Feb-2022 00:30') datetime('19-Feb-2022 3:15') ];
% 
% plot_P414_graph_12
%%
plot_P414_graph_20
%%
plot_P414_graph_8

%%
%xlims = [DT_span(1) DT_span(end)];
%plot_P414_graph_12
%%
% xlims = [datetime('16-May-2022 18:00') datetime('28-May-2022') ];
% plot(DT_span,ft_st.f);
% xlim(xlims)

%%
function r = ccppm2kg(x,T)
    r = (x/1e6)*0.044*101300./(8.3140*(T+273.15));
    %r = (x/1e6)*101300./(8.3140*(T+273.15));
end 
