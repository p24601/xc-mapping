function [lbFeats,ubFeats] = evalLB_and_UB_for_Crosser(featNames,baseDir,sourceDevId,subSourceDev,targetDevId,subTargetDev,userIDs)



[lbFeats.source,ubFeats.source] = innerLoopOfFun(featNames,userIDs, baseDir,sourceDevId,subSourceDev);
[lbFeats.target,ubFeats.target] = innerLoopOfFun(featNames,userIDs, baseDir,targetDevId,subTargetDev);



end

function [lbStr,ubStr] = innerLoopOfFun(featNames,userIDs, baseDir,sourceDevId,subSourceDev)
empDistributionsSource = loadFeatureDistribution(baseDir,userIDs,sourceDevId,subSourceDev);

for ii = 1:length(featNames)
    currFeatStructs = empDistributionsSource.(featNames{ii});
    lb = inf;
    ub =  -inf;
    for jj = 1:length(userIDs)
        currLb = min(currFeatStructs.(fromID2fieldName(userIDs{jj})).samples);
        currUb = max(currFeatStructs.(fromID2fieldName(userIDs{jj})).samples);
        if currLb < lb
            lb = currLb;
        end
        if currUb > ub
            ub = currUb;
        end
    end
    if lb == ub
        lb = lb - lb/10;
        ub = ub + ub/10;
    end
    lbStr.(featNames{ii}) = lb;
    ubStr.(featNames{ii}) = ub;
end
end