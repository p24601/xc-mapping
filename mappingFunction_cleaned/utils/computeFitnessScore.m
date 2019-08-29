function [gp,fitness,theta] = computeFitnessScore(gp,evalstr,c_xs_output,xs_output,ecd_F_onMidPoints,outliersFraction)

%set up a matrix to store the tree outputs plus a bias column of ones
xtrain = gp.userdata.xtrain;
ytrain = gp.userdata.ytrain;
theta = [];
geneOutputsCell = cell(length(xtrain),1);
numGenes = numel(evalstr);

for ii = 1:length(geneOutputsCell)
    geneOutputsCell{ii} = ones(length(xtrain{ii}),numGenes+1);
    currXtrain = xtrain{ii};
    %eval each gene in the current individual
    for i = 1:numGenes
        ind = i + 1;
        eval(['geneOutputsCell{ii}(:,ind)=' evalstr{i} ';']);
        
        %check for nonsensical answers and break out early with an 'inf' if so
        if  any(~isfinite(geneOutputsCell{ii}(:,ind))) || any(~isreal(geneOutputsCell{ii}(:,ind)))
            fitness = Inf;
            gp.fitness.returnvalues{gp.state.current_individual} = [];
            return
        end
    end
end

%only calc. weighting coeffs during an actual run or if forced
if ~gp.state.run_completed || gp.state.force_compute_theta
    
    %MODIFICATION FOR DISTRIBUTIONS
    
   
   [theta,fitness] = getThetas(geneOutputsCell,ytrain,c_xs_output,xs_output,ecd_F_onMidPoints,outliersFraction);


    
    gp.fitness.returnvalues{gp.state.current_individual} = theta;
    %END MODIFICATION FOR DISTRIBUTIONS
else %if post-run, get stored coeffs from return value field
    theta = gp.fitness.returnvalues{gp.state.current_individual};
end


end
