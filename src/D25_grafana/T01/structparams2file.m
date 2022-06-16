for imap = xrsim_params.parameters(1).map
    iter = iter + 1;
    nnn = strsplit(imap.Identifier,'__');
    if length(nnn)>1
        name = (nnn{1}+".('"+nnn{2}+"')");
    else
        name = (nnn{1}+"");
    end
    
    eval("xrsim_params.parameters(1).values(imap.ValueIndices(1):imap.ValueIndices(2)) = "+name+";")
end

save('params_rsim','xrsim_params')