function plotComparisonHistogram(targetDev,sourceDevs,subDevSources,subDevTarget,degs,sessionIDs,crosserIDs,targetDevID)

featureScoreVecs = cell(size(degs));
for ii = 1:length(degs)
    crosserCell = buildCrosserCell(crosserIDs,sessionIDs,sourceDevs,subDevSources,targetDev,subDevTarget,degs(ii));
    featureScoreVecs{ii} = compareCrosserFeatures(crosserCell,crosserIDs,targetDev,sessionIDs,true, false);
end

biometricScores = zeros(length(degs),length(crosserIDs));
for ii = 1:length(degs)
    for jj = 1:length(crosserIDs)
        biometricScores(ii,jj) = fromW8FeatScore2BioScore(featureScoreVecs{ii}(jj,:));
    end
end
figure
hold on
bar(biometricScores');
ylim([0,.5]);
set(gca,'XTick',1:length(crosserIDs),'XTickLabel',crosserIDs);
xlabel('Input Device')
title(targetDevID);
ylabel('Biometric Score')
legEntries = cell(length(degs),1);
for ii = 1:length(degs)
    legEntries{ii} = ['Degree: ', int2str(degs(ii))];
end
legend(legEntries)
hold off
end
