figure(4)
clf
subplot(3,1,1)
hold on

plot(DT_span,-PowerH2GH)

plot(DT_span,+PowerH2COM)
plot(DT_span,-QV_h_e)

xlim(xlims)
grid on 
legend('QV_h-GH','QV_h','QV_he')

subplot(3,1,2)
hold on
plot(DT_span,Th)
plot(DT_span,crop_ds.HeatVars__Tveg)
plot(DT_span,clima_ds.Temp__Tair)
legend('Th','Tv','Tair')
xlim(xlims)
grid on 
subplot(3,1,3)
plot(DT_span,-PowerH2GH+PowerH2COM-QV_h_e)
xlim(xlims)
grid on 