classdef EmpDistribution
%Class for handling empirical distribution.    
    properties
      samples                   %samples is a  matrix. Each column of the the matrix is a vector of the sample for the corresponding distribution
      numOfVariables            %number of random variable in the distribution
      ecd_xs                    %x-axis point for marginal computation of each individual ECDF (). 
      %ecd_Fs                   %marginals ECDF values on the x-axis point above.
      ecd_midPointsOf_xs        %mid-points of the x-axis above. Used for the quadrature formula
      ecd_F_onMidPoints         %marginals ECDF values on mid-points
      ed_f_onMidPoints          %marginals empritical density function on mid-points
      ecdf_joint                %joint ECDF values.
      distributionID            %ID for the distribution modeled
      subDistrIDs               %cell array of Ids for the marginal distributions modeled
      optAvgDist                %array of optimal average distance estimated
    end
    
    methods
        
        function this = EmpDistribution(samples,distributionID,subDistrIDs)
            %builds the object EmpDistribution. LB and UB are vector of
            %lower and upper bounds of the domain in which to evaluate the
            %ecd function for each random variable considered. N is the
            %number of points in which each interval [LB(ii), UB(ii)] is discretized
           this.samples = samples;
           this.numOfVariables = size(this.samples,2);
            
           this.ecdf_joint = []; %not yet implemented
           this.distributionID = distributionID;
           assert(this.numOfVariables == length(subDistrIDs));
           this.subDistrIDs = subDistrIDs;
           this.optAvgDist = zeros(this.numOfVariables,1);
        end
        
        
        
        
        function [this,Fs , xs] = compute_ECDF(this,ecd_xs,ecd_midPointsOf_xs)
            
            
            for ii = 1:this.numOfVariables
               
               %this.ecd_xs{ii} = ecd_xs{ii}; 
               %this.ecd_midPointsOf_xs{ii} =  ecd_midPointsOf_xs{ii};   
 
               [Fs , xs] = ecdf(this.samples(:,ii) );        
                         
               this.ecd_F_onMidPoints{ii} = evalECDF(xs(2:end),Fs(2:end),ecd_midPointsOf_xs{ii});     
               %Fs_mid = evalECDF(xs(2:end),Fs(2:end),this.ecd_xs{ii} );
               %this.ed_f_onMidPoints{ii} = smooth([0 , (Fs_mid(2:end) - Fs_mid(1:end-1))./(this.ecd_midPointsOf_xs{ii}(2) - this.ecd_midPointsOf_xs{ii}(1))],16);    
               
           end
           %this = freeXaxisVectors(this); 
            
        end
        
        function this = freeXaxisVectors(this)
            %since often these two cell arrays are shared among a big
            %number of distributions, for memory efficiency reason it does
            %not make sense to have as many copies as input distributions.
            this.ecd_xs = {};
            this.ecd_midPointsOf_xs = {};
        end
        
        
        function this = mergeEmpDistributions(this, other)
            
            assert(this.numOfVariables == other.numOfVariables) 
            this.samples = [this.samples ; other.samples];
            
            
        end
        
        
        function distance = computeDistanceFrom(this,other,distMeasure,xs, c_xs,cacheFlag)
            if nargin < 6
                cacheFlag = true;
            end
            assert(this.numOfVariables == other.numOfVariables)
            
            distance = 0;
            %switch distMeasure
            %    case 'chi-square'
                    
            %        for ii = 1:this.numOfVariables
            %            nbins = 10;
            %            [h1,h2] = getHists(this.samples{ii},other.samples{ii},nbins,'frequency');
            %            [chiSquare, dof] = getChiSquare(h1,h2);
            %            chiSquare = chi2cdf(chiSquare,dof);
            %            distance = distance + chiSquare;
            %        end
            %        
            %    case 'ks'
            %        for ii = 1:this.numOfVariables
            %            KSStat  = getKSStat(this.samples{ii},other.samples{ii}, '', true);
            %            distance = distance + KSStat;
            %        end
                    
            %    case 'l2'
                    if cacheFlag
                        if isempty(this.ecd_F_onMidPoints)
                            warning('This should be computed already')
                            this = this.compute_ECDF(xs,c_xs);
                        end
                        %if ~isempty(other.ecd_F_onMidPoints)
                        %    warning('This should not be computed already')
                        %end
                    else
                        this = this.compute_ECDF(xs,c_xs);
                    end
                    if isempty(other.ecd_F_onMidPoints)
                        [other, Fs_other , xs_other] = other.compute_ECDF(xs,c_xs);
                    else 
                        Fs_other = [];
                        xs_other = [];
                    end
                    for ii = 1:this.numOfVariables
                        
                        l2distance = l2Dist( other.ecd_F_onMidPoints{ii}  , this.ecd_F_onMidPoints{ii} , xs{ii} , true, Fs_other(2:end) , xs_other(2:end) );
                        
                        distance = distance + l2distance;
                    end
                    distance = distance/this.numOfVariables;
                    
            %end
            
            
            
        
        
        end
        function this = joinEmpDistributions(this,other,newID, oldID)
            %methods for joining two empirical distributions into one.
            this.samples = [this.samples , other.samples];
            this.numOfVariables = size(this.samples,2);
            this.distributionID = newID;
            this.subDistrIDs{end + 1} = oldID;
        end
        
        function this = extractEmpDistributions(this, ID2select)
            %methods for extracting an empirical distribution from a joint distribution.
            idx = find(strcmp(this.subDistrIDs,ID2select));
            if isempty(idx)
                error('ID distribution requested not in the joint distribution given as input');
            end
            this.samples = this.samples(:,idx);
            this.numOfVariables = size(this.samples,2);
            this.distributionID = ID2select;
            this.subDistrIDs = {this.distributionID};
        end
        
        function plotHist(this)
            for ii = 1:this.numOfVariables
                     
                currSamples = this.samples(:,ii);
                hold on;
                histogram(currSamples,'Normalization','probability')
                xlabel(this.subDistrIDs{ii});
                ylable('probability')
                hold off;
            end
            
            
        end
        
        function this = evalAverageOptDistance(this)
           for ii = 1:length(this.numOfVariables)
               ID2select = this.subDistrIDs{ii};
               currMarginalDist = this.extractEmpDistributions(ID2select);
               this.optAvgDist(ii) = currMarginalDist.evalAverageOptDistanceSV();
           end
           
            
        end
        
        function optAvgDist = evalAverageOptDistanceSV(this)
            assert(this.numOfVariables == 1);
            N = 10;
            optAvgDist = 0;
            for ii = 1:N
                [splitOne, splitTwo] = this.splitDistrInTwo();
                xs = linspace(min(this.samples),max(this.samples),200);
                if range(xs) == 0
                    optAvgDist = optAvgDist + 0;
                else
                    optAvgDist = optAvgDist + splitOne.computeDistanceFrom(splitTwo,'l2',{xs}, {midPointsOfGrid(xs)},false);
                end
            end
            optAvgDist = optAvgDist/N;
        end

        function [splitOne , splitTwo] = splitDistrInTwo(this)
            frac = 0.66;
            assert(this.numOfVariables == 1);
            currSamples = this.samples;
            fracLen = round(frac*length(currSamples));            
            lenFromBack = length(currSamples) - fracLen;
            
            currSamples = currSamples(randperm(length(currSamples)));
            auxCurrSamples = currSamples(1:fracLen);
            splitOne = EmpDistribution(auxCurrSamples,this.distributionID,this.subDistrIDs);
            
            auxCurrSamples = currSamples(lenFromBack:end);
            splitTwo = EmpDistribution(auxCurrSamples,this.distributionID,this.subDistrIDs); 
        end
        function this = cleanOutliersOut(this)
            if this.numOfVariables > 1
                error('I need to implement this yet')
            end
            this.samples = this.samples(~isnan(this.samples));
             outIndexes = removeOutlier(this.samples,0.3);
             this.samples = this.samples(~outIndexes);
            
        end
        function this = normaliseDistr(this,Lb,Ub)
           for ii = 1:this.numOfVariables
               this.samples(:,ii) = 2*(this.samples(:,ii) - Lb(ii))/(Ub(ii)-Lb(ii)) - 1;
           end
            
        end

        
        
        
    end
end
