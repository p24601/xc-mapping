function [featureScoreVec,bestFitMatrixes] = produceComparePlot(sourceDevs,targetDev,sessionIDs,crosserIDs,targetDevId, subSourceDevs,subTargetDev,subMapDir)
if nargin < 8
    subMapDir = '';
    if nargin < 7
        subTargetDev = {''};
        if nargin < 6
            subSourceDevs = cell(length(sourceDevs),1);
            for ii = 1:length(subSourceDevs)
                subSourceDevs{ii} = {''};
            end
            if nargin < 5
                targetDevId = targetDev;
                if nargin < 4
                    crosserIDs = sourceDevs;
                    if nargin < 3
                        sessionIDs = {'FirstSession'};
                    end
                end
            end
        end
    end
end
crosserCell = buildCrosserCell(crosserIDs,sessionIDs,sourceDevs,subSourceDevs,targetDev,subTargetDev,1,subMapDir);
[featureScoreVec,bestFitMatrixes] = compareCrosserFeatures(crosserCell,crosserIDs,targetDevId,sessionIDs,true);

print(['plots/linearMF_',targetDevId,'.eps'],'-depsc') 

end