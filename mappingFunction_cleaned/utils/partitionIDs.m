function estimationSourceIdsCell = partitionIDs(estimationSourceIds,maxLen,numOfRep)

combs = combnk(estimationSourceIds,maxLen);

numOfComb = size(combs,1);

if maxLen >= numOfRep
    estimationSourceIdsCell = combs;
    for ii = 1:numOfComb
        estimationSourceIdsCell{ii} = combs(ii,:);
    end
else
    combs = combs(randperm(numOfComb),:);
    for ii = 1:numOfRep
        estimationSourceIdsCell{ii} = combs(ii,:);
    end
end


end
