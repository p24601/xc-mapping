function outIndexes = removeOutlier(vec, fract, testAlpha)
%removeOutlier it is used to remove outliers from a vector, using the
%Grubbs' test for outliers.
%Input:
%       -featureVec, observation vector to be checked for outliers
%Output:
%       -outIndexes, vector of 0s and 1s. 1 entrys correspond to indexes
%                    associated to outliers.
%Usage:
%      -outIndexes = removeOutlier( featureVec )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description: The function applies iteratively the Grubbs' test for
%outliers to the input vector, until not outliers are found, up to a
%maximum number of iteration (10% of the input vector length), using
%alpha= 0.5. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 3
	testAlpha = 0.1;
	if nargin < 2
	    fract=0.2;
	end
end

N = length(vec);
maxRep = fract*N; %Defining the maximum number of iterations allowed
outIndexes = zeros(1,N); %preallocating the output vector
%testAlpha = 0.10; %significativity of the test

for ii = 1:maxRep
    N = N-ii+1; % updating the numerosity of the sample
    %computing mean and standard deviation of current vector
    featureMean = mean(vec(~outIndexes));
    featureStd = std(vec(~outIndexes));
    %Building the test statistic
    tempVec = abs(vec-featureMean);
    [~,idx] = max(tempVec);
    G = tempVec(idx)/featureStd;
    %computing test critical value
    tq = tinv(testAlpha/(2*N) , N-2 )^2;
    criticValue = ((N-1)/sqrt(N))*sqrt( tq/ ( N-2 +   tq      ));
    
    if G > criticValue
        outIndexes(idx) = 1; % flagging outliers
        %disp('Outlier found')
    else 
        break
    end
    

end



%exclude also +Inf and -Inf
outIndexes(vec==Inf | vec==-Inf)=1;

end

