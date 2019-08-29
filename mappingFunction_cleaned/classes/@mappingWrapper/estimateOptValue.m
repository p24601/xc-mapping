function this = estimateOptValue(this)

this.meanEstOptValue = zeros(length(this.subMapNames),1);
this.estOptValue = zeros(length(this.subMaps.(this.subMapNames{1}).userIDs),length(this.subMapNames));
for ii = 1:length(this.meanEstOptValue)
    disp(int2str(ii))
    [this.meanEstOptValue(ii),temp]  = this.subMaps.(this.subMapNames{ii}).estimateOptValueOfSubMap();
    this.estOptValue(:,ii) = temp;
end


end

