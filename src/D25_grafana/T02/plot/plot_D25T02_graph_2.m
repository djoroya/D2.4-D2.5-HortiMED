figure(2);

clf
subplot(3,1,1)
hold on
plot(DT_span,IC_st.Temp.Tair - T_k)
plot(niof.DateTime,niof.ambient_temp_Fish_Pond_P_1,'color','b','marker','.')

plot(niof.DateTime,niof.Temp_Bot_Fish_Pond_P_1,'color','r','marker','.')

plot(DT_span,WT_st.Fout.T - T_k,'color','r')
plot(DT_span,WT_st.Twall - T_k)
xlim(xlims)
%%
subplot(3,1,2)

hold on
plot(DT_span,IC_st.Gas.HRInt,'color','r')
plot(niof.DateTime,niof.ambinet_Humi_Fish_Pond_P_1,'color','r','marker','o')
plot(ds.DateTime,ds.humidity,'-')
legend('HR_i^{sim}','HR_{i}^{real}','HR_{e}')
xlim(xlims)
%%
subplot(3,1,3)
plot(DT_span,WT_st.QT)