figure(21)
clf
subplot(4,1,1)
hold on
plot(DT_span,consumo_cum.electrical.screen)
plot(DT_span,consumo_cum.electrical.windows)
plot(DT_span,consumo_cum.electrical.total)
plot(DT_span,consumo_cum.electrical.heater)
plot(DT_span,consumo_cum.electrical.irrigation)

legend('screen','windows','total','heater','irrigation')

subplot(4,1,2)
plot(DT_span,consumo_cum.thermal.heater)
legend('thermal')
subplot(4,1,3)

plot(DT_span,consumo_cum.nutrients)
legend("nutrients"+(1:8)')

subplot(4,1,4)

plot(DT_span,consumo_cum.water)
legend('water')