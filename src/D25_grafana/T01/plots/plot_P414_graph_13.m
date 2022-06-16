figure(13)
clf

subplot(2,1,1)
hold on
plot(DT_span,clima_ds.QS__QS_i_abs)
plot(DT_span,clima_ds.QV__QV_i)
plot(DT_span,-clima_ds.QV__QV_i_c)
plot(DT_span,-clima_ds.QV__QV_i_e)
plot(DT_span,-clima_ds.QV__QV_i_f)
plot(DT_span,-clima_ds.QT__Qfog)
xlim(xlims)
legend('QS','QV_h','QV_ic','QV_ie','QV_if','QT')

subplot(2,1,2)
hold on
plot(DT_span,-crop_ds.HeatVars__QV)
%plot(DT_span,PowerH2COM)
plot(DT_span,-crop_ds.HeatVars__QT)
plot(DT_span,-crop_ds.HeatVars__QT -crop_ds.HeatVars__QV)

legend('QV','QT')
xlim(xlims)
