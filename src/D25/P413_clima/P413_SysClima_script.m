clear

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
clf
jds = subselect_date(ids(6),[datetime('08-Jan-2017') datetime('20-Jan-2017')]);

t = jds.DateTime
sty = {'LineWidth',2};

subplot(4,1,1)
hold on
plot(t,jds.DataSet.HRInt,sty{:})
plot(t,jds.DataSet.MaxHR,sty{:})
plot(t,jds.DataSet.HRExt,sty{:})
yyaxis right
plot(t,jds.DataSet.EstadoCenitalE,sty{:})
legend('HRInt','MaxHR','HRExt','Windows','Location','bestoutside')
%
subplot(4,1,2)
hold on
plot(t,jds.DataSet.Text,sty{:})
plot(t,jds.DataSet.TVentilacin,sty{:})
plot(t,jds.DataSet.Tinv,sty{:})
yyaxis right
plot(t,jds.DataSet.EstadoCenitalE,sty{:})
%
legend('Text','Tven','Tinv','Windows','Location','bestoutside')

subplot(4,1,3)
hold on
plot(t,jds.DataSet.RadExt,sty{:})
plot(t,jds.DataSet.RadInt,sty{:})
yyaxis right

plot(t,jds.DataSet.EstadoPant1,sty{:})
legend('RadExt','RadInt','Pant','Location','bestoutside')

%
subplot(4,1,4)
plot(t,jds.DataSet.Vviento,sty{:})
legend('Wind','Location','bestoutside')

%%
