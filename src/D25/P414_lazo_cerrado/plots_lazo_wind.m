clear 
load('CS3_9_sysclima_with_heater')
%load('data/CS3_8_sysclima_clean.mat')
ids = ids_heater;
%ids = ds_cell{end};
tspan = days(ids.DateTime - ids.DateTime(1));
ib = (ids.DateTime > datetime('06-Mar-2017')).*(ids.DateTime < datetime('20-Mar-2017'));
ids = ids(logical(ib),:);
%ids.RadExt = smoothdata(ids.RadExt,'SmoothingFactor',0.02);
%ids.RadInt = smoothdata(ids.RadInt,'SmoothingFactor',0.02);
ids.EstadoPant1 = smoothdata(ids.EstadoPant1,'SmoothingFactor',0.02);

%%
fig = figure('unit','norm','pos',[0 0 0.4 0.8])

subplot(2,1,1)
hold on
plot(ids.DateTime,ids.Tinv,'LineWidth',2);
plot(ids.DateTime,ids.TVentilacin,'LineWidth',2)

yyaxis right
plot(ids.DateTime,ids.EstadoCenitalE,'LineWidth',2)

%xlim([datetime('10-Apr-2019') datetime('23-Apr-2019')])
grid on

subplot(2,1,2)
hold on
plot(ids.Tinv - ids.TVentilacin,(ids.EstadoCenitalE),'.')
%
fig2 = figure('unit','norm','pos',[0 0 0.4 0.8])

subplot(2,1,1)
hold on
plot(ids.DateTime,ids.HRInt,'LineWidth',2);
plot(ids.DateTime,ids.MaxHR,'LineWidth',2)
yyaxis right
plot(ids.DateTime,ids.EstadoCenitalE,'LineWidth',2)

%xlim([datetime('14-Apr-2019') datetime('23-Apr-2019')])

subplot(2,1,2)
%
hold on
%
idx = ids.RadExt <  200;
scatter3(ids.Tinv(idx) - ids.TVentilacin(idx),ids.HRInt(idx) - ids.MaxHR(idx),ids.EstadoCenitalE(idx))
view(3)

%subplot(2,2,4)

%%
idx = (ids.Tinv - ids.TVentilacin) < -5;
plot(ids.HRInt(idx) - ids.MaxHR(idx),(ids.EstadoCenitalO(idx)),'.')
idx = (ids.Tinv - ids.TVentilacin) >= -5;

%plot(ids.HRInt(idx) - ids.MaxHR(idx),(ids.EstadoCenitalE(idx)),'.')

%%
Tlaw = @(dT) 20*dT + 50;
Hlaw = @(dH) -4*dH - 100 ;
%

Tlaw1 = @(dT) -20*dT - 150;
Hlaw1 = @(dH) 4*dH  ;

sat = @(zms) (zms>0).*(zms<100).*zms + 100*(zms>=100);

sat2 = @(zms) (zms>0).*(zms<50).*zms + 50*(zms>=50);

dT_span = linspace(-15,15);
dH_span = linspace(-80,15);
%
[dT_ms,dH_ms] = meshgrid(dT_span,dH_span);
%
fig = figure('unit','norm','pos',[0 0 0.4 0.8])
subplot(2,1,1)
surf(dT_ms,dH_ms,sat(+Tlaw(dT_ms) + Hlaw(dH_ms)),'FaceAlpha',0.5)
shading interp
title('Day')
%
hold on
%
idx = ids.RadExt >= 200;
scatter3(ids.Tinv(idx) - ids.TVentilacin(idx),ids.HRInt(idx) - ids.MaxHR(idx),ids.EstadoCenitalE(idx),'o')
%
legend('Control Law','data')
view(3)
grid on
xlabel('\Delta T [ºC]')
ylabel('\Delta H [%]')
zlabel('Windows [%]')
subplot(2,1,2)

id_bm = sat(+Tlaw(dT_ms) + Hlaw(dH_ms)) > 10;

surf(dT_ms,dH_ms,~id_bm.*sat2(+Tlaw1(dT_ms) + Hlaw1(dH_ms)) +  id_bm.*sat(+Tlaw(dT_ms) + Hlaw(dH_ms)) ...
                ,'FaceAlpha',0.5)
shading interp
%
title('Night')

hold on
%
idx = ids.RadExt <200;
scatter3(ids.Tinv(idx) - ids.TVentilacin(idx),ids.HRInt(idx) - ids.MaxHR(idx),ids.EstadoCenitalE(idx),'o')
%
legend('Control Law','data')
view(3)
grid on
xlabel('\Delta T')
ylabel('\Delta H')
zlabel('Windows [%]')


%%
%%
pathfile = which('plots_lazo');
pathfile = replace(pathfile,'plots_lazo.m','');
pathfile = fullfile(pathfile,'windows.png');

print(fig,'-dpng',pathfile)

