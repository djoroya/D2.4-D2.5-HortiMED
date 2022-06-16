figure(11)
clf
subplot(4,1,1)
hold on
plot(DT_span,(crop_ds.("Nutrients__Demand_1")))
plot(DT_span,(subs_ds.("Uptake__Nutrients_1")))
plot(DT_span,subs_ds.Drainge__f.*subs_ds.Uptake__Nutrients_1)
plot(DT_span,ft_st.X.*ft_st.f)

legend('Demand','Uptake','Drainge','Irrigation')
title('Nutrient Flow 1')
xlim(xlims)
%
%ylim([-1 4]*1e-8)
%
%
subplot(4,1,2)
hold on
plot(DT_span,crop_st.Nutrients.Mass(:,1))
%
CT = crop_ds.Carbon__Cfruit + crop_ds.Carbon__Cleaf + crop_ds.Carbon__Cstem;
CT =CT.*crop.Chi_nutrients(1);

plot(DT_span,CT,'--')

plot(DT_span,subs_ds.("Mass_1"))

yyaxis right
plot(DT_span,crop_st.C_Total)

legend('N in crop','Objetive','N in substrate')
title('Nutrient Mass in Crop')
xlim(xlims)


subplot(4,1,3)
hold on
for iter = 1:8
plot(DT_span,((subs_ds.("Drainge__X_"+iter))))
end
title('Drainge Concentration')

xlim(xlims)

%

subplot(4,1,4)
hold on
for iter = 1:8
plot(DT_span,subs_ds.("Mass_"+iter))
end
title('Mass in substrate')
legend
xlim(xlims)




