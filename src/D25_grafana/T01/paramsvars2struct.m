
%% Leemos los parámetros disponibles en el modelo  y lo convertimos a structura
iter = 0;
for imap = xrsim_params.parameters(1).map
    iter = iter + 1;
    imap.Identifier;
    nnn = strsplit(imap.Identifier,'__');
    if length(nnn)>1
        eval(nnn{1}+".('"+nnn{2}+"') = xrsim_params.parameters(1).values(imap.ValueIndices(1):imap.ValueIndices(2));")
    else
        eval(nnn{1}+" =  xrsim_params.parameters(1).values(imap.ValueIndices(1):imap.ValueIndices(2));")
    end
end