classdef Crosser
    %Class for cross validation of the mapping function
    
    properties
        ids                         %ids of users to perform cross validation on
        mapWrapperStruct            %structure defining the various mapping function estimated at each validation step
        fitOnValidation             %results of cross validation.
        sourceDev                   %ID of source device used
        targetDev                   %ID of target device used
        subDevSource                %String for subset of device used (e.g. specific activity performed) for the source
        subDevTarget                %String for subset of device used (e.g. specific activity performed) for the target
        estOptValue                 %optimum value of functions
        initFit                     %Initial fitness value
        crossMod                    %string for cross validation type used. 'loo' correspond to Leave One user Out cross validation. 'no' does not perform any cross validation at all.
        featureIDs                  %String IDs of features considered in the optimisation
        featureCoding               %Can be used to combine features together and learn a joint mapping function
        lbFeats                     %Lower bound of features
        ubFeats                     %Upper bound of features
        dataPath                    %Data path to featues csv files
        secScoreMatrix            
        bioScore
        regrMtd                     %Specific regression function to be used. Default 'lin' learns a linear mapping function
        maxTrainSetSize             
        numOfRep                    
    end
    
    methods
        function  this = Crosser(ids,sourceDev,targetDev,dataPath,subDevSource,subDevTarget,crossMod,featureCoding,regrMtd,maxTrainSetSize,numOfRep)
            if nargin < 11
                numOfRep = 1;
                if nargin < 10
                    maxTrainSetSize = inf;
                    if nargin < 9
                        regrMtd = 'lin';
                        if nargin < 8
                            featureCoding = {};
                            if nargin < 7
                                crossMod = 'loo';
                                if nargin < 5
                                    subDevSource = {};
                                    subDevTarget = {};
                                end
                            end
                        end
                    end
                end
            end
            this.ids = ids;
            this.fitOnValidation = cell(length(ids),1);
            this.sourceDev = sourceDev;
            this.targetDev = targetDev;
            this.subDevSource = subDevSource;
            this.subDevTarget = subDevTarget;
            this.crossMod = crossMod;
            this.featureCoding = featureCoding;
            this.dataPath = dataPath;
            %Get the IDs of features by analysing a csv source and target
            %file
            this.featureIDs = getFeaturesName(this.sourceDev,this.subDevSource,this.dataPath,this.ids,this.targetDev,this.subDevTarget);
            %Computing estimated lower and upper bound for features values.
            [this.lbFeats,this.ubFeats] = evalLB_and_UB_for_Crosser(this.featureIDs,this.dataPath,this.sourceDev,this.subDevSource,...
                this.targetDev,this.subDevTarget,this.ids);
            this.regrMtd = regrMtd;
            this.maxTrainSetSize = maxTrainSetSize;
            this.numOfRep = numOfRep;
        end
        %%%
        %%%
        %methods defined elsewhere
        this = CrossEstimateOptValue(this);
        this = levaeOneOutCrossVal(this,dataPath,numOfThreads,degs,featuresCoding,one2one,distanceMeasure,modelMatName);
        %%%
    end
    
end

