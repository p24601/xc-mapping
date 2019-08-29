function crosserCell = buildCrosserCell(crosserIDs,sessionIDs,sourceDevs,subSourceDevs,targetDev,subTargetDev,deg,subMapDir)
if nargin < 8
    subMapDir = '';
    if nargin < 7
        deg = 1;
    end
end
crosserCell = cell(length(crosserIDs),length(sessionIDs));
for ii = 1:length(sourceDevs)
    for jj = 1:length(sessionIDs)
        %if deg == 1
        %    degStr = 'Linear';
        %else
            degStr = ['_linDeg',int2str(deg)];
        %end
        
        fileName = [sessionIDs{jj},degStr,'SV_',sourceDevs{ii},...
            '_',strjoin(subSourceDevs{ii}),'_',targetDev,'_',strjoin(subTargetDev)];
        dirMaps = ['maps',filesep,sourceDevs{ii},filesep];
        if ~isempty(subMapDir)
            dirMaps = [dirMaps,subMapDir,filesep];
        end
        try
            load([dirMaps, fileName,'_Crosser.mat']);
        catch
            load([dirMaps, strrep(fileName,'Linear','_linDeg1'),'_Crosser.mat']);
        end
        if ~isempty(subMapDir)
            dir4CsvFile = [targetDev, filesep, subMapDir];
        else
            dir4CsvFile = targetDev;
        end
        CrosserObj.printResults(fileName,dir4CsvFile);
        crosserCell{ii,jj} = CrosserObj;
    end
end


end