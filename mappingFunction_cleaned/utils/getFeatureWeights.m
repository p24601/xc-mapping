function featW8 = getFeatureWeights(dataPath,targetDev,sessionId,featureIDs,measID,subDevTarget)
if nargin < 6
    subDevTarget = {};
    if nargin < 5
        measID = 'rmi';
    end
end
switch sessionId
    case 'FirstSession'
        sessionId = 1;
    case 'SecondSession'
        sessionId = 2;
end
if ~isempty(subDevTarget)
    devStr = [targetDev, '_',subDevTarget{:}  ]; %modify here for gait
else
    devStr = targetDev;
end

fileName = [dataPath,devStr, '_session', int2str(sessionId), '_fi.csv'];
featIds = getFeatureNameFromHeader(fileName);
assert(isequal(featIds,featureIDs))
fid = fopen(fileName);
%
C = textscan(fid,['%s',repmat('%f',1,length(featureIDs))],'Delimiter',',','Headerlines',1); 

measureIDs = C{1};
featW8 = zeros(1,length(C)-1);

idx = strcmp(measureIDs,measID);
for ii = 1:length(featW8)
    featW8(ii) = C{ii+1}(idx);
end
fclose(fid);


end