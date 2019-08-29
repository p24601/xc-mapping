function mapEvaluationPlots( this )
%mapEvaluationPlots Produces some plots about the mapping object this
%initialFitness = zeros(  ,length(this.subMapNames)   );

if ~isempty(this.featuresCoding)
    featNames = this.featuresCoding(:,1);
else
    featNames = this.subMapNames;
end
userIDs = fieldnames(this.subMaps.(featNames{1}).transformedDistributions);
bestFitMatrix = zeros(length(userIDs),length(featNames));
initFitMatrix = zeros(length(userIDs),length(featNames));
this = estimateOptValue(this);
optMatrix = this.estOptValue;
bestFitVector = zeros(length(userIDs),1);
initFitVector = zeros(length(userIDs),1);
optVector = zeros(length(userIDs),1);
for ii = 1:length(this.subMapNames)
    currSubMapID = this.subMapNames{ii};
    currSubMap = this.subMaps.(currSubMapID);
    currInitDistrs = currSubMap.inputDistributions;
    currTransfDistrs = currSubMap.transformedDistributions;
    currTargetDistrs = currSubMap.outputDistributions;
    for jj = 1:length(userIDs)
        currJoinInit = currInitDistrs.(userIDs{jj});
        currJoinTransf = currTransfDistrs.(userIDs{jj});
        currJoinTarget = currTargetDistrs.(userIDs{jj});
        for kk = 1:length(currJoinTransf.subDistrIDs)
            currFeatID = currJoinTransf.subDistrIDs{kk};
            currMarginalInit = currJoinInit.extractEmpDistributions(currFeatID);
            currMarginalTranf = currJoinTransf.extractEmpDistributions(currFeatID);
            currMarginalTarget = currJoinTarget.extractEmpDistributions(currFeatID);
            %disp('Best')
            %disp(currFeatID)
            bestFitMatrix(jj, strcmp(currFeatID,featNames)) =  currMarginalTarget.computeDistanceFrom(currMarginalTranf,'l2',currSubMap.xs_output(kk), currSubMap.c_xs_output(kk));
            %disp('Init')
            %disp(currFeatID)
            initFitMatrix(jj, strcmp(currFeatID,featNames)) =  currMarginalTarget.computeDistanceFrom(currMarginalInit,'l2',currSubMap.xs_output(kk), currSubMap.c_xs_output(kk));

        end
    end
    
    
end


for jj = 1:length(userIDs)
    bestFitVector(jj) = mean(bestFitMatrix(jj, :));
    initFitVector(jj) = mean(initFitMatrix(jj, :));
    optVector(jj) = mean(optMatrix(jj, :));
end

figure
hold on
grid on
aboxplot({initFitMatrix,bestFitMatrix,optMatrix},'OutlierMarker','x','OutlierMarkerSize',2);
xlabel('Features')
ylabel('Normalised distance')
set(gca,'YLim', [0 , 1], 'XTickLabel',featNames,'XTickLabelRotation' ,  90)
legend({'Initial','Linear Function','Estimated Opt'})
hold off

figure
hold on
grid on
aboxplot({initFitVector,bestFitVector,optVector},'OutlierMarker','x','OutlierMarkerSize',2);
set(gca,'YLim', [0 , 1])
xlabel('Input devices')
legend({'Initial','Linear Function','Estimated Opt'})
ylabel('Normalised distance')

end

