function [avgFits,stdFits,trainSizes,bioScores,bioTrainSizes,stdScores,sampleSizes] = getAvg_and_Stds4SizeAnalysis(optId,currSource,subDevSourceStr,targetDev,subDevTargetStr,sessionIDs)

%save([dataDir,filesep,optId,'_', currSource{:}, '_', strjoin(subDevSource), '_',...
%    targetDev,'_', strjoin(subDevTarget), '_Crosser.mat' ],'CrosserObj');

trainSizesVec = [1,3:3:27];

avgFits = cell(size(sessionIDs));
stdFits = cell(size(sessionIDs));
numOfSamples = cell(size(sessionIDs));


tailOfFileName = [currSource,'_',subDevSourceStr,'_',targetDev,'_',subDevTargetStr];

for jj = 1:length(sessionIDs)
    avgFits{jj} = cell(size(trainSizesVec));
    stdFits{jj} = cell(size(trainSizesVec));
    numOfSamples{jj} = zeros(size(trainSizesVec));
end

for ii = 1:length(trainSizesVec)
    for jj = 1:length(sessionIDs)
        mapsDir = ['maps',filesep,currSource,filesep,'setSize',int2str(trainSizesVec(ii)),filesep];
        currMapFile = [mapsDir,[sessionIDs{jj},optId],tailOfFileName,'_Crosser.mat'];
        try
            load(currMapFile);
            [avgFits{jj}{ii},stdFits{jj}{ii},~,numOfSamples{jj}(ii)] = CrosserObj.getMomentsFromCrosserObj();
            CrosserObj.printResults([sessionIDs{jj},optId,tailOfFileName],[targetDev,filesep,'setSize', int2str(trainSizesVec(ii))]);
        catch ME
            switch ME.identifier
                case 'MATLAB:load:couldNotReadFile'
                    warning(ME.message);
                otherwise
                    error(ME.message);
            end
        end
    end
end
trainSizes = cell(size(sessionIDs));
for jj = 1:length(sessionIDs)
    noEmptyIdxs = ~cellfun('isempty',avgFits{jj});
    avgFits{jj} = avgFits{jj}(noEmptyIdxs);
    stdFits{jj} = stdFits{jj}(noEmptyIdxs);
    numOfSamples{jj} = numOfSamples{jj}(noEmptyIdxs);
    trainSizes{jj} = trainSizesVec(noEmptyIdxs);

    try
        file4CompleteDataSet = ['maps',filesep,currSource,filesep,strrep([sessionIDs{jj},optId],'_linDeg1','Linear'),tailOfFileName,'_Crosser.mat'];
        load(file4CompleteDataSet);
    catch
        file4CompleteDataSet = ['maps',filesep,currSource,filesep,sessionIDs{jj},optId,tailOfFileName,'_Crosser.mat'];
        load(file4CompleteDataSet);
    end
    
    [currAvgFit,currStdFit,maxTrainSize,currNumOfSamples  ] = CrosserObj.getMomentsFromCrosserObj();
    
    if maxTrainSize >= max(trainSizes{jj})
        trainSizes{jj}(end+1) = maxTrainSize;
        avgFits{jj}{end+1} = currAvgFit;
        stdFits{jj}{end+1} = currStdFit;
        numOfSamples{jj}(end+1) = currNumOfSamples;
    end
    [trainSizes{jj},sortIdxs] = sort(trainSizes{jj});
    avgFits{jj} = avgFits{jj}(sortIdxs);
    stdFits{jj} = stdFits{jj}(sortIdxs);
    numOfSamples{jj} = numOfSamples{jj}(sortIdxs);
    
end

bioScorePerSession = cell(size(sessionIDs));
stdScorePerSession = cell(size(sessionIDs));
featW8 = cell(size(sessionIDs));
for jj = 1:length(sessionIDs)
    featW8{jj} = getFeatureWeights(CrosserObj.dataPath,CrosserObj.targetDev,sessionIDs{jj},CrosserObj.featureIDs,'rmi',CrosserObj.subDevTarget);
    bioScorePerSession{jj} = zeros(size(trainSizes{jj}));
    stdScorePerSession{jj} = zeros(size(trainSizes{jj}));
    for ii = 1:length(trainSizes{jj})
        bioScorePerSession{jj}(ii) = fitAndW82Score(avgFits{jj}{ii},featW8{jj});
        stdScorePerSession{jj}(ii) = stdAndW82Score(stdFits{jj}{ii},featW8{jj});
    end
end

bioScores = [];
stdScores = [];
bioTrainSizes = [];
numOfSessions4Size = [];
sampleSizes = [];
for jj = 1:length(sessionIDs)
    for ii = 1:length(trainSizes{jj}) 
        matchIdx = find(bioTrainSizes == trainSizes{jj}(ii));
        if isempty(matchIdx)
            bioTrainSizes = [bioTrainSizes , trainSizes{jj}(ii)];
            bioScores = [bioScores , bioScorePerSession{jj}(ii)];
            numOfSessions4Size = [numOfSessions4Size , 1];
            stdScores = [stdScores, stdScorePerSession{jj}(ii)^2];
            sampleSizes = [sampleSizes, numOfSamples{jj}(ii)];
        else
            %bioTrainSizes(matchIdx) = bioTrainSizes(matchIdx) + trainSizes{jj}(ii);
            bioScores(matchIdx) = bioScores(matchIdx) +  bioScorePerSession{jj}(ii);
            stdScores(matchIdx) = stdScores(matchIdx) + stdScorePerSession{jj}(ii)^2;
            numOfSessions4Size(matchIdx) = numOfSessions4Size(matchIdx) + 1;
            sampleSizes(matchIdx) = sampleSizes(matchIdx) + numOfSamples{jj}(ii);
        end
    end
end
bioScores = bioScores./numOfSessions4Size;
stdScores = sqrt(stdScores)./numOfSessions4Size;
[bioTrainSizes,idxs] = sort(bioTrainSizes);
bioScores = bioScores(idxs);
stdScores = stdScores(idxs);
sampleSizes = sampleSizes(idxs);
end