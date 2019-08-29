classdef mappingWrapper
    %mapping Wrapper class. A mapping wrapper object has as fields the
    %various distribution to distribution submap I have to compute
    properties
        subMaps %structure in which each field is a submap. These are called with the ID of the associated distribution
        one2one
        subMapNames % names of the sub-maps that this wrapper defines
        isIdentity
        featuresCoding %features coding used for the mapping estimation. If it is empty, than no coding is used
        meanEstOptValue
        estOptValue
        regrMtd
    end
    methods
        
        
        
        function this = mappingWrapper(sourceDistributions,targetDistributions,degs,one2one,featuresCoding,regrMtd)
            assert(isequal(fieldnames(sourceDistributions),fieldnames(targetDistributions))); % checking that they actually have the same fields
            this.subMapNames = fieldnames(sourceDistributions);
            this.one2one = one2one;
            this.regrMtd = regrMtd;
            for ii = 1:length(this.subMapNames) %building each individual submap
                this.subMaps.(this.subMapNames{ii}) = Mapping(sourceDistributions.(this.subMapNames{ii}),targetDistributions.(this.subMapNames{ii}),one2one,this.subMapNames{ii},degs(ii),regrMtd);
            end
            this.isIdentity = false;
            this.featuresCoding = featuresCoding;
        end
        
        this = transformSourceDistributions(this)
        this = estimateMappingParameters(this,distanceMeasure,numOfThreads,verbose,modelMatName,currID)
        mapEvaluationPlots(this);
        this = estimateOptValue(this);
        fitVector = evalFeatureSecurityScore(this,id2Eval,dataPath,sourceDev,targetDev,lbFeats,ubFeats,subDevSource,subDevTarget,trgDataPath,trgId);
        userIDs = getUserIDS( this );
    end
    

end