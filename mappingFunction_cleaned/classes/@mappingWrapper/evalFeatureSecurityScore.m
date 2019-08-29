function fitVector = evalFeatureSecurityScore(this,id2Eval,dataPath,sourceDev,targetDev,lbFeats,ubFeats,subDevSource,subDevTarget,trgDataPath,trgId)
%get input and output distribution for user id2Eval
if nargin < 11
    if nargin < 10
        trgDataPath = dataPath;
        if nargin < 9
            subDevTarget = {};
            if nargin < 8
                subDevSource = {};
            end
        end
        trgId = id2Eval;
    end
end

sourceDistributions = loadFeatureDistribution(dataPath,{id2Eval},sourceDev,subDevSource);
sourceDistributions = normalise(sourceDistributions,lbFeats.source,ubFeats.source);

targDistr = loadFeatureDistribution(trgDataPath,{trgId},targetDev,subDevTarget);
targDistr = normalise(targDistr,lbFeats.target,ubFeats.target);


transfDistr = transformDistributionsWrapper(this, sourceDistributions);


%targDistr = targetDistributions.(['p_',id2Eval]);
%transfDistr = transfDistributions.(['p_',id2Eval]);

featNames = fieldnames(targDistr);

fitVector = zeros(length(featNames),1);
for ii = 1:length(featNames)
    %[ub,lb] = evalUb_Lb(targDistr.(featNames{ii}).(['p_',id2Eval]).samples);
    [ub,lb] = evalUb_Lb();
    xs = linspace(lb,ub,200);
    fitVector(ii) = targDistr.(featNames{ii}).(['p_',trgId]).computeDistanceFrom(transfDistr.(featNames{ii}).(['p_',id2Eval]),'l2',{xs}, {midPointsOfGrid(xs)},false);
end





end