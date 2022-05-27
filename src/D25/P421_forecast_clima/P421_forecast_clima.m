clear 

 [ds,ds_daily] = ForecastExteriorClimate;
%%
t = readtable('ds.csv');
%%
figure(4)
clf
hold on 
plot(ds.tspan  ,ds.Temperature)
plot(ds.tspan  ,interp1(ds_daily.DateTime  ,ds_daily.tmin,ds.tspan,'nearest','extrap'),'Marker','.','LineStyle','none')
plot(ds.tspan  ,interp1(ds_daily.DateTime  ,ds_daily.tmax,ds.tspan,'nearest','extrap'),'Marker','.','LineStyle','none')
legend('T','T_{min}','T_{max} ','Location','best')
grid on 
box on