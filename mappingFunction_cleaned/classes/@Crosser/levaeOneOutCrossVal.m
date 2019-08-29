function this = levaeOneOutCrossVal(this,dataPath,numOfThreads,degs,featuresCoding,one2one,distanceMeasure,modelMatName)
%Performing leave one user out cross validation on the mapping function
%estimation.
if nargin < 8
    modelMatName = '';
    if nargin < 7
        distanceMeasure = 'l2';
        if nargin < 6
            one2one = true;
            if nargin < 5
                featuresCoding = {};
                if nargin < 4
                    degs = 1; %polynomial degree of mapping function to be learnt
                    if nargin < 3
                        numOfThreads = 1;
                    end
                end
            end
        end
    end
end
%Unrolling big objects for parfor optimization
ids = this.ids;
sourceDev = this.sourceDev;
outputCell = cell(size(ids));
targetDev = this.targetDev;
featureIDs = this.featureIDs;
lbFeats = this.lbFeats;
ubFeats = this.ubFeats;
subDevSource = this.subDevSource;
subDevTarget = this.subDevTarget;
regrMtd = this.regrMtd;
fitOnValidation = cell(size(ids));
maxTrainSetSize = this.maxTrainSetSize;
numOfRep = this.numOfRep;
%%

disp(['Performing Cross Validation from Signal: ',sourceDev ,' (subDev:',strjoin(subDevSource) ,') to Signal: ', ...
    targetDev, ' (subDev:',strjoin(subDevTarget) ,') for deg:',int2str(degs), ' maxTrainSetSize: ' int2str(this.maxTrainSetSize)]);
for ii = 1:length(ids)
    disp(['Cross Validation Cycle: ', int2str(ii), '/', int2str(length(ids))]);
    estimationSourceIds = ids((1:length(ids))~= ii );
    
    for deg = degs

        
        
        maxLen = min(length(estimationSourceIds),maxTrainSetSize);
        estimationSourceIdsCell = {};
        if maxLen < length(estimationSourceIds)
            %training/validation partition of the IDs
            estimationSourceIdsCell = partitionIDs(estimationSourceIds,maxLen,numOfRep);
        else
            estimationSourceIdsCell{1} = estimationSourceIds;
        end
        outAuxCell = cell(numOfRep,1);
        fitAuxCell = cell(numOfRep,1);
        for jj = 1:numOfRep %this unrolling is necessary for parfor loop
                %estimating mapping function
                outAuxCell{jj} = estim4Dev(estimationSourceIdsCell{jj},estimationSourceIdsCell{jj},dataPath,sourceDev,...
                    targetDev,featureIDs,lbFeats, ubFeats,distanceMeasure,one2one,deg, featuresCoding, numOfThreads, subDevSource , subDevTarget, regrMtd,modelMatName,ids{ii}  );
                %computing security score of optimal mapping function
                fitAuxCell{jj} = outAuxCell{jj}.evalFeatureSecurityScore(ids{ii},dataPath,sourceDev,targetDev,lbFeats,ubFeats,subDevSource,subDevTarget);
        end
        outputCell{ii} = outAuxCell;
        fitOnValidation{ii} = fitAuxCell;
    end
end


for ii = 1:length(ids)
    for jj = 1:numOfRep
        if numOfRep == 1
            this.mapWrapperStruct.(['p_',ids{ii}]) = outputCell{ii};
        else
            outputCell{ii}{jj} =  outputCell{ii}{jj}.lighten_MappingWrapper(); % I remove samples from these distribution, otherwise I would fill up the ram very quickly...
            this.mapWrapperStruct.(['p_',ids{ii},'_',int2str(jj)]) = outputCell{ii}{jj};
        end
        this.fitOnValidation{ii,jj} = fitOnValidation{ii}{jj};
    end
end

end
