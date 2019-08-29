function F_transf = transformLinearECDF(F,x,a,b)

F_transf = cell(size(F));
for ii = 1:length(F)
    F_transf{ii} = evalECDF(x{ii},F{ii}, (x{ii} - b)/a);
    if a < 0
        F_transf{ii} = 1-F_transf{ii};
    end
end



end