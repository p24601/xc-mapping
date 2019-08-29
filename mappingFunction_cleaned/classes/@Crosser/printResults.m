function resultsMat = printResults(this,fileNameIn,subResultsDir)

numOfRep = size(this.fitOnValidation,2);
if exist(['results',filesep,subResultsDir],'dir') ~=7
    mkdir(['results',filesep,subResultsDir])
end
featNames = this.featureIDs;
userIDs = this.ids;

for ii = 1:numOfRep
    
    resultsDir =['results',filesep,subResultsDir,filesep];
    
    
    if numOfRep == 1
        fileName = [resultsDir, fileNameIn,'.csv'];
    else
        fileName = [resultsDir, fileNameIn,'_',int2str(ii),'.csv'];
    end
    resultsMat = zeros(length(userIDs),length(featNames));
    
    for jj = 1:length(userIDs)
        resultsMat(jj,:) = this.fitOnValidation{jj,ii};
    end
    
    resultsStr = fromMatData2CSVlike(resultsMat,featNames,userIDs);
    
    fid = fopen(fileName,'w');
    fprintf(fid, '%s', resultsStr);
    fclose(fid);
end


end