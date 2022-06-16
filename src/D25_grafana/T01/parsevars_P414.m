load('P414_1_model03_comp.mat')

idx = (diff(rt_tout)*24*3600 >= 1);

new_rt_tout = rt_tout(idx);
new_rt_yout = rt_yout;
new_rt_yout.time = new_rt_tout;
for i=[1 3 7 11]
    sg = rt_yout.signals(i).values;
    sg_p = permute(sg,[3 1 2]);
    sg_interp1 = interp1(rt_tout,sg_p,new_rt_tout);
    new_rt_yout.signals(i).values  = permute(sg_interp1,[2 3 1]);
end

for i=[2 4 5 6 8 9 10]
    sg = rt_yout.signals(i).values;
    sg_interp1 = interp1(rt_tout,sg,new_rt_tout);
    new_rt_yout.signals(i).values  = sg_interp1;
end

rt_yout = new_rt_yout;
rt_tout = new_rt_tout;
%%
DT_span = ds.DateTime(1) + days(rt_tout);

crop_matrix = rt_yout.signals(1).values;
crop_ds = parseCrop_matrix(crop_matrix);
crop_st =  parseTable2Struct(crop_ds);
%
crop_matrix_2 = rt_yout.signals(11).values;
crop_ds_2 = parseCrop_matrix(crop_matrix_2);
crop_st_2 =  parseTable2Struct(crop_ds_2);
%
clima_matrix = rt_yout.signals(2).values;
clima_ds = parseIndoorClimate_matrix(clima_matrix);
clima_st =  parseTable2Struct(clima_ds);

%
subs_matrix = rt_yout.signals(3).values;
subs_ds = parseSubstrate_matrix(subs_matrix);
subs_st =  parseTable2Struct(subs_ds);
%
cc_matrix = rt_yout.signals(4).values;
cc_ds = parseControlClimate_matrix(cc_matrix);
cc_st = parseTable2Struct(cc_ds); 
%

%
PowerH2GH  = rt_yout.signals(5).values(:,1);
PowerH2COM = rt_yout.signals(5).values(:,2);
Th         = rt_yout.signals(5).values(:,3);
QV_h_e     = rt_yout.signals(5).values(:,4);

%
%
tomato = (1/crop.fraction_DM)*(rt_yout.signals(9).values +rt_yout.signals(10).values )*crop.A_v;


%
ft = permute(rt_yout.signals(7).values,[1 3 2]);
ft_st.f = ft(1,:);
ft_st.T = ft(2,:);
ft_st.X = ft(3:end,:);
    