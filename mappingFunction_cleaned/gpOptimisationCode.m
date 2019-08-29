function bestGp = gpOptimisationCode(struct4GpOpt)
    gp=rungp(@gpDistrConfig,struct4GpOpt);
    bestGp = gp.results.best;
end
