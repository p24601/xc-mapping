function [ x_star_partial,fstar_par ] = gaOptimisationCode(LbsOnOptVars,UbsOnOptVars,nvars,numOfThreads,verbose,fitHandle,A,b)
opts = getOptimisationOptsGA(LbsOnOptVars,UbsOnOptVars,nvars,numOfThreads,verbose);
[x_star_partial,fstar_par,~,~,~,~] = ga(fitHandle,nvars,A,b,[],[],LbsOnOptVars,UbsOnOptVars,[],opts);
end

