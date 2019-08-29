function matFile = fromInputs2FileName(currSource,subDevSource,targetDev,subDevTarget,mapSession,deg)


optId = mapSession;
if deg == 1
    optId = [optId,'Linear'];
else
    optId = [optId,'Deg',int2str(deg)];
end
optId = [optId,'SV'];
matFile = ['maps/',currSource{:},filesep,optId,'_', currSource{:}, '_', strjoin(subDevSource), '_',...
                    targetDev,'_', strjoin(subDevTarget), '_Crosser.mat' ];

end