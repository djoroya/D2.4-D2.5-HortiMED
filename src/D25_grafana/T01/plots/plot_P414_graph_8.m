figure(8)
clf
subplot(2,2,1)
hold on
plot(DT_span,crop_ds.Carbon__Cbuff)
plot(DT_span,crop_ds.Carbon__Cfruit)
plot(DT_span,crop_ds.Carbon__Cleaf)
plot(DT_span,crop_ds.Carbon__Cstem)
xlim(xlims)
legend('C_{buff}','C_{fruit}','C_{leaf}','C_{stem}')
%
subplot(2,2,3)
hold on
plot(DT_span,crop_ds.MC_gro__MC_buf_fruit)
plot(DT_span,crop_ds.MC_gro__MC_buf_leaf)
plot(DT_span,crop_ds.MC_gro__MC_buf_stem)
xlim(xlims)
legend('MC_{buff->fruit}','MC_{buff->leaf}','MC_{buff->fruit}','MC_{buff->stem}')

subplot(2,2,2)
hold on
plot(DT_span,crop_ds_2.Carbon__Cbuff)
plot(DT_span,crop_ds_2.Carbon__Cfruit)
plot(DT_span,crop_ds_2.Carbon__Cleaf)
plot(DT_span,crop_ds_2.Carbon__Cstem)
xlim(xlims)
legend('C_{buff}','C_{fruit}','C_{leaf}','C_{stem}')
%
subplot(2,2,4)
hold on
plot(DT_span,crop_ds_2.MC_gro__MC_buf_fruit)
plot(DT_span,crop_ds_2.MC_gro__MC_buf_leaf)
plot(DT_span,crop_ds_2.MC_gro__MC_buf_stem)
xlim(xlims)
legend('MC_{buff->fruit}','MC_{buff->leaf}','MC_{buff->fruit}','MC_{buff->stem}')

