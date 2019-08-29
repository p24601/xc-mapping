function [featureScoreVec,bestFitMatrixes] = compareCrosserFeatures( crosserCell , crosserIDs, targetDev,sessionIDs,computeFeatScore, plotting )

if nargin < 6
    plotting = true;
    if nargin < 5
        computeFeatScore = false;
    end
end

featureIDs = crosserCell{1,1}.featureIDs;

for ii = 1:size(crosserCell,1)
    for jj = 1:size(crosserCell,2)
        assert(isequal(featureIDs,crosserCell{ii,jj}.featureIDs));
    end
end



bestFitMatrixes = cell(size(crosserCell,1),1);
featureScoreVec = zeros(size(crosserCell,1),1);
for jj = 1:length(bestFitMatrixes)
    bestFitMatrixes{jj} = [];
    if computeFeatScore
        currWeightedMatrix = [];
    end
    for kk = 1:size(crosserCell,2)
        currMatrix = zeros(length(crosserCell{jj,kk}.ids),length(featureIDs));
        for ii = 1:length(crosserCell{jj,kk}.ids)
            currMatrix(ii,:) =  sqrt(crosserCell{jj,kk}.fitOnValidation{ii});
        end
        if computeFeatScore
            featW8 = getFeatureWeights(crosserCell{jj,kk}.dataPath,crosserCell{jj,kk}.targetDev,sessionIDs{kk},crosserCell{jj,kk}.featureIDs,'rmi',crosserCell{jj,kk}.subDevTarget);
            currWeightedMatrix = [currWeightedMatrix ; (currMatrix.*featW8)/sum(featW8)];
        end
        bestFitMatrixes{jj} = [bestFitMatrixes{jj};currMatrix];
        
    end
    if computeFeatScore
        featureScoreVec(jj) = dot(mean(bestFitMatrixes{jj}),featW8)/sum(featW8);
    end
end

if ~computeFeatScore
    featureScoreVec = [];
end


if plotting
    figure
    hold on
    grid on

    aboxplot(bestFitMatrixes,'OutlierMarker','x','OutlierMarkerSize',2);
    title(['Target device: ', targetDev]);
    xlabel('Features')
    ylabel('Feature Score')
    set(gca,'YLim', [0 , 0.5], 'XTickLabel',strrep(featureIDs,'_','\_'),'XTickLabelRotation' ,  90)
    legend(crosserIDs)
    hold off
end
end
