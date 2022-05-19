clear 

load('data/CS3_8_sysclima_clean.mat')
%ids = ids_heater;
ids = ds_cell{end};
tspan = days(ids.DateTime - ids.DateTime(1));
ib = (ids.DateTime > datetime('15-Mar-2019')).*(ids.DateTime < datetime('10-May-2019'));
ids = ids(logical(ib),:);
%ids.RadExt = smoothdata(ids.RadExt,'SmoothingFactor',0.02);
%ids.RadInt = smoothdata(ids.RadInt,'SmoothingFactor',0.02);
ids.EstadoPant1 = smoothdata(ids.EstadoPant1,'SmoothingFactor',0.02);

%%
fig = figure('unit','norm','pos',[0 0 0.4 0.8])

subplot(2,1,1)
hold on
plot(ids.DateTime,ids.RadExt,'LineWidth',2)
plot(ids.DateTime,ids.RadInt,'LineWidth',2,'LineStyle','--')
yyaxis right
plot(ids.DateTime,ids.EstadoPant1,'LineWidth',2)

xlim([datetime('14-Apr-2019') datetime('23-Apr-2019')])
grid on
title('$Radiation [W/m^2]$','Interpreter','latex','FontSize',14)
legend('R_e','R_i','Screen')
subplot(2,1,2)
hold on
plot(ids.RadExt,(ids.EstadoPant1),'.')

maxRad = max(ids.RadExt);
minRad = min(ids.RadExt);
Rad_span = linspace(minRad,maxRad,90);

means_Rad = [];
for i = 2:90
    idb = (Rad_span(i-1)<ids.RadExt).*(Rad_span(i)>=ids.RadExt);
    idb = logical(idb);
    means_Rad(i-1) = mean(ids.EstadoPant1(idb));
end

plot(Rad_span(1:end-1),means_Rad,'-','LineWidth',2)
xlabel('$R_i \ (W/m^2)$','Interpreter','latex','FontSize',14)
ylabel('$u_w \ [\%] \ (Windows) $','Interpreter','latex','FontSize',14)
title('$u_w = \mathcal{F}(R_e)$','Interpreter','latex','FontSize',16)
xlim([0 1e3])
legend('data','mean')
grid on
%%
%%
pathfile = which('plots_lazo');
pathfile = replace(pathfile,'plots_lazo.m','');
pathfile = fullfile(pathfile,'heater_distri.png');

print(fig,'-dpng',pathfile)
