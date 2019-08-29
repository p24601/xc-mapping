function this = plottingCrossValResults(this)

featNames = this.featureIDs;

bestFitMatrix = zeros(length(this.ids),length(featNames));
initFitMatrix = zeros(length(this.ids),length(featNames));
this = this.CrossEstimateOptValue();
this = this.compInitFitMatrix();

for ii = 1:length(this.ids)
    bestFitMatrix(ii,:) =  this.fitOnValidation{ii};
    initFitMatrix(ii,:) = this.initFit{ii};
end
optMatrix = this.estOptValue;


this.secScoreMatrix = optMatrix./bestFitMatrix;

bestFitVector = zeros(length(this.ids),1);
initFitVector = zeros(length(this.ids),1);
optVector = zeros(length(this.ids),1);
for jj = 1:length(this.ids)
    bestFitVector(jj) = mean(bestFitMatrix(jj, :));
    initFitVector(jj) = mean(initFitMatrix(jj, :));
    optVector(jj) = mean(optMatrix(jj, :));
end

figure
hold on
grid on

aboxplot({initFitMatrix,bestFitMatrix,optMatrix},'OutlierMarker','x','OutlierMarkerSize',2);

xlabel('Features')
ylabel('Distance')
set(gca,'YLim', [0 , 1], 'XTickLabel',featNames,'XTickLabelRotation' ,  90)
legend({'Initial','Linear Function','Estimated Opt'})
hold off

%figure
%hold on
%grid on


%aboxplot({this.secScoreMatrix},'OutlierMarker','x','OutlierMarkerSize',2);

%xlabel('Features')
%ylabel('Normalised Score')
%set(gca, 'XTickLabel',featNames,'XTickLabelRotation' ,  90)
%legend({'Linear Function'})
%hold off

%figure
%hold on
%grid on
%aboxplot({initFitVector,bestFitVector,optVector},'OutlierMarker','x','OutlierMarkerSize',2);
%set(gca,'YLim', [0 , 1])
%xlabel('Input devices')
%legend({'Initial','Linear Function','Estimated Opt'})
%ylabel('Normalised distance')

end

