function sourceDistributions = normalise(sourceDistributions,lbStruct,ubStruct)


featNames = fieldnames(sourceDistributions);

for ii = 1:length(featNames)
    currFeatDistrs = sourceDistributions.(featNames{ii});
    currLb = lbStruct.(featNames{ii});
    currUb = ubStruct.(featNames{ii});
    userIds = fieldnames(currFeatDistrs);
    for jj = 1:length(userIds)
        currDistr = currFeatDistrs.(userIds{jj});
        currDistr = currDistr.normaliseDistr(currLb,currUb);
        sourceDistributions.(featNames{ii}).(userIds{jj}) = currDistr;
    end
    
end







end