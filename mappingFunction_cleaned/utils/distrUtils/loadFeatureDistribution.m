function empDistributions = loadFeatureDistribution(baseDir,estimationSourceIds,sourceDevId,subSourceDev)
%loads from csv file the features detected and arrange them in a struct of
%distribution object
if nargin < 4
    subSourceDev = {};
end
oldFeatIds = {};
for ii = 1:length(estimationSourceIds)
    currId = estimationSourceIds{ii};
    sourceFile = getSourceFileCell(baseDir,currId,sourceDevId,subSourceDev);
    C = cell(length(sourceFile),1);
    for jj = 1:length(sourceFile)
        %try
        fid = fopen(sourceFile{jj});
        featIds = fgets(fid);
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
        %catch
        %    disp('');
        %end
        if ~isempty(oldFeatIds) && ~isequal(featIds,oldFeatIds)
            error('Features ids are not the same for all the users');
        end
        C{jj} = textscan(fid,repmat('%f',1,length(featIds)),'Headerlines',0,'Delimiter',',' );
        fclose(fid);
        oldFeatIds = featIds;
    end
    
    for jj = 1:length(featIds)
        auxVec = [];
        for kk = 1:length(sourceFile)
            auxVec = [auxVec ; C{kk}{jj}];
        end
        if ~isempty(featIds{jj})
            empDistributions.(featIds{jj}).(['p_',currId]) = EmpDistribution(auxVec,featIds{jj}, featIds(jj));
            empDistributions.(featIds{jj}).(['p_',currId]) = empDistributions.(featIds{jj}).(['p_',currId]).cleanOutliersOut();
        end
    end
     
end

if isfield(empDistributions,'count')
    empDistributions = rmfield(empDistributions,'count');
end


end

