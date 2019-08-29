function [ x_star_partial,fstar_par,bestGp ] = runOptimization(opt_alg,LbsOnOptVars,UbsOnOptVars,nvars,numOfThreads,verbose,A,b,fitHandle,idntt,struct4GpOpt,is_poly,modelMatName,currID,featID)
%Wrapper around the optimisation algorithm
switch opt_alg
    case 'ga'
        [ x_star_partial,fstar_par ] = gaOptimisationCode(LbsOnOptVars,UbsOnOptVars,nvars,numOfThreads,verbose,fitHandle,A,b);
        bestGp = [];
    case 'ps'
        [ x_star_partial,fstar_par ] = psOptimisationCode(verbose,numOfThreads,A,b,LbsOnOptVars,UbsOnOptVars,nvars,idntt,fitHandle,is_poly,modelMatName,currID,featID);
        bestGp = [];
    case 'gp'
        bestGp = gpOptimisationCode(struct4GpOpt);
        x_star_partial = [];
        fstar_par = [];
    otherwise
        error('Optimization algorithm requested not implemented');
        %[x_star_partial,fstar_par] = patternsearch(fitHandle,idntt,A,b,[],[],Lbs,Ubs,[],opts);
end