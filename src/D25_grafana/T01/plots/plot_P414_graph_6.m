figure(6)
clf
subplot(2,2,1)
hold on
plot(r.DateTime,r.Radiacion_Radiacion)
plot(r.DateTime,r.RadiacionEuskalmet_Sol)
plot(DT_span,clima_ds.QS__R_int)
legend('R_i(real)','R_e','R_i(sim)')
xlim(xlims)

subplot(2,2,2)
plot(DT_span,cc_ds.Screen__value)
xlim(xlims)

%
subplot(2,2,3)

hold on

plot(r.RadiacionEuskalmet_Sol,r.Radiacion_Radiacion,'.')
    %
Re_sim = rt_yout.signals(6).values(:,2);

plot(Re_sim,clima_ds.QS__R_int)

subplot(2,2,4)

plot(DT_span,clima_ds.QS__R_int*crop.A_v)


xlim(xlims)
