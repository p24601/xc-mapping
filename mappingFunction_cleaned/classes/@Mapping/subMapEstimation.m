function this = subMapEstimation(this,numOfThreads,verbose,outliersFraction,distanceMeasure,modelMatName,currID)
%estimating map function for each feature

if strcmp(this.regrMtd,'lin')
    % In case of linear regression, I compute some reasonable linear bounds
    % that make life easier for the optimisation algorithm
    nvars = length(this.mapSpec.params);
    idntt = double(mod((1:nvars), this.outputDimension + 1 ) == 0 );
    LbsOnOptVars = -10*ones(1,nvars);
    UbsOnOptVars = 10*ones(1,nvars);
    %generates linear contraints on the variables.
    [A , b, LB , UB ] = genLinConstrMatrix( nvars , this, this.mapSpec.is_monotonic);
    struct4GpOpt = [];
else
    nvars = [];
    idntt = [];
    LbsOnOptVars = [];
    UbsOnOptVars = [];
    A = [];
    b = [];
    [UB,LB] = evalUb_Lb();
    struct4GpOpt = [];
    struct4GpOpt.outliersFraction = outliersFraction;
    for ii = 1:length(this.userIDs)
        struct4GpOpt.xSamples{ii} = this.inputDistributions.(this.userIDs{ii}).samples;
        struct4GpOpt.ySamples{ii} = this.inputDistributions.(this.userIDs{ii}).samples;
    end
end

%number od grid points for approximation of L2 distance between functions,
N = 200;


for jj = 1:this.outputDimension
    %pre-computing grid points and central points of grid
    this.xs_output{jj} =  linspace(LB(jj),UB(jj),N);
    this.c_xs_output{jj} = this.xs_output{jj}(1:end-1) + (this.xs_output{jj}(2:end)-this.xs_output{jj}(1:end-1))/2;
    if strcmp(this.regrMtd,'gp')
        struct4GpOpt.xs_output{jj} =  this.xs_output{jj};
        struct4GpOpt.c_xs_output{jj} = this.c_xs_output{jj}; 
    end
end


%computing empirical cumulative density function of target distribution.
for jj = 1:length(this.userIDs)
    this.outputDistributions.(this.userIDs{jj}) = ...
        this.outputDistributions.(this.userIDs{jj}).compute_ECDF(this.xs_output,this.c_xs_output);
    if strcmp(this.regrMtd,'gp')
        struct4GpOpt.ecd_F_onMidPoints(jj) = this.outputDistributions.(this.userIDs{jj}).ecd_F_onMidPoints;
    end
    %computing empirical cumulative density function of input distribution
    if this.mapSpec.is_monotonic
        this.inputDistributions.(this.userIDs{jj}) = ...
            this.inputDistributions.(this.userIDs{jj}).compute_ECDF(this.xs_output,this.c_xs_output);

    end
    
end



%Getting initial fitness value.
if strcmp(this.regrMtd,'lin')
    initFitness = evalFitness(idntt,this,distanceMeasure,outliersFraction);
    fitHandle = @(x)evalFitness(x,this,distanceMeasure,outliersFraction);
else
    initFitness = [];
    fitHandle = [];
end


if verbose && ~(numOfThreads > 1)
    disp('Initial value of the fitness function')
    disp(initFitness);
end

switch this.regrMtd
    case 'lin'
        opt_alg = 'ps';
    case 'gp'
        opt_alg = 'gp';
    otherwise
        error('Regression method not implemented.')
end

[ x_star_partial,fstar_par, bestGp ] = runOptimization(opt_alg,LbsOnOptVars,UbsOnOptVars,nvars,numOfThreads,...
    verbose,A,b,fitHandle,idntt,struct4GpOpt,this.mapSpec.is_poly,modelMatName,currID,this.mapID);


switch this.regrMtd
    case 'lin'
        this.mapSpec.params = x_star_partial; 
    case 'gp'
        this.mapSpec.bestGp = bestGp;
    otherwise
        error('Regression method not implemented.')
end

%storing results in another object.
this.optResults = OptResults(x_star_partial,fstar_par,x_star_partial,fstar_par,toc);


end