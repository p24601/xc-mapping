function mappingComparison(map1,map2,userId,str1,str2)
if nargin < 4
    str1 = 'Map 1';
    str2 = 'Map 2';
end

sourceFeat = map1.sourceFeatures.(['p_', userId]).ecgFeat;

if ~isequal(sourceFeat , map2.sourceFeatures.(['p_', userId]).ecgFeat)
    error('The source features for the two mappings are different')
end

targetFeat = map1.targetFeatures.(['p_', userId]).ecgFeat;

if ~isequal(targetFeat , map2.targetFeatures.(['p_', userId]).ecgFeat)
    error('The target features for the two mappings are different')
end

transfFeat1 = map1.transformedSourceFeatures.(['p_', userId]).ecgFeat;
transfFeat2 = map2.transformedSourceFeatures.(['p_', userId]).ecgFeat;

featNames = fieldnames(transfFeat1);
for ii = 1:length(featNames)
   distrComparison(transfFeat1.(featNames{ii}),transfFeat2.(featNames{ii}) ,sourceFeat.(featNames{ii}), targetFeat.(featNames{ii}), featNames{ii},str1,str2 );  
end



end

function distrComparison(transfFeat1,transfFeat2,sourceFeat,targetFeat,featName,str1,str2)
figure
hold on
grid on
N = 200;


width = max(targetFeat) - min(targetFeat);
%LB = 0.5*min(targetFeat);
%UB = 1.5*max(targetFeat);
LB = min(targetFeat) - 0.33*width;
UB = max(targetFeat) + 0.33*width;
xs = linspace(LB,UB,N);
c_xs =  xs(1:end-1) + (xs(2:end)-xs(1:end-1))/2;

[Fsource , x] = ecdf( sourceFeat );
Fsource1 = Fsource;
Fsource1 =  evalECDF(x(2:end),Fsource1(2:end),xs);
fsource = [0 , (Fsource1(2:end) - Fsource1(1:end-1))./(c_xs(2) - c_xs(1))];
Fsource = evalECDF(x(2:end),Fsource(2:end),c_xs);

[Ftarget , x] = ecdf(targetFeat);
Ftarget1 = Ftarget;
Ftarget1 =  evalECDF(x(2:end),Ftarget1(2:end),xs);
ftarget = [0 , (Ftarget1(2:end) - Ftarget1(1:end-1))./(c_xs(2) - c_xs(1))];
Ftarget = evalECDF(x(2:end),Ftarget(2:end), c_xs);

[F1 , x] = ecdf(transfFeat1);
F11 = F1;
F11 =  evalECDF(x(2:end),F11(2:end),xs);
f1 = [0 , (F11(2:end) - F11(1:end-1))./(c_xs(2) - c_xs(1))];
F1 = evalECDF(x(2:end),F1(2:end), c_xs);

[F2 , x] = ecdf(transfFeat2);
F21 = F2;
F21 =  evalECDF(x(2:end),F21(2:end),xs);
f2 = [0 , (F21(2:end) - F21(1:end-1))./(c_xs(2) - c_xs(1))];
F2 = evalECDF(x(2:end),F2(2:end), c_xs);

h1 = plot(c_xs, Fsource);
h2 = plot(c_xs, Ftarget);
h3 = plot(c_xs, F1);
h4 = plot(c_xs, F2);

fit1 = mid_point( (F2 -  Ftarget ).^2  , xs);
fit2 = mid_point( (Fsource -  Ftarget ).^2  , xs);
legend([h1,h2,h3,h4],{'Source','Target',str1, str2});
title(['comparison for ', featName, '. ', str2, '=',num2str(fit1), '. Source=',num2str(fit2),'.' ]);
hold off



figure
hold on
h1 = plot(xs,smooth(fsource,16));
h2 = plot(xs,smooth(ftarget,16));
h3 = plot(xs,smooth(f1,10));
h4 = plot(xs,smooth(f2,10));
legend([h1,h2,h3,h4],{'Source','Target',str1, str2});
title(['comparison for ', featName, '. ', str2, '=',num2str(fit1), '. Source=',num2str(fit2),'.' ]);
hold off
end