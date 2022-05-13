clear 

load("CS3_7_all_cum_production.mat")

clf
grid on
hold on
for i = 1:8
    plot(new_ds_prod_2{i}.DateTime,new_ds_prod_2{i}.MatureFruit/3200,'LineWidth',2)
end
ylabel('Crop [kg/m^2]')