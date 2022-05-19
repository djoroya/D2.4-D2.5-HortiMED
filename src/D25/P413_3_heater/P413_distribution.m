
xline = linspace(-10,90);
yline = linspace(-10,50);

[xms,yms] = meshgrid(xline,yline);

%%
fig =figure('unit','norm','pos',[0 0 0.5 0.5])
%gauss = @(xms,yms,x0,y0,)

sigma_x= 0.5*20;
sigma_y= 0.5*15;

sigma_x2 = 30;
sigma_y2 = 10;

Tms = 2+8*exp(-(xms-0).^2/sigma_x^2 + -(yms-30).^2/sigma_y^2) + ...
        8*exp(-(xms-0).^2/sigma_x^2 + -(yms-10).^2/sigma_y^2) + ...
        8*exp(-(xms-80).^2/sigma_x^2 + -(yms-10).^2/sigma_y^2) + ...
        8*exp(-(xms-80).^2/sigma_x^2 + -(yms-30).^2/sigma_y^2) + ...
        2*exp(-(xms-40).^2/sigma_x2^2 + -(yms-20).^2/sigma_y2^2);
hold on
rectangle('Position',[0 0 80 40],'LineWidth',8)

surf(xms,yms,10 + (yms>0).*(xms>0).*(xms>0).*(xms<80).*(yms<40).*Tms)
view(0,-90)
shading interp
daspect([ 1 1 1])
colorbar
ylabel('y(m)')
xlabel('x(m)')
title('')
colormap(jet(50))
caxis([5 27])

text(2,30,'Heater 01','FontSize',15,'FontWeight','b')
text(2,10,'Heater 02','FontSize',15,'FontWeight','b')
text(65,30,'Heater 03','FontSize',15,'FontWeight','b')
text(65,10,'Heater 04','FontSize',15,'FontWeight','b')

text(27,-5,'Outdoor Temperature','FontSize',15,'FontWeight','b')
text(27,20,'Indoor Temperature','FontSize',15,'FontWeight','b')
box()

%%

pathfile = which('P413_3_clima');
pathfile = replace(pathfile,'P413_3_clima.m','');
pathfile = fullfile(pathfile,'heater_distri.png');

print(fig,'-dpng',pathfile)
