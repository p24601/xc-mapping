classdef Mapping
%Class that defines property and method used to handle mapping functions.    
    properties
        inputDistributions          %a structure of empirical distribution object. One for field for each input user
        outputDistributions         %a structure of empirical distribution object. One for field for each output user  
        one2one                     %if true, performs multi-patient optimisation. If false, merges the features into single source and target patients
        mapID                       %map ID: is the ID of the analysed distribution
        optResults                  %results for the specific optimization performed for this mapping
        transformedDistributions    %input distribution transformed accordingly to current map defined by parameters.
        mapSpec                     %a structure indicating the form of the mapping function to be estimated here.
        inputDimension              %number of r.v. that define the input of the mapping
        outputDimension             %as above, but for the output
        userIDs        
        xs_output                   %cell-array xs for the output ecdf computations       
        c_xs_output                 %cell-array c_xs for the output ecdf computations
        regrMtd
    end
    
    methods
        function this = Mapping(inputDistributions,outputDistributions,one2one,mapID,deg,regrMtd)
            if nargin<3
                one2one=true;
            end
            
            %this.isIdentity = false;
            this.one2one=one2one;
            this.inputDistributions=inputDistributions;
            this.outputDistributions=outputDistributions;
            this.one2one = one2one;
            this.mapID = mapID;
            this.userIDs = fieldnames(this.inputDistributions);
            this.inputDimension = this.inputDistributions.(this.userIDs{1}).numOfVariables;
            this.outputDimension = outputDistributions.(this.userIDs{1}).numOfVariables;
            this.regrMtd = regrMtd;
            switch regrMtd
                case 'lin'
                    this.mapSpec = polynomial_map_spec(deg, this.inputDimension ,this.outputDimension);
                case 'gp'
                    this.mapSpec = gp_map_spec(this.inputDimension,this.outputDimension);
            end
            
            if ~this.one2one
                disp('one2one parameter set to false. Merging the source and target features...')
                superPatientName = 'superPatient';            
                this=this.mergeMapDistributions(superPatientName,superPatientName);
            end
            
            
            

            this.xs_output = cell(this.outputDimension,1);
            this.c_xs_output = cell(this.outputDimension,1);
            
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%
        %methods defined elsewhere
        mapp=mergeMapDistributions(mapp,sourcePatientName,targetPatientName)
        mapp=estimateMappingParameters(mapp,distanceMeasure,numOfThreads,verbose)
        [attack_ecg,t] = generateAttackSignal(mapp,heartRate,seconds,srcFeatures,indexSolution,noiseRatio,dupTimes,jointSampling,randSampling,addST)
        outDistrs = transformDistribution(this,inDistrs)
        [estOptValueMean, estOptValue] = estimateOptValueOfSubMap(this)
        
        %%%%%%%%%%%
        
        
        
        

        function this = transfromInputDistribution(this)
            for ii = 1:length(this.userIDs)
                this.transformedDistributions.(this.userIDs{ii}) = this.applyMapping(this.inputDistributions.(this.userIDs{ii}));
            end
        end
        
        
        function displayMapping(mapp)
            disp('Mapping:');
            for i=1:size(mapp.mapping,1)
                sourceId=mapp.mapping{i,1};
                targetId=mapp.mapping{i,2};
                sourceDev=mapp.sourceDistributions.(sourceId).dev.id;
                targetDev=mapp.targetDistributions.(targetId).dev.id;
                disp(['Patient: ', sourceId,', Device: ',sourceDev,' --> ','Patient: ', targetId,', Device: ',targetDev]);
            end
        end
        
        function plotFeaturesHistogramsBeforeOpt(mapp,varargin)
            mapp.plotFeaturesHistograms(false,varargin{:});
        end
        
        function plotFeaturesHistogramsAfterOpt(mapp,varargin)
            mapp.plotFeaturesHistograms(true,varargin{:});
        end
        
        function plotFeaturesHistograms(mapp,transformed,varargin)
            if transformed
                srcFeatures=mapp.transformedSourceDistributions;
                strPrefix='after';
            else
                srcFeatures=mapp.sourceDistributions;
                strPrefix='before';
            end
            
            for i=1:size(mapp.mapping,1)
                sourceId=mapp.mapping{i,1};
                targetId=mapp.mapping{i,2};
                sourceDev=srcFeatures.(sourceId).dev.id;
                targetDev=mapp.targetDistributions.(targetId).dev.id;
                
                sourceFeats = srcFeatures.(sourceId).ecgFeat;
                targetFeats = mapp.targetDistributions.(targetId).ecgFeat;
                
                histFromFeatureStruct(sourceFeats,targetFeats ,[strPrefix,'_opt_source_patient_',sourceId, '_target_patient_',targetId], sourceDev,targetDev,varargin{:});
            end
        end
        


  
    end
end
