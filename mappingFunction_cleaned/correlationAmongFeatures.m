clear all
close all
clc
addpath('classes/');
addpath(genpath('utils/'));


ids = {'0432','0722','1256','1391','1597','1743','1887','1902','2490','2812','3809','4474','4798','4981','5736','6549','7731','7764','8372','8743','8787','9234'};
%ids = {'1256'};

cellOfObservations = {};
%oneStepCorrelation = [];
for iiD = 1:length(ids)
    currId = ids{iiD};
    curr_features = load(['cachedFeatures/features_',currId,'_nymi.mat']);
    currEcgFeat = curr_features.curr_features.ecgFeat;
    featNames = fieldnames(currEcgFeat);
    
    if isempty(cellOfObservations)
        cellOfObservations = cell(length(featNames),1);
    end
    
    for ii = 1:length(featNames)
        cellOfObservations{ii} = [cellOfObservations{ii} ; currEcgFeat.(featNames{ii})];
        %corrcoef = ()
        %oneStepCorrelation(ii) 
    end
end

oneStepCorrelation = zeros(length(featNames),1);


featCorrMatrix = nan(length(featNames));
for ii = 1:length(featNames)
    for jj = (ii+1):length(featNames)
        aux = corrcoef(cellOfObservations{ii}(:),cellOfObservations{jj}(:));
        featCorrMatrix(ii,jj) = abs(aux(1,2));
    end
    aux2 = corrcoef(cellOfObservations{ii}(2:end),cellOfObservations{ii}(1:(end-1)) );
    oneStepCorrelation(ii) = abs(aux2(1,2)); % this is an underestimate
end

figure
xLab = 'Features';
yLab = 'Features';
zLab = '|\rho|';
plot3dBarPlot(featCorrMatrix,xLab,yLab,zLab,featNames,featNames)
title('Correlation among features')
thereshold = 0.4;
[I,J] = find(featCorrMatrix>thereshold);

corrCouples = {featNames{I};featNames{J}};

disp(['Variables with linear correlation higher than: ', num2str(thereshold), ' are:'])
disp(corrCouples)

figure
bar(oneStepCorrelation);
grid on
xlabel('Features')
ylabel('One step correlation');
set(gca,'XTickLabel',featNames,'YLim', [0 1])