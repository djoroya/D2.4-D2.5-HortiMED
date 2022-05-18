clear 
load('P413_2_model_spesession')
%%
experiment = SDOSessionData.Data.Workspace.LocalWorkspace.Exp;

%%
Screen_ts = experiment.InputData.Values;
T_ts = experiment.OutputData(1).Values;
R_ts = experiment.OutputData(2).Values;
%%
figure()
subplot(3,1,1)
plot(Screen_ts.Time,Screen_ts.Data)
subplot(3,1,2)
plot(T_ts.Time,T_ts.Data)
subplot(3,1,3)
plot(R_ts.Time,R_ts.Data)
