clear 

 [ds,ds_daily] = ForecastExteriorClimate;
%%
t = readtable('ds.csv');
%%
figure(4)
clf
hold on 
plot(ds.tspan  ,ds.Temperature)
plot(ds.tspan  ,interp1(ds_daily.DateTime  ,ds_daily.tmin,ds.tspan,'nearest','extrap'),'Marker','.','LineStyle','none')
plot(ds.tspan  ,interp1(ds_daily.DateTime  ,ds_daily.tmax,ds.tspan,'nearest','extrap'),'Marker','.','LineStyle','none')
legend('T','T_{min}','T_{max} ','Location','best')
grid on 
box on

%%
load('CS3_5_ExteriorClima')
%%
figure('Color','w')
T  = ods.T-274.15;
T = smoothdata(T);
tspan = days(D - D(1))
Tforecast = T + (tspan<=1)*0.5 +(tspan<=7).*(tspan>1).*sin(2*pi*tspan)*0.8 + (tspan>7).*( sin(2*pi*tspan) +sin(0.5*pi*tspan) +3*sin(0.25*pi*tspan) + 2*sin(0.125*pi*tspan) )    
D = ods.DateTime+years(4);
clf
ax =subplot(2,1,1);
hold on

plot(D,T,'LineWidth',2)
plot(D,Tforecast,'LineWidth',2)

xlim([datetime('01-Jan-2020') datetime('01-Feb-2020') ])
grid on
%

area([D(1) D(1) D(1)+day(1)  D(1)+day(1)],[50 50 50 50],'FaceColor',[0.5 1 0.5],'FaceAlpha',0.3)
area([D(1)+day(1)  D(1)+day(1) D(1)+day(7) D(1)+day(7)],[50 50 50 50],'FaceColor',[1 1 0.5],'FaceAlpha',0.3)
area([D(1)+day(7)  D(1)+day(7) D(end) D(end)],[50 50 50 50],'FaceColor',[1 0.5 0.5],'FaceAlpha',0.3)
%
legend('real','forecast')
ylabel('Exterior Temperature [ºC]')
box
ax.Children = [ax.Children(end) ;ax.Children(1:end-1)] 
ylim([0 22])

%
H  = ods.H;
H = smoothdata(H);
tspan = days(D - D(1));
Hforecast = H + (tspan<=1)*0.5 +(tspan<=7).*(tspan>1).*sin(2*pi*tspan)*3.5 + (tspan>7).*( 0.15*tspan.*sin(2*pi*tspan) +5*sin(0.5*pi*tspan) +7*sin(0.25*pi*tspan) + 6*sin(0.125*pi*tspan)  ); 
D = ods.DateTime+years(4);
ax =subplot(2,1,2);
hold on

Hp = plot(D,H,'LineWidth',2)
Hpf =plot(D,Hforecast,'LineWidth',2)

xlim([datetime('01-Jan-2020') datetime('01-Feb-2020') ])
grid on
%

area([D(1) D(1) D(1)+day(1)  D(1)+day(1)],[150 150 150 150],'FaceColor',[0.5 1 0.5],'FaceAlpha',0.3)
area([D(1)+day(1)  D(1)+day(1) D(1)+day(7) D(1)+day(7)],[150 150 150 150],'FaceColor',[1 1 0.5],'FaceAlpha',0.3)
area([D(1)+day(7)  D(1)+day(7) D(end) D(end)],[150 150 150 150],'FaceColor',[1 0.5 0.5],'FaceAlpha',0.3)
%

ylabel('Exterior Relative Humidity [%]')
box
ax.Children = [ax.Children(end) ;ax.Children(1:end-1)] 
ylim([30 100])

legend([Hpf Hp ],'forecast','real')
