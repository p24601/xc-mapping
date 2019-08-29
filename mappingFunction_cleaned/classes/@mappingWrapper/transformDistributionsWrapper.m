function transfDistrs = transformDistributionsWrapper(this, distrs)



distrs = joinStructOfDistrs(distrs, this.featuresCoding);


assert(isequal(this.subMapNames, fieldnames(distrs)));

for ii = 1:length(this.subMapNames)
    currSubMap = this.subMaps.(this.subMapNames{ii});
    transfDistrs.(this.subMapNames{ii}) = currSubMap.transformDistribution(distrs.(this.subMapNames{ii}));
    
    
end


transfDistrs = disJoinStructOfDistrs(transfDistrs,this.featuresCoding);



end
