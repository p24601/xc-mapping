function csvOfMomentsOfTrainSizeAnalysis(bioScores,bioTrainSizes,stdScores,sampleSizes,corsserIDs,targetDev,sessionID)

saveDir = ['results',filesep,targetDev,filesep,'trainSetSizeAnalysis', filesep];
createDirIfDoesntExist(saveDir)
leftLineCell = {'mean','std','sample_size'};
for ii = 1:length(corsserIDs)
    fileName = [saveDir,sessionID,'_',corsserIDs{ii},'.csv'];
    topLineCell = cell(size(bioTrainSizes{ii}));
    for jj = 1:length(topLineCell) 
        topLineCell{jj} = int2str(bioTrainSizes{ii}(jj));
    end
    fid = fopen(fileName,'w');
    matIn = [bioScores{ii};stdScores{ii};sampleSizes{ii}];
    resultsStr = fromMatData2CSVlike(matIn,topLineCell,leftLineCell,'trainSetSize');
    fprintf(fid, '%s', resultsStr);
    fclose(fid);
    
end








end
