function [ub,lb] = evalUb_Lb()
distr = [-1,1];
perc = .5;
maxDistr = max(distr);
minDistr = min(distr);
ub = maxDistr + perc*(maxDistr - minDistr);
lb = max(minDistr - perc*(maxDistr - minDistr));

end
