
figure(9)
clf 
subplot(6,1,1)
hold on 


% plot(DT_span,clima_ds.Gas__C_ce_ppm)
% plot(DT_span,clima_ds.Gas__C_c_ppm)
% plot(r.DateTime,r.CO2_CO2);
%

plot(DT_span,clima_ds.Gas__C_ce)
plot(DT_span,clima_ds.Gas__C_c)
CO2_ms = ccppm2kg(r.CO2_CO2,r.Temperatura_Temperatura);
plot(r.DateTime,CO2_ms);
%
grid on
yyaxis right 

%plot(r.DateTime,r.Inclinom_Inclinom,'--')
legend('C_e','C_i','C_i^{real}')
xlim(xlims)

subplot(6,1,2)
hold on
plot(DT_span,-clima_ds.Gas__MC__MC_i_e)
plot(DT_span,clima_ds.Gas__MC__MC_v_i)
%plot(DT_span,clima_ds.Gas__MC__MC_pump)
legend('MC_{ie}','MC_{vi}')
grid on
ylim([-0.8e-7 0.8e-7])
xlim(xlims)

subplot(6,1,3)
hold on 

plot(DT_span,crop_ds.photo__PAR)


xlim(xlims)

subplot(6,1,4)
hold on
plot(DT_span,crop_ds.carbon_cc__MC_stem_i)
plot(DT_span,crop_ds.carbon_cc__MC_fruit_i)
plot(DT_span,crop_ds.carbon_cc__MC_i_buf)
plot(DT_span,crop_ds.carbon_cc__MC_leaf_i)
plot(DT_span,crop_ds.carbon_cc__MC_stem_i)
yyaxis right
plot(DT_span,crop_ds.Carbon__Cbuff)
xlim(xlims)
legend('steam->i','fruit->i','i->buff','leaf->i','stem->i','C_buff')
grid on

subplot(6,1,5)
hold on
plot(DT_span,crop_ds.photo__Resp)
yyaxis right
plot(DT_span,crop_ds.photo__P)
legend('R','P')
grid on

xlim(xlims)

subplot(6,1,6)
hold on
plot(DT_span,crop_ds.photo__J)
plot(DT_span,crop_ds.photo__J_pot)

legend('J','J_pot')
xlim(xlims)

function r = ccppm2kg(x,T)
    r = (x/1e6)*0.044*101300./(8.3140*(T+273.15));
    %r = (x/1e6)*101300./(8.3140*(T+273.15));
end 