figure(5)
clf
subplot(6,1,1)

hold on 
plot(DT_span,clima_ds.Gas__C_c_ppm,'.-')
plot(r.DateTime,r.CO2_CO2)
plot(DT_span,clima_ds.Gas__C_ce_ppm,'.-')
grid on
legend('(CO_2)_i(sim)','(CO_2)_i(real)','(CO_2)_{ext}')
xlim(xlims)

subplot(6,1,2)
plot(DT_span,cc_ds.Windows__value,'-')
xlim(xlims)

subplot(6,1,3)
hold on
plot(DT_span,rt_yout.signals(6).values(:,1)-273.15)
legend('Te')
xlim(xlims)

%plot(DT_span,cc_ds.Windows__AR,'-')
subplot(6,1,4)

plot(DT_span,rt_yout.signals(6).values(:,2))
legend('Rad')
xlim(xlims)

subplot(6,1,5)

plot(DT_span,rt_yout.signals(6).values(:,3))
legend('wind')
xlim(xlims)

subplot(6,1,6)

plot(DT_span,rt_yout.signals(6).values(:,4))
xlim(xlims)

legend('HR_e')