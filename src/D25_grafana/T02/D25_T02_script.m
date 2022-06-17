%%
clear;
t0 = datetime('01-Feb-2022');


load_ds = true;
if ~load_ds
    [ds,~,niof] = ExternalClimateBuilderNIOF(t0);
    save('src/D25_grafana/T02/data_ds.mat','ds','niof');
else
    load('src/D25_grafana/T02/data_ds.mat');
end

ds(isnan(sum(ds{:,2:end},2)),:) = [];
%%
T = 10;
tspan = days(ds.DateTime - t0);
%%
clf
%
S01_EC = [];
S01_EC.signals.values = [ds.temperature+273.15 ds.radiation+5 ds.humidity ds.wind];
S01_EC.signals.dimensions = 4;
S01_EC.time = tspan;
%
%%
climate_params = climate_p;
climate_params.minWindows = 0.5;
climate_params.tau_c = 0.1;
climate_params.H = 3;
%%
tank_params = tank_p;
tank_params.ThermalConductivityWall = 1;
tank_params.wall_gain = 10;
tank_params.d_t = 0.1;
%%
reset_params = false;

if reset_params
    path_block = 'D25_T02_script_model/Climate Model';
    set_params_block(path_block,climate_params,'climate_params')
    path_block_tank = 'D25_T02_script_model/Tank Model';
    set_params_block(path_block_tank,tank_params,'tank_params')

end
%
%%
BuildBusFlow;
%%
r = sim('D25_T02_script_model');

%%
IC_st = parseIndoorClimate(r.logsout.getElement('IC01'),r.tout);
DT_span = days(r.tout) + t0; 

xlims = [DT_span(1) DT_span(end)];

%%
WT_st = parseTank(r.logsout.getElement('WT01'),r.tout);
%%
T_k = 273.5;
plot_D25T02_graph_2;


