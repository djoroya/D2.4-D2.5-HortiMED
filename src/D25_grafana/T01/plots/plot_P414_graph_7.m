figure(7)
clf
subplot(2,1,1)
hold on
plot(DT_span,clima_ds.Gas__C_w,'-' )
plot(DT_span,clima_ds.Gas__C_w_sat_T_c,'-' )
plot(DT_span,clima_ds.Gas__C_w_sat_T_f,'-' )

legend('C_w','C_w^{*}(T_c)','C_w^{*}(T_f)')
xlim(xlims)

subplot(2,1,2)
hold on
plot(DT_span,clima_ds.Gas__MW__MW_i_e,'-' )
plot(DT_span,clima_ds.Gas__MW__Qfog,'-' )
plot(DT_span,clima_ds.Gas__MW__QP_i_c,'-' )
plot(DT_span,clima_ds.Gas__MW__QP_i_f,'-' )
plot(DT_span,clima_ds.Gas__MW__QT,'-' )
legend('MW_{ie}','Q_{fog}','QP_{ic}','QP_{if}','QT')

xlim(xlims)
