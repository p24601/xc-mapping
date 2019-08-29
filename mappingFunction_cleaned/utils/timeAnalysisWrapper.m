function timeAnalysisWrapper(devCouples,subDevCouples,mapSession,dataSession,idStr)

[idsFirst, idsSecond,dateDiff] = getIDs();
idsFirst = strsplit(int2str(idsFirst'));
idsSecond = strsplit(int2str(idsSecond'));

if strcmp(mapSession,'FirstSession')
    idsMap = idsFirst;
    idsData = idsSecond;
else
    idsData = idsFirst;
    idsMap = idsSecond;
end

for ii = 1:size(devCouples,1)
    currSource = devCouples(ii,1);
    targetDev = devCouples{ii,2};
    for jj = 1:size(subDevCouples,1)
        subDevSource =  subDevCouples{jj,1};
        subDevTarget =  subDevCouples{jj,2};
        
        matFile = fromInputs2FileName(currSource,subDevSource,targetDev,subDevTarget,mapSession,1);
        try
            load(matFile);
        catch
            load(strrep(matFile,'Linear','_linDeg1'));
        end
        crosserObjMap = CrosserObj;
        clear CrosserObj
        matFile = fromInputs2FileName(currSource,subDevSource,targetDev,subDevTarget,dataSession,1);
        try
            load(matFile);
        catch
            load(strrep(matFile,'Linear','_linDeg1'));
        end
        crosserObjData = CrosserObj;
        clear CrosserObj
        fitAuxCell = timeAnalysis(crosserObjMap,crosserObjData,idsMap,idsData,dateDiff,idStr);
        
    end
end

end