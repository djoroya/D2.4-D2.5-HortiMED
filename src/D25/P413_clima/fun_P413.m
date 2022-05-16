function fig = fun_P413(idx,DateTimeInterval)
load('CS3_8_sysclima_clean.mat')

for i = 1:26
    ds_cell{i}.AlarmaLluvia = [];
    ds_cell{i}.AlarmaVto = [];
    ds_cell{i}.DireccinViento = [];
    ds_cell{i}.EstadoCenitalO = [];
end
%%
ids = arrayfun(@(i)TableSeries(ds_cell{i}),1:26);
%%
close all
fig = figure('unit','norm','pos',[0 0 0.6 0.5])
jds = subselect_date(ids(idx),DateTimeInterval);

t = jds.DateTime;
sty = {'LineWidth',2};

subplot(4,1,1)
hold on
grid on
plot(t,jds.DataSet.HRInt,sty{:})
plot(t,jds.DataSet.MaxHR,sty{:})
plot(t,jds.DataSet.HRExt,sty{:})
ylabel('Humidity (%)')
yyaxis right
plot(t,jds.DataSet.EstadoCenitalE,sty{:},'LineStyle','--','LineWidth',1,'color','k')
ylabel('Windows (%)')

legend('HRInt','MaxHR','HRExt','Windows','Location','best')
%
subplot(4,1,2)
hold on
grid on

plot(t,jds.DataSet.Text,sty{:})
plot(t,jds.DataSet.TVentilacin,sty{:})
plot(t,jds.DataSet.Tinv,sty{:})
ylabel('Temperature (ºC)')

yyaxis right
plot(t,jds.DataSet.EstadoCenitalE,sty{:},'LineStyle','--','LineWidth',1,'color','k')
%
ylabel('Windows (%)')

legend('Text','Tven','Tinv','Windows','Location','best')

subplot(4,1,3)
hold on
grid on

plot(t,jds.DataSet.RadExt,sty{:})
plot(t,jds.DataSet.RadInt,sty{:})
ylabel('Radiation (W/m^2)')

yyaxis right
ylabel('Screen (%)')

    plot(t,jds.DataSet.EstadoPant1,sty{:},'LineStyle','--','LineWidth',1,'color','k')
legend('RadExt','RadInt','Pant','Location','best')

%
subplot(4,1,4)
plot(t,jds.DataSet.Vviento,sty{:})
legend('Wind','Location','best')
ylabel('Wind (m/s)')

grid on
%%

end