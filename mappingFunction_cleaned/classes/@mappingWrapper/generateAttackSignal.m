function [attack_ecg,t] = generateAttackSignal(this,heartRate,seconds,srcFeatures,trgDev,indexSolution,noiseRatio,dupTimes,jointSampling,randSampling,addST)

if nargin < 11
    addST = false;
    if nargin < 10
        randSampling = false;
        if nargin < 9
            jointSampling = 0;
            if nargin < 8
                dupTimes = 3;
                if nargin < 7
                    noiseRatio = 1;
                    if nargin < 6
                        indexSolution=1;
                    end
                end
            end
        end
    end
end


%compute mean noise for all targets
%wngPowers = zeros(size(mapp.mapping,1),1);
%for i=1:length(wngPowers)
%    wngPowers(i)= mapp.targetFeatures.(mapp.mapping{i,2}).addtnlFeatures.wgnPower;
%end
%wgnPower=mean(wngPowers);
%noiseRatio = max(noiseRatio,0);
%wgnPower=wgnPower*noiseRatio;
%if(isnan(wgnPower))
wgnPower = 0 * noiseRatio;
%end

if( isempty(this.isIdentity) || ~this.isIdentity ) % if identity mapping than do not perform this
    
    if indexSolution~=1 %Maybe I should fix this at some point...
        error('Only indexSolution = 1, is currently implemented');
    end
    
    
    
    
    transformedFeats = srcFeatures.applyMappingToFeatures(this);
    %if ~isempty(mapp.featTypes)
    %    transformedFeats = mapp.extendFeatStruct(transformedFeatsTypes,srcFeatures);
    %else
    %    transformedFeats = transformedFeatsTypes;
    %end
else
    transformedFeats = srcFeatures;
end
%%%%%%%%%%%%%%transformedFeats = cleanTransFeats(transformedFeats);


%generate normally distributed PPs
if (heartRate > 0)
    heartPeriod=60/heartRate;
    PPlength = ceil(seconds/heartPeriod);
    PPs = normrnd(60/heartRate,heartPeriod/10,[1 PPlength]);
else
    PPs = transformedFeats.addtnlFeatures.PPs;
    %generate based on detected PPs
    if ~isnan(seconds)
        %if PPs are not enough, generate the remaining based on
        % mean and SD of the current
        meanPPs=mean(PPs);
        sdPPs=std(PPs);
        while(sum(PPs)<=seconds)
            PPs(end+1)=normrnd(meanPPs,sdPPs);
        end
        if randSampling
            permIdx = randperm(length(PPs));
            PPs = PPs(permIdx);
        end
        cumPPs = cumsum(PPs);
        finIdx = find(cumPPs > seconds,1);
        PPs = PPs(1:finIdx);
    end
end
%trgDev = mapp.targetFeatures.(mapp.mapping{1,2}).dev;
if this.isIdentity
    scaleFact = 1;
else
    scaleFact=trgDev.scaleFactor;
    if sqrt(wgnPower)>scaleFact
        scaleFact=sqrt(wgnPower);
    end
end
if addST
    STsndOrder = srcFeatures.addtnlFeatures.STsndOrder;
else
    STsndOrder = [];
end
%featNames = fieldnames(transformedFeats.ecgFeat);
%for currFeat = fieldnames(transformedFeats.ecgFeat)'
%    transformedFeats.ecgFeat.(currFeat{:}) = smooth(transformedFeats.ecgFeat.(currFeat{:}),10);
%end

attack_ecg = synthSignalFromFeatStruct(transformedFeats.ecgFeat,trgDev.fs,PPs,true,wgnPower,scaleFact,dupTimes, jointSampling,randSampling,addST,STsndOrder,transformedFeats.asymCurves);
t=1/trgDev.fs:1/trgDev.fs:(length(attack_ecg)/trgDev.fs);
end