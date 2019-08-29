function this = trivialCrossVal(this,dataPath,numOfThreads,degs,featuresCoding,one2one,distanceMeasure)
%does not perform cross validation, just simple fitting on all the training
%set
if nargin < 7
    distanceMeasure = 'l2';
    if nargin < 6
        one2one = true;
        if nargin < 5
            featuresCoding = {};
            if nargin < 4
                degs = 1;
                if nargin < 3
                    numOfThreads = 1;
                end
            end
        end
    end
end

disp('Cross Validation Cycle: 1/1');
estimationSourceIds = this.ids;
id2Val = this.ids;
if exist(['maps',filesep,this.sourceDev],'dir')~=7
    mkdir(['maps',filesep,this.sourceDev]);
end


for deg = degs
    disp(['    Performing Optimization for Signal: ',this.sourceDev ,' using distance measure: ', distanceMeasure ]);
    disp(['    For degree: ', int2str(deg) ]);
    disp( '    Estimating mapping function...');
    this.mapWrapperStruct.('p_all') = estim4Dev(estimationSourceIds,estimationSourceIds,dataPath,this.sourceDev,...
        this.targetDev,this.featureIDs,this.lbFeats, this.ubFeats,distanceMeasure,one2one,deg, featuresCoding, numOfThreads, this.subDevSource , this.subDevTarget, this.regrMtd );
    for ii = 1:length(estimationSourceIds)
        this.fitOnValidation{ii} = this.mapWrapperStruct.('p_all').evalFeatureSecurityScore(estimationSourceIds{ii},dataPath,this.sourceDev,this.targetDev,this.lbFeats,this.ubFeats,this.subDevSource,this.subDevTarget);
    end
end
end
