function [estimationSourceIds, estimationTargetIds,existGenderCell,existGlassesCell] = getEstimationIDs(ids,basePath,currSource,targetDev,subDevSource,subDevTarget,genderCell,glassesCell)
if nargin < 8
    glassesCell = {};
    if nargin < 7
        genderCell = {};
        if nargin < 6
            subDevTarget = {};
            if nargin < 5
                subDevSource = {};
            end
        end
    end
end
estimationSourceIds = {};
estimationTargetIds = {};
existGenderCell = {};
existGlassesCell = {};

for jj = 1:length(ids)
    currentId = ids(jj);
    if ~isempty(genderCell)
        currGender = genderCell(jj);
    end
    if ~isempty(glassesCell)
        currGlasses = glassesCell(jj);
    end
    if isempty(subDevSource)
        sourceFiles = {[basePath,currentId{:} , filesep, currSource , '.csv' ]};
    else
        for ii = 1:length(subDevSource)
            sourceFiles{ii} = [basePath,currentId{:} , filesep, currSource , filesep,subDevSource{ii}  '.csv' ];
        end
    end
    if isempty(subDevTarget)
        targetFiles = {[basePath,currentId{:} , filesep, targetDev , '.csv' ]};
    else
        for ii = 1:length(subDevTarget)
            targetFiles{ii} = [basePath,currentId{:} , filesep, targetDev , filesep,subDevTarget{ii}  '.csv' ];
        end
    end
    boolSource = true;
    for ii = 1:length(sourceFiles)
        boolSource = boolSource && (exist(sourceFiles{ii},'file') == 2);
        if boolSource %check that the file is not empty...
            boolSource = boolSource && isFileNotAlmostEmpty(sourceFiles{ii});
        end
    end
    
    boolTarget = true;
    for ii = 1:length(targetFiles)
        boolTarget = boolTarget && (exist(targetFiles{ii},'file') == 2);
        if boolTarget %check that the file is not empty...
            boolTarget = boolTarget && isFileNotAlmostEmpty(targetFiles{ii});
        end
    end
    
    if boolSource
        if boolTarget
            estimationSourceIds{end+1} = currentId{:};
            estimationTargetIds{end+1} = currentId{:};
            if ~isempty(genderCell)
                existGenderCell{end+1} = currGender{:};
            end
            if ~isempty(glassesCell)
                existGlassesCell{end+1} = currGlasses{:};
            end
        else 
            %warning(['Features of ' targetDev, ' for user ', currentId{:}, ' not found']);
        end
    else
        %warning(['Features of ' currSource, ' for user ', currentId{:}, ' not found']);
    end
end

end

function boolOut = isFileNotAlmostEmpty(fileName)
fid = fopen(fileName);
count = 0;
boolOut = false;
while true
    if ~ischar( fgetl(fid) ); break; end
    count = count + 1;
    if count > 10
        boolOut = true;
        break;
        
    end
end
fclose(fid);
end




