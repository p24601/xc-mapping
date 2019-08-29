function cellOfCorners = reshape4getCartesianFun(minInputs,maxInputs)
cellOfCorners = cell(length(minInputs), 1);

for ii = 1:length(minInputs)
    cellOfCorners{ii} = [minInputs(ii), maxInputs(ii)];
end


end