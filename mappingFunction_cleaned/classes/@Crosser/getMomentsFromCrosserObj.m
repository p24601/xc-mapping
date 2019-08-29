function   [avgFits,stdFits,maxTrainSize,numOfSamples] = getMomentsFromCrosserObj(this)

numOfRep = size(this.fitOnValidation,2);
numOfUsers = size(this.fitOnValidation,1);
numOfFeatures = length(this.featureIDs);
fit4FeatVec = zeros(numOfFeatures,numOfRep*numOfUsers);
for jj = 1:size(fit4FeatVec,1)
    kk = 1;
    for ll = 1:numOfUsers
        for mm = 1:numOfRep
            fit4FeatVec(jj,kk) = sqrt(this.fitOnValidation{ll,mm}(jj));
            kk = kk +1;
        end
    end
end
avgFits = mean(fit4FeatVec,2);
stdFits = std(fit4FeatVec,0,2);
numOfSamples = size(fit4FeatVec,2);
maxTrainSize = numOfUsers - 1;
end