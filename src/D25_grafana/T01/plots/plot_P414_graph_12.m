figure(12)
clf

%datelims = [datetime('2022-Feb-15') datetime('2022-Feb-17')];
subplot(3,1,1)
hold on

plot(DT_span,subs_ds.SusWater__VT,'--')
yline(subtrate.Vmin_subs/3,'--')
plot(DT_span,crop_st.WC)
plot(DT_span,crop_st.Water.WaterState.VegWater)
%yline(subtrate.Vmax_subs/3)

grid on
legend('VT','Vmin','WCapacity','Water Content')
%xlim(datelims);
xlim(xlims)
subplot(3,1,2)
hold on
%plot(DT_span,log(abs(subs_ds.Uptake__Water)))
plot(DT_span,((crop_ds.Water__WaterFlows__WaterDemand)),'-');
plot(DT_span,((crop_ds.Water__WaterFlows__WaterUptake)),'-')
plot(DT_span,(-(crop_ds.Water__WaterFlows__MW_QT)),'-')

plot(DT_span,(-(subs_ds.Uptake__Water)),'--')
plot(DT_span,(-(subs_ds.Drainge__f)),'--')
plot(DT_span,ft_st.f,'-')

xlim(xlims)
legend('Wdemand','Wuptake_crop','QT','Wuptake_subs','Drainge','Irrigation','Interpreter','none')
%xlim(datelims);

subplot(3,1,3)
hold on
%plot(DT_span,log(abs(subs_ds.Uptake__Water)))
plot(DT_span,((crop_ds.Water__WaterFlows__WaterUptake)),'-')

plot(DT_span,(-(subs_ds.Uptake__Water)),'--')
%plot(DT_span,(-(subs_ds.Drainge__f)),'--')

xlim(xlims)
legend('Wuptake_crop','Wuptake_subs','Interpreter','none')
%xlim(datelims);