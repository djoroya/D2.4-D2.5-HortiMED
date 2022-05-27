clear 

load('CS3_7_all_cum_production.mat')
ds_crop = new_ds_prod_2{3};

load('CS3_2_ExteriorClima.mat')

t0 = datetime("15-Feb-"+ds_crop.DateTime(1).Year);
tend = ds_crop.DateTime(end);
ind_b = logical((ds.DateTime > t0).*(ds.DateTime < tend));
ods = ds(ind_b,:);

tspan = days(ods.DateTime - ods.DateTime(1));
%%
Te.time = tspan;
Te.signals.values    = (ods.temp) - 273.15;
Te.signals.dimensions = 1;
%%
Re.time = tspan;
Re.signals.values    = ods.RadCloud;
Re.signals.dimensions = 1;
%%
%
Tsum = cumtrapz(tspan,Te.signals.values );
%%
%%
figure
clf
subplot(4,1,1)
plot(ds_crop.DateTime,ds_crop.MatureFruit)
xlim([datetime('01-Feb-2018') datetime('01-Sep-2018')])
subplot(4,1,2)
plot(ods.DateTime,ods.temp-273.15)
subplot(4,1,3)
plot(ods.DateTime,Tsum)
ylabel('T_{sum} [ºC d]')
subplot(4,1,4)

rr = OptimalGrowthTemperature(Tsum,ods.RadCloud);
plot(ods.DateTime,OptimalGrowthTemperature(Tsum,ods.RadCloud))

grid on
%%


%%

function x = OptimalGrowthTemperature(Tsum,Rad)
    if size(Tsum,2)~=1
       error('Tsum debe ser una columna') 
    end
    x = (Rad> 100).*OptimalGrowthTemperatureDay(Tsum) + ...
        (Rad<= 100).*OptimalGrowthTemperatureNight(Tsum);
end


function x = OptimalGrowthTemperatureDay(Tsum)
    if size(Tsum,2)~=1
       error('Tsum debe ser una columna') 
    end
        % Tmin Topt_min Topt_max Tmax
    x =   [11      18      25     40  ].*(Tsum < 400) + ...
          [12      21      24     35  ].*(Tsum >= 400).*(Tsum<1800) + ...
          [15      20      25     30  ].*(Tsum>=1800);  
end

function x = OptimalGrowthTemperatureNight(Tsum)
    if size(Tsum,2)~=1
       error('Tsum debe ser una columna') 
    end
    x = [11 15 18 50 ].*(Tsum < 400) + ...
        [13 50 50 50].*(Tsum >= 400).*(Tsum<1800) + ...
        [0 14 50  50].*(Tsum>=1800);  
end

