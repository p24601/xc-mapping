function [estOptValueMean, estOptValue] = estimateOptValueOfSubMap(this)
inDistr = this.inputDistributions;
estOptValue = zeros(length(this.userIDs),1);
for ii = 1:length(this.userIDs)
    inDistr.(this.userIDs{ii}) =  inDistr.(this.userIDs{ii}).evalAverageOptDistance();
    estOptValue(ii) = estOptValue(ii) + inDistr.(this.userIDs{ii}).optAvgDist;
    
end

estOptValueMean = mean(estOptValue);


end