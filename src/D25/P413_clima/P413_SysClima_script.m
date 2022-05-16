clear
%%

DateTimeInterval = [datetime('08-Jan-2017') datetime('20-Jan-2017')];
idx = 6;


r = which('P413_SysClima_script');
r = replace(r,'P413_SysClima_script.m','');


fig = fun_P413(idx,DateTimeInterval);

print(fig,fullfile(r,'P413_1.png'),'-dpng')
%%

DateTimeInterval = [datetime('01-Jan-2017') datetime('06-Jan-2017')];
idx = 6;


r = which('P413_SysClima_script');
r = replace(r,'P413_SysClima_script.m','');


fig = fun_P413(idx,DateTimeInterval);

print(fig,fullfile(r,'P413_2.png'),'-dpng')
%%

DateTimeInterval = [datetime('12-Feb-2017') datetime('22-Feb-2017')];
idx = 6;


r = which('P413_SysClima_script');
r = replace(r,'P413_SysClima_script.m','');


fig = fun_P413(idx,DateTimeInterval);

print(fig,fullfile(r,'P413_3.png'),'-dpng')