figure(2)
clf
xlims = [datetime('15-Feb-2022 01:00:00') datetime('20-Feb-2022 01:00:00')]
xlims = [datetime('15-Feb-2022 01:00:00') datetime('20-Feb-2022 01:00:00')]

hold on
plot(r.DateTime,r.Inclinom_Inclinom,'-')
plot(DT_span,cc_ds.Windows__value,'--')
legend('Grafana','Model')
title('Windows Signal')
%xlim(xlims)
