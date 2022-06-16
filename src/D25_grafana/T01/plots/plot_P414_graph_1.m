figure(1)

clf

subplot(3,1,1)
hold on
plot(ds.DateTime,ds.temperature,'--','color','b','LineWidth',2)
plot(DT_span,clima_ds.Temp__Tair - 273.15,'-','color','r','LineWidth',2)
plot(r.DateTime,r.Temperatura_Temperatura,'LineStyle','none','color','r','LineWidth',1,'Marker','o')
plot(DT_span,Th-273.15)
plot(DT_span,clima_ds.Temp__Tcover - 273.15,'-')
plot(DT_span,clima_ds.Temp__Tfloor - 273.15,'-')
plot(DT_span,crop_ds.HeatVars__Tveg - 273.15,'-','LineWidth',2,'color','g')

yyaxis right
plot(DT_span,clima_ds.QS__R_int,'--','color','k')

legend
xlim(xlims)
legend('T_e','T indoor Simulation','T indoor Real,','T_h','Tcover','Tfloor','T veg','R_i')
%legend('T_e','T indoor Simulation','T_h','Tcover','Tfloor','T_veg')

subplot(3,1,2)

hold on
plot(DT_span,PowerH2COM,'LineWidth',2)
plot(DT_span,PowerH2GH)
xlim(xlims)
legend('Q Heater')
legend('Q H2GH')

subplot(3,1,3)

plot(DT_span,cc_ds.Windows__value,'.-')
legend('Windows')
xlim(xlims)
