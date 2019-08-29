function [A,b,LBs,UBs] = genLinConstrMatrix( nvars, subMap, is_monotonic)
%genLinConstrMatrix generates the linear constraints used in the
%optimization.
%Inputs:
%         -nvars, i.e. number of optimization variables
%         -regrForm, i.e. form of the regression to be considered, this is
%         just linear for now...
%         -mapping, Mapping object
%Outputs:
%         -A, constant matrix of constrains,
%         -b, vector for constrains,
%Usage:
%          [A,b] = genLinConstrMatrix( nvars , regrForm, feat )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Let x be the decision variable of the optimization, than the constraints%
%computed by the code is of the form: Ax <= b                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%merge features obtain common safe bounds
merged = subMap.mergeMapDistributions('source','target');


srcDistr = merged.inputDistributions.source;
trgDistr = merged.outputDistributions.target;



%[UBs,LBs] = evalUb_Lb(trgDistr.samples);
[UBs,LBs] = evalUb_Lb();
outDim = length(UBs);
if is_monotonic
    
    data = srcDistr.samples;
    minInputs = min(data);
    maxInputs = max(data);
    inDim = length(minInputs);
    cellOfCorners = reshape4getCartesianFun(minInputs,maxInputs);
    cornerVecs = getCartesianProduct(cellOfCorners);
    cornerVecs = [ones(size(cornerVecs,1),1) , cornerVecs];
    A = [];
    b = [];
    for ii = 1:length(UBs)
        currUB = UBs(ii);
        currLB = LBs(ii);
        currUnitTempl = double((1:outDim) == ii);
        currALineTempl = repmat(currUnitTempl,1,inDim + 1);
        for jj = 1:size(cornerVecs,1)
            currALine = currALineTempl;
            currALine(currALineTempl~=0) = cornerVecs(jj,:);
            A = [A ; -currALine ; currALine  ];
            b = [b ; -currLB ; currUB ];
        end
    end

else
    data = srcDistr.samples;
    data = dropOut(data);
    A = zeros(length(data),nvars);
    polyPower = (0:(nvars-1));
    lenPoly = length(polyPower);
    for ii = 1:length(data)
        for jj = 1:lenPoly
            A(ii,jj) = ( data(ii) )^(polyPower(jj));
        end
    end
    A = [-A ;  A ];
    b = [-LBs'*ones(length(data),1) ; UBs'*ones(length(data),1) ];

  
end



end




function data = dropOut(data)
data = sort(data);
[~, idxs ] = unique(round(data,1,'significant'));
data = data(idxs);
end
