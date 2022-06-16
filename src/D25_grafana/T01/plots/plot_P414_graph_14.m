figure(14)
clf
subplot(4,1,1)
hold on
plot(DT_span,clima_ds.QS__QS_i_abs)
plot(DT_span,clima_ds.QV__QV_i)
plot(DT_span,-clima_ds.QV__QV_i_c)
plot(DT_span,-clima_ds.QV__QV_i_e)
plot(DT_span,-clima_ds.QV__QV_i_f)
plot(DT_span,-clima_ds.QT__Qfog)
xlim(xlims)
legend('QS','QV_h','QV_ic','QV_ie','QV_if','QT')
subplot(4,1,2)
hold on
plot(DT_span,crop_ds.HeatVars__Tveg)
plot(DT_span,clima_ds.Temp__Tair)
plot(DT_span,Th)

xlim(xlims)
legend('Tveg','Tair','Th')

subplot(4,1,3)
hold on
plot(DT_span,PowerH2COM)
plot(DT_span,PowerH2GH)
xlim(xlims)
legend('Qheater','Q H2GH')

subplot(4,1,4)

hold on
plot(DT_span,-crop_ds.HeatVars__QT)
plot(DT_span,-crop_ds.HeatVars__QV)
xlim(xlims)

legend('QT','QV')
