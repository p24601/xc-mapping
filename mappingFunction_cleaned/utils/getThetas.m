function [thetaStar,bestFit] = getThetas(geneOutputsCell,ytrain,c_xs_output,xs_output,ecd_F_onMidPoints,outliersFraction)

theta0 = zeros(size(geneOutputsCell{1},2),1);

opts = optimset('fminsearch');
opts.Display = 'off';
opts.MaxFunEvals = 50;
fitHandle = @(x)(evalFit4ThetaValue(x,geneOutputsCell,ytrain,c_xs_output,xs_output,ecd_F_onMidPoints,outliersFraction));
[thetaStar,bestFit] = fminsearch(fitHandle,theta0,opts);
%thetaStar
%bestFit
end

function currFit = evalFit4ThetaValue(currTheta,geneOutputsCell,ytrain,c_xs_output,xs_output,ecd_F_onMidPoints,outliersFraction)

ypredtrain = cell(length(geneOutputsCell),1);
for kk = 1:length(geneOutputsCell)
    ypredtrain{kk} = geneOutputsCell{kk} * currTheta;
end
currFit = computeFit(ypredtrain,ytrain,c_xs_output,xs_output,ecd_F_onMidPoints,outliersFraction);

end