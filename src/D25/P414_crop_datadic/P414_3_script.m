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
EC.signals.values = [ods.temp ods.RadCloud ods.wind_speed ods.humidity ];
EC.signals.dimensions = 4;
EC.time = tspan;

%%
BuildBusFlow;
load('src/D25/P414_crop/params.mat')
Tmax = 296;
Tstart = 285.5;
%%
in = Simulink.SimulationInput('P414_1_model02_comp');
in = in.setExternalInput(EC);
r = sim(in);
%%
C = r.logsout.getElement('Control');
C = parseIndoorClimate(C,r.tout);
%%
IC = parseIndoorClimate(r.logsout.getElement('Indoor Climate'),r.tout);
%%
CROP  = parseIndoorClimate(r.logsout.getElement('Crop'),r.tout);
SUBS  = parseSubstrate(r.logsout.getElement('Subs'),r.tout);
FERTI = parseFertirrigation(r.logsout.getElement('Ferti'),r.tout);
%%
x = rsimgetrtp('P414_1_model02_comp');
%% Leemos los parámetros disponibles en el modelo  y lo convertimos a structura
iter = 0;
for imap = x.parameters(1).map
    iter = iter + 1;
    imap.Identifier;
    nnn = strsplit(imap.Identifier,'__');
    if length(nnn)>1
        eval(nnn{1}+".('"+nnn{2}+"') = x.parameters(1).values(imap.ValueIndices(1):imap.ValueIndices(2));")
    else
        eval(nnn{1}+" =  x.parameters(1).values(imap.ValueIndices(1):imap.ValueIndices(2));")
    end
end
%% modificamos 
clima.T0 = clima.T0 + 20;
%% desde la estrutura lo seteamos al modelo;

for imap = x.parameters(1).map
    iter = iter + 1;
    imap.Identifier;
    nnn = strsplit(imap.Identifier,'__');
    if length(nnn)>1
        name = (nnn{1}+".('"+nnn{2}+"')");
    else
        name = (nnn{1}+"");
    end
    
    eval("x.parameters(1).values(imap.ValueIndices(1):imap.ValueIndices(2)) = "+name+";")
end
%
%%
save('params_rsim','x')

%%
slbuild('P414_1_model02_comp')
%%

save('input_rsim','EC')
%%
system("./P414_1_model02_comp -i input_rsim.mat -p params_rsim.mat -tf 100")

%%
load('P414_1_model02_comp.mat')
%%
%%
load('RSIM_VARS_NAMES.mat')
%%
ds_crop = array2table(permute(rt_yout.signals(1).values,[3 1 2]),'VariableNames',CROP_NAMES);
%%
ds_clima = array2table(permute(rt_yout.signals(2).values,[1 2 3]),'VariableNames',INDOOR_NAMES);
%%
ds_subs = array2table(permute(rt_yout.signals(3).values,[3 1 2]),'VariableNames',SUBS_NAMES);
%%
ds_control = array2table(permute(rt_yout.signals(4).values,[1 2 3]),'VariableNames',CONTROL_NAMES);
%%
clf
hold on
plot(rt_tout,ds_clima.Temp__Tair - 273.15,'.-')
plot(rt_tout,ds_clima.Temp__Tcover - 273.15)
plot(rt_tout,ds_clima.Temp__Tsoil - 273.15)
