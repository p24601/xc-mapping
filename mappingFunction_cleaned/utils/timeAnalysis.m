function fitAuxCell = timeAnalysis(crosserObjMap,crosserObjData,idsMap, idsData,diffTimesIn,idStr)

userIDs = crosserObjData.ids;
fitAuxCell = cell(size(userIDs));
diffTimes = zeros(size(userIDs));
for ii = 1:length(userIDs)
    currUserData = userIDs{ii};
    matchIdx = strcmp(currUserData,idsData);
    %try
        diffTimes(ii) =  diffTimesIn(matchIdx);
    %catch
    %    disp('...')
    %end
    currUserMap = idsMap{matchIdx};
    try
        currMapWrapper = crosserObjMap.mapWrapperStruct.(fromID2fieldName(currUserMap));
        if iscell(currMapWrapper)
            currMapWrapper = currMapWrapper{1};
        end
        %I make sure that the implementation of the mapping function is
        %up to date
        currMapWrapper = updateMapSpecs(currMapWrapper);
        %if isempty(this.regrMtd)
        %    this.regrMtd = 'lin';
        %end
        
        fitAuxCell{ii} = currMapWrapper.evalFeatureSecurityScore(currUserData,crosserObjData.dataPath,crosserObjData.sourceDev,...
            crosserObjData.targetDev,crosserObjMap.lbFeats,crosserObjMap.ubFeats,crosserObjData.subDevSource,...
            crosserObjData.subDevTarget,crosserObjMap.dataPath,currUserMap);
    catch ME
        disp(ME.message)
    end
end

fitMat = [];
fittedIDs = {};
for ii = 1:length(userIDs)
    if ~isempty(fitAuxCell{ii} )
        fittedIDs{end+1} = userIDs{ii};
        fitMat = [fitMat;diffTimes(ii),fitAuxCell{ii}'];
    end
end

featureIDs = crosserObjMap.featureIDs;
featureIDs = {'timeDiff',featureIDs{:}};
subDir = ['results/',crosserObjMap.targetDev, filesep ,'timeAnalysis', filesep];
createDirIfDoesntExist(subDir);
filename = [subDir,idStr, crosserObjMap.sourceDev , '_', strjoin(crosserObjMap.subDevSource), '_', ...
    crosserObjMap.targetDev , '_',strjoin(crosserObjMap.subDevTarget), '.csv' ];
resultsStr = fromMatData2CSVlike(fitMat,featureIDs,fittedIDs);
fid = fopen(filename,'w');
fprintf(fid, '%s', resultsStr);
fclose(fid);



end


function mapWrapper = updateMapSpecs(mapWrapper)

for ii = 1:length(mapWrapper.subMapNames)
    optParams = mapWrapper.subMaps.(mapWrapper.subMapNames{ii}).mapSpec.params;
    mapWrapper.subMaps.(mapWrapper.subMapNames{ii}).regrMtd = 'lin';
    mapWrapper.subMaps.(mapWrapper.subMapNames{ii}).mapSpec = polynomial_map_spec( 1 ,1, 1 );
    mapWrapper.subMaps.(mapWrapper.subMapNames{ii}).mapSpec.params = optParams;
end
end