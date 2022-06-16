figure(22)
clf
subplot(5,1,1)
plot(DT_span,rt_yout.signals(8).values(:,1:2))
xlim(xlims)
subplot(5,1,2)
plot(DT_span,rt_yout.signals(8).values(:,3))
xlim(xlims)

subplot(5,1,3)
plot(DT_span,rt_yout.signals(8).values(:,4))
xlim(xlims)

subplot(5,1,4)
plot(DT_span,rt_yout.signals(8).values(:,5))
xlim(xlims)

subplot(5,1,5)
plot(DT_span,rt_yout.signals(8).values(:,6))
xlim(xlims)
grid on