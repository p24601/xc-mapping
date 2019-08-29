function compareFeatureScores(varargin)
if isempty(varargin)
    error('at least one argument must be provided')
end
if mod(length(varargin),3)
    error('For every score you must provide both sources ids and target id')
end

numOfScores = length(varargin)/3;
featScoreMats = cell(numOfScores,1);
sourceIds = cell(numOfScores,1);
targetIds = cell(numOfScores,1);
ii = 1;
jj = 1;
while ii <= length(varargin)
    featScoreMats{jj} = varargin{ii};
    ii = ii + 1;
    sourceIds{jj} = varargin{ii};
    assert(size(featScoreMats{jj},1)==length(sourceIds{jj}));
    ii = ii + 1;
    targetIds{jj} = varargin{ii};
    assert(ischar(targetIds{jj}));
    ii = ii + 1;
    jj = jj + 1;
end
numOfSourceDev = length(sourceIds{1});
for ii = 2:numOfScores
    assert(numOfSourceDev ==  length(sourceIds{ii}))
end

barMatrix = zeros(numOfScores,numOfSourceDev);
for ii = 1:numOfScores
    for jj =1:numOfSourceDev
        barMatrix(ii,jj) = mean(featScoreMats{ii}(jj,:));
    end
end
creatBarPlot(barMatrix,targetIds,sourceIds)

end
