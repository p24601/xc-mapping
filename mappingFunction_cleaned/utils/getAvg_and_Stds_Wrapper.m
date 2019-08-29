function [avgFits,stdFits,sizes,bioScores,bioTrainSizes,stdScores,sampleSizes] = getAvg_and_Stds_Wrapper(devCouples,subDevCouples,deg,sessionIDs)

avgFits = {};
stdFits = {};
sizes = {};
bioScores = {};
bioTrainSizes = {};
stdScores = {};
sampleSizes = {};
for ii = 1:size(devCouples,1)
    currSource = devCouples(ii,1);
    targetDev = devCouples{ii,2};
    for jj = 1:size(subDevCouples,1)
        subDevSource =  subDevCouples{jj,1};
        subDevTarget =  subDevCouples{jj,2};
        optId = ['_linDeg',int2str(deg),'SV_'];
        [avgFits{end + 1},stdFits{end + 1},sizes{end + 1},bioScores{end+1},bioTrainSizes{end+1},stdScores{end+1},sampleSizes{end+1}] =...
            getAvg_and_Stds4SizeAnalysis(optId,currSource{:},strjoin(subDevSource),targetDev,...
             strjoin(subDevTarget),sessionIDs);
    end
end










end

