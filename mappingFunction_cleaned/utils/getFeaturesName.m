function featNames = getFeaturesName(sourceDevId,subSourceDev,baseDir,userIDs,targetDevId,subTargetDev)

featNames = {};
for ii = 1:length(userIDs)
    currId = userIDs{ii};
    sourceFile = getSourceFileCell(baseDir,currId,sourceDevId,subSourceDev);
    targetFile = getSourceFileCell(baseDir,currId,targetDevId,subTargetDev);
    featNames = innerCheckingLoop(featNames,sourceFile);
    featNames = innerCheckingLoop(featNames,targetFile); 
end

featNames(strcmp('count',featNames)) = [];


featNames(strcmp('',featNames)) = [];

    
end

function featNames = innerCheckingLoop(featNames,sourceFile)
    for jj = 1:length(sourceFile)
        try
            fid = fopen(sourceFile{jj});
            assert(fid~=-1)
            featIds = fgets(fid);
            fclose(fid);
            
            while ~(isletter(featIds(end)) || isnumber(featIds(end)))
                featIds = featIds(1:end-1);
            end
            featIds = strrep(featIds,'-','_');
            featIds = strsplit(featIds,',');
            for kk = 1:length(featIds)
                if ~isempty(featIds{kk})
                    if(isnumber(featIds{kk}(1)))
                        featIds{kk} = ['f_',featIds{kk} ];
                    end
                end
            end
            if ~isempty(featNames) && ~isequal(featIds,featNames)
                error('Features ids are not the same for all the users');
            else
                featNames = featIds;
            end
            
            
        catch ME
            switch ME.identifier
                case 'MATLAB:assertion:failed'
                    true;
                otherwise
                    error(ME.message)
            end
        end
    end

end


