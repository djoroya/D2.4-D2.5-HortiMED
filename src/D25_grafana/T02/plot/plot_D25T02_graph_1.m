figure(1)
clf
subplot(4,1,1)

hold on
T_k = 273.15;
plot(ds.DateTime,ds.temperature,'-')
plot(DT_span,IC_st.Temp.Tair - T_k)
plot(niof.DateTime,niof.ambient_temp_Fish_Pond_P_1,'-')

title('Fish Greenhouse GH3')
legend('T_e','T_i^{sim}','T_i^{real}')
xlim(xlims)

subplot(4,1,2)
hold on
plot(DT_span,IC_st.QS.QS_c_abs)
plot(DT_span,IC_st.QS.QS_f_abs)
plot(DT_span,IC_st.QS.QS_i_abs)
xlim(xlims)

subplot(4,1,3)
hold on
plot(DT_span,IC_st.QS.R_int)
plot(ds.DateTime,ds.radiation)
xlim(xlims)

subplot(4,1,4)
hold on
plot(DT_span,IC_st.Gas.HRInt,'color','r')
plot(niof.DateTime,niof.ambinet_Humi_Fish_Pond_P_1,'color','r','marker','o')
plot(ds.DateTime,ds.humidity,'-')
legend('HR_i^{sim}','HR_{i}^{real}','HR_{e}')
xlim(xlims)
