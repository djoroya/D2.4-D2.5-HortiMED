figure(19)
clf
subplot(3,1,1)
plot(DT_span,consumo.heater + consumo.screen + consumo.windows + consumo.heater_on)
subplot(3,1,2)
total = consumo.heater + consumo.heater + consumo.windows;
plot(DT_span,24*3600*cumtrapz(rt_tout,total)/3.6e+6)
ylabel('kWh')