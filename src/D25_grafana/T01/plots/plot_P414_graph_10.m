
%close all
figure(10)
clf
subplot(3,3,1)
plot(DT_span,crop_ds.Tsum)
xlim(xlims)
subplot(3,3,2)
hold on
plot(DT_span,crop_ds.h__g_T_v24)
legend('h__g_T_v24')
xlim(xlims)

subplot(3,3,3)
hold on
plot(DT_span,crop_ds.h__h_T_v,'--')
legend('h__h_T_v','h__h_T_v24','Interpreter','none')
xlim(xlims)

subplot(3,3,4)
plot(DT_span,crop_ds.h__h_T_v24,'-')
legend('h__h_T_v24')
xlim(xlims)


subplot(3,3,5)
hold on
plot(DT_span,crop_ds.h__h_T_vsum,'-')
legend('h__h_T_vsum')
xlim(xlims)


subplot(3,3,6)

plot(DT_span,crop_ds.h__hini,'-')
xlim(xlims)

legend('h_hini','Interpreter','none')

subplot(3,3,7)
plot(DT_span,crop_ds.h__h_buforg_buf,'-')
legend('h__h_buforg_buf','Interpreter','none')
xlim(xlims)

%%
subplot(3,3,8)
cla
hold on
plot(DT_span,crop_ds.HeatVars__Tveg ,'--')
plot(DT_span,crop_ds.HeatVars__TvegMean,'--')
legend('Tv','Tv_mean')
xlim(xlims)
