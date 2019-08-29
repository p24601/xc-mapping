function distrOut = applyMapping(this,inputDistr)
%apply the transformation defined by the sub-map this, to the distribution
%inputDistr
assert(size(inputDistr.samples,2) == this.inputDimension);


samplesIn = inputDistr.samples;

if isempty(this.regrMtd)
   this.regrMtd = ''; 
end

%if isempty(this.regrMtd)
%    this.regrMtd = 'lin';
%end
switch this.regrMtd
    case 'lin'
        
        %samplesOut = zeros(size(samplesIn,1), this.outputDimension);
        %for ii = 1:size(samplesIn,1)
        %    samplesOut(ii,:) = this.mapSpec.fun( samplesIn(ii,:) ,  this.mapSpec.params(:) );
        %end
        
        %degAux = length(this.mapSpec.params) -1;
        %size( repmat(samplesIn,1,degAux+1))
        %size((0:degAux))
        %tic
        samplesOut =  this.mapSpec.fun( samplesIn ,  this.mapSpec.params(:) );
        %toc
        %tic
        %samplesOutAux = bsxfun( @power, repmat(samplesIn,1,degAux+1), 0:degAux ) * this.mapSpec.params(:) ;   
        %toc
        %disp('...')
        %isequal(samplesOutAux,samplesOut)
    case 'gp'
        samplesOut = zeros(size(samplesIn,1), this.outputDimension);
        bestGp = this.mapSpec.bestGp;
        for ii = 1:size(samplesIn,1)
            %try
                evalStr = regexprep(bestGp.eval_individual,'x(\d+)','samplesIn(ii,$1)');
                geneOutputsVal = zeros(size(evalStr));
                for jj = 1:length(evalStr)
                    eval(['geneOutputsVal(jj)=' evalStr{jj} ';']);
                end
                samplesOut(ii) = dot([1, geneOutputsVal],bestGp.returnvalues);
            %catch
            %    disp('...');
            %end
        end
         
end
distrOut = EmpDistribution(samplesOut,inputDistr.distributionID,inputDistr.subDistrIDs);
            
            
end