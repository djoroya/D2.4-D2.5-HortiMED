clear 

load("CS3_7_all_cum_production.mat")
fig = figure('units','normalized','Position',[0.5 0.5 0.5 0.5])
clf
grid on
hold on
grid on
box on
color = hsv(4);
year_list = zeros(4,1);
for i = 1:4
    year_list(i) = new_ds_prod_2{2*i-1}.DateTime(1).Year;
    line_list(i) = plot(new_ds_prod_2{2*i-1}.DateTime - years(new_ds_prod_2{2*i-1}.DateTime(1).Year),new_ds_prod_2{2*i-1}.MatureFruit/3200,'LineWidth',2,'color',color(i,:));
    plot(new_ds_prod_2{2*i}.DateTime - years(new_ds_prod_2{2*i}.DateTime(1).Year),new_ds_prod_2{2*i}.MatureFruit/3200,'LineWidth',2,'color',color(i,:))
end
ax = gca;

for j = 1: length(ax.XTickLabel)
    ax.XTickLabel{j}(end) = '';
end

ylabel('Crop [kg/m^2]')
legend(line_list,num2str(year_list))



r = which('P412_2_crop_plot');
r = replace(r,'P412_2_crop_plot.m','');

print(fig,fullfile(r,'P412.png'),'-dpng')