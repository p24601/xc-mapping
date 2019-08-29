function this = transformSourceDistributions(this)
%transform all the source distributions using the optimal maps found.


for ii = 1:length(this.subMapNames)
    currSubMap = this.subMaps.(this.subMapNames{ii});
    currSubMap = currSubMap.transfromInputDistribution();
    this.subMaps.(this.subMapNames{ii}) = currSubMap;
end



end