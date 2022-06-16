figure(17)
clf
subplot(3,1,1)
plot(DT_span,abs(gradient(cc_st.Screen.value,rt_tout)))
xlim(xlims)
subplot(3,1,2)
plot(DT_span,cumsum(abs(gradient(cc_st.Screen.value,rt_tout))))
xlim(xlims)

subplot(3,1,3)
plot(DT_span,abs((cc_st.Screen.value)))
xlim(xlims)
