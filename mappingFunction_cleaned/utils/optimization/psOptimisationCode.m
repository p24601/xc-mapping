function [ x_star_partial,fstar_par ] = psOptimisationCode(verbose,numOfThreads,A,b,LbsOnOptVars,UbsOnOptVars,nvars,idntt,fitHandle,is_poly,modelMatName,currID,featID)

opts = getOptimisationOptsPS(verbose,numOfThreads);

cachingOfMaps = false;
if is_poly
    currBestSol = idntt(1:(nvars-1));
    currBestSol = currBestSol(:);
    for ii = (nvars-1):nvars
        %check in the result folder, if there exists a model for this ii:
        possibleFileNames = getPossibleNames(modelMatName,ii-1,nvars);
        boolValue =  false;
        okIdx = 0;
        for jj = 1:length(possibleFileNames)
            boolValue = boolValue || (exist(possibleFileNames{jj},'file') == 2);
            if boolValue
                okIdx = jj;
                break;
            end
        end
        if cachingOfMaps && boolValue && ii < nvars
            load(possibleFileNames{okIdx});
            mapWrapperObj = CrosserObj.mapWrapperStruct.(fromID2fieldName(currID));
            clear CrosserObj
            if iscell(mapWrapperObj)
                mapWrapperObj = mapWrapperObj{1};
            end
            x_star_partial = mapWrapperObj.subMaps.(featID).optResults.x_star;
            fstar_par = mapWrapperObj.subMaps.(featID).optResults.y_star;
            kk = 0;
            clear mapWrapperObj
        else
            initPoints = [currBestSol' ; unifrnd(LbsOnOptVars(1),UbsOnOptVars(1),1,ii)];
            fitHandlePartial = @(x)(fitHandle([x;zeros(nvars-ii,1)]));
            APar = A(:,1:ii);
            bPar = b;
            LbsOnOptVarsPar = LbsOnOptVars(1:ii);
            UbsOnOptVarsPar = UbsOnOptVars(1:ii);
            [fstar_par,x_star_partial,~] =  optimisationWrapper(initPoints,fitHandlePartial,APar,bPar,LbsOnOptVarsPar,UbsOnOptVarsPar,opts,numOfThreads);
                
        end
        currBestSol = x_star_partial; 
        if ii < nvars
                currBestSol = [currBestSol;0];
        end
    end
else
    initPoints = [idntt ; unifrnd(LbsOnOptVars(1),UbsOnOptVars(1),1,nvars)];
    [fstar_par,x_star_partial,~] =  optimisationWrapper(initPoints,fitHandle,A,b,LbsOnOptVars,UbsOnOptVars,opts,numOfThreads);
end


end


function [fstar_par,x_star_partial,kk] =  optimisationWrapper(initPoints,fitHandle,A,b,LbsOnOptVars,UbsOnOptVars,opts,numOfThreads)
numRow = size(initPoints,1);
fstar_par = inf;
x_star_partial = [];

kk = 1;
for jj = 1:numRow
    [fstar_par,x_star_partial,kk] = optimisationLoop(fitHandle,initPoints(jj,:)',A,b, ...
        LbsOnOptVars,UbsOnOptVars,opts,fstar_par,x_star_partial,kk,jj);
end
if(fstar_par == inf)
    error('None of the optimization was completed...');
end
end

function [fstar_par,x_star_partial,kk] = optimisationLoop(fitHandle,initPoints,A,b,LbsOnOptVars,UbsOnOptVars,opts,fstar_par,x_star_partial,kk,jj)

try
    [curr_x_star_partial,curr_fstar_par] = patternsearch(fitHandle,initPoints,A,b,[],[],LbsOnOptVars,UbsOnOptVars,[],opts);
    if curr_fstar_par < fstar_par
        fstar_par = curr_fstar_par;
        x_star_partial = curr_x_star_partial;
        kk = jj;
    end
catch ME
    warning(ME.message)
end

end

function possibleFileNames = getPossibleNames(modelMatName,deg,nvars)
possibleFileNames{1} = strrep(modelMatName,int2str(nvars-1),int2str(deg));
possibleFileNames{2} = strrep(possibleFileNames{1},'_lin','');
if deg ==1
    possibleFileNames{3} = strrep(possibleFileNames{2},['Deg',int2str(deg)],'Linear');
end


end