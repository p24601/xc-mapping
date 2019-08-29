function optMappingWrap = estim4Dev(estimationSourceIds,estimationTargetIds,baseDir,sourceDevId,targetDev,featNames,lbFeats, ubFeats, distanceMeasure,one2one,deg, featuresCoding,numOfThreads, subDevSource , subDevTarget,regrMtd,modelMatName,currID)
%wrapper for the estimation of the optimization maps
if nargin < 17
    currID = '';
    if nargin < 16
        modelMatName = '';
        if nargin < 15
            regrMtd = 'lin';
            if nargin < 14
                subDevSource = {};
                subDevTarget = {};
                if nargin < 12
                    featuresCoding = {};
                    if nargin < 11
                        deg = 1;
                        if nargin < 10
                            one2one = true;
                            if nargin < 9
                                distanceMeasure = 'l2';
                            end
                        end
                    end
                    
                end
            end
        end
    end
end
%Loading Source and target empirical feature distribution
sourceDistributions = loadFeatureDistribution(baseDir,estimationSourceIds,sourceDevId,subDevSource);
targetDistributions = loadFeatureDistribution(baseDir,estimationTargetIds,targetDev,subDevTarget);
%checking the distribution are defined over the same features
assert(isequal(featNames(:),fieldnames(sourceDistributions)))
assert(isequal(featNames(:),fieldnames(targetDistributions)))
%normalise feature values
sourceDistributions = normalise(sourceDistributions,lbFeats.source,ubFeats.source);
targetDistributions = normalise(targetDistributions,lbFeats.target,ubFeats.target);
        

%If feature coding is used, these line take care of combining the
%corresponding distributions
sourceDistributions = joinStructOfDistrs(sourceDistributions,featuresCoding);
targetDistributions = joinStructOfDistrs(targetDistributions,featuresCoding);  

%Defining the mapping function objects.
degs = deg * ones(length(fieldnames(sourceDistributions)),1);
optMappingWrap = mappingWrapper(sourceDistributions,targetDistributions,degs,one2one,featuresCoding,regrMtd);



verboseOutput=false;

%estimate the parameters 
optMappingWrap = optMappingWrap.estimateMappingParameters(distanceMeasure,numOfThreads,verboseOutput,modelMatName,currID);

end
