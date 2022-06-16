%%
figure(20)
clf
sty = {'Interpreter','latex','FontSize',20};
subplot(2,3,1)
bar(consumo_monthly.DateTime,consumo_monthly.water/1000)
ylabel('Monthly (m^3)')
yyaxis right
plot(consumo_monthly.DateTime,cumsum(consumo_monthly.water)/1000,'Marker','.','MarkerSize',30)
ylabel('Total (m^3)')
title('Water Cost',sty{:})
grid on
yline(3200)


subplot(2,3,2)
bar(consumo_monthly.DateTime,consumo_monthly.nutrients)
ylabel('kg')
title('Nutrients Cost',sty{:})
legend('N','K','Ca','Mg','P','S')
grid on
subplot(2,3,3)
bar(consumo_monthly.DateTime,consumo_monthly.thermal.heater/3.6e6)

ylabel('kWh')
yyaxis right
plot(consumo_monthly.DateTime,cumsum(consumo_monthly.thermal.heater/3.6e6),'Marker','.','MarkerSize',30)
yline(62000)

title('Thermal Cost',sty{:})
grid on





subplot(2,3,4)
bar(consumo_monthly.DateTime,struct2array(consumo_monthly.electrical)/3.6e6)
ylabel('kWh')
yyaxis right
plot(consumo_monthly.DateTime,cumsum(consumo_monthly.electrical.total/3.6e6),'Marker','.','MarkerSize',30)
vars = fieldnames(consumo_monthly.electrical);
legend([vars;'Cum'],'Location','northwest')
ylabel('kWh')

title('Electrical Cost',sty{:})
grid on
%close all
yline(4200)


subplot(2,3,5)
bar(consumo_monthly.DateTime,sum(consumo_monthly.nutrients,2))
ylabel('kg')
yyaxis right

plot(consumo_monthly.DateTime,cumsum(sum(consumo_monthly.nutrients,2)),'Marker','.','MarkerSize',30)

title('Nutrients Cost',sty{:})
grid on

yline(4800/2)


subplot(2,3,6)
hold on
bar(consumo_monthly.DateTime,consumo_monthly.production*1e-3)
%ylim([ inf])
yyaxis right
plot(consumo_monthly.DateTime,cumsum(consumo_monthly.production*1e-3),'Marker','.','MarkerSize',30)
yline(58/2)

%plot(DT_span,tomato)
%ylim([-1 inf])
grid on
ylabel('Toneladas {Tomato}')
title('Tomato Production',sty{:})