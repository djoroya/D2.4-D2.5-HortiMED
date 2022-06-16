
  
figure(18)
clf
subplot(2,1,1)
plot(DT_span,ft_st.f)
xlim(xlims)

subplot(2,1,2)
plot(DT_span,ft_st.X.*ft_st.X)
xlim(xlims)