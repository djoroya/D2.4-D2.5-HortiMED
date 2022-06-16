figure(15)
clf

subplot(3,1,1)

plot(DT_span,clima_ds.QS__R_int*crop.A_v)
xlim(xlims)
title('MW QS')

subplot(3,1,2)
plot(DT_span,crop_ds.HeatVars__QT)
title('QT')
xlim(xlims)

subplot(3,1,3)
plot(DT_span,clima_ds.Gas__MW__QT/crop.A_v)
xlim(xlims)
title('MW QT')