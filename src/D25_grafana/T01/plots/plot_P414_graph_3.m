figure(3)
clf
hold on
plot(ds.DateTime,ds.humidity,'color','b')
plot(r.DateTime,r.Humedad_Humedad,'color','r')
plot(DT_span,clima_ds.Gas__HRInt,'-' )
legend('HR_{ext}','HR_{real}','HR_{sim}')
xlim(xlims)
