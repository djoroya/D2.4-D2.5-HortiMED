clear 


%%

%%
BuildBusFlow;
load('src/D25/P414_crop/params.mat')
%%
WinAR = 10;
today_days = 5;
CO2_ppm_ext = 400;
max_night = 1;
tau_win = 1200;
maxvelocity = 200;
%%
subtrate__sigma_min = 0.1;
subtrate__sigma_max = 1;
%

tinit_crop1 = 1 ;
tend_crop1  = 20;


tinit_crop2 = 20;
tend_crop2  = 40;
%% Compile 
slbuild('P414_1_model03_comp')
%%

xrsim_params = rsimgetrtp('P414_1_model03_comp');
%%
save('src/D25_grafana/T01/xrim_params.mat','xrsim_params')
%%