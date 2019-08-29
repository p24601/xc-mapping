function outDistrs = transformDistribution(this,inDistrs)

userIDs = fieldnames(inDistrs);

for ii = 1:length(userIDs)
    outDistrs.(userIDs{ii}) = this.applyMapping(inDistrs.(userIDs{ii}));
end



end