function this = lighten_MappingWrapper(this)

userIDs = this.getUserIDS();
for ii = 1:length(this.subMapNames)
    for jj = 1:length(userIDs)
        this.subMaps.(this.subMapNames{ii}).inputDistributions.(userIDs{jj}).samples = [];
        this.subMaps.(this.subMapNames{ii}).inputDistributions.(userIDs{jj}).ecd_F_onMidPoints = [];
        this.subMaps.(this.subMapNames{ii}).inputDistributions.(userIDs{jj}).ed_f_onMidPoints = [];
    end
end


end