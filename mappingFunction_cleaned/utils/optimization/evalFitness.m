function fitness = evalFitness(x,subMap,distMeasure,outliersFraction)
%evalFitness fitness function for the problem of finding optimal parameters
%for the transformations among features recorded with two different
%devices.
%Input: x, i.e. the domain variable.
%Output: fitness, i.e. the fitness function computed in x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description: the function computes the fitness of the transformation for
%the input variable x. The less the better. For linear transformation (which
%is the only one currently implemented). Let
%f_11,f_21,...,f_n1, observed distribution of n features from the device 1
%f_12,f_22,...,f_n2, observed distribution of n features from the device 2
%the function evaluate how well the following equality are satisfied
%a_i*f_i2+b_i = f_11 , for i=1,...,n
%where the a_i are the odd-indexes entries of x, and b_i are the even-indexed
%entries of x. The fitness is based on a measure of the dissimiliarities
%between each of the distributions. This is given by the auxiliary evalDissimilarity
%function. The fitness is computed for each patient and then it is meaned.
%The auxiliary function applyLinearTransf applies the linear transformation
%specified by the input variable x to the distributions associated to the
%second device.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 



patientFitness = zeros(length(subMap.userIDs),1);

subMap.mapSpec.params = x;


for ii = 1:length(subMap.userIDs)
    sourceId = subMap.userIDs{ii}; 
    targetId = subMap.userIDs{ii};

    sourceDistr = subMap.inputDistributions.(sourceId);%EmpDistributions object
    targetDistr = subMap.outputDistributions.(targetId);%EmpDistributions object
    
    if ~subMap.mapSpec.is_monotonic
        
        transfSourceDist = subMap.applyMapping(sourceDistr);%now returns a EmpDistributions object
        
    else
        transfSourceDist = sourceDistr;
        transfSourceDist.ecd_F_onMidPoints = transformLinearECDF(transfSourceDist.ecd_F_onMidPoints, ...
            subMap.c_xs_output,subMap.mapSpec.params(2),subMap.mapSpec.params(1)); 
    end
    patientFitness(ii) = targetDistr.computeDistanceFrom(transfSourceDist,distMeasure,subMap.xs_output,subMap.c_xs_output);
    
    
end


%if any(patientFitness > 1)
%    fitness = sum(patientFitness(patientFitness > 1) );
%else  
    outliers = removeOutlier(patientFitness,outliersFraction);
    %disp(find(outliers))
    patientFitness=patientFitness(~outliers);
    fitness = mean(patientFitness); %+ lambda * extraParamStruct.initFitness * dot(x-[0,1],x-[0,1]);
%end

end

