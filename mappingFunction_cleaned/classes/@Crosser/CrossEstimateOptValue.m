function this = CrossEstimateOptValue(this)

if isempty(this.estOptValue)
    %this is stupid, the code is doing almost double the work. FIX IT!
    featNames = this.featureIDs;
    this.estOptValue = zeros(length(this.ids),length(featNames));
    for ii = 1:2
        switch this.crossMod
            case 'loo'
                currMapWrap = this.mapWrapperStruct.(fromID2fieldName(this.ids{ii}));
            case 'no'
                currMapWrap = this.mapWrapperStruct.('p_all');
        end
                
        
        currMapWrap = currMapWrap.estimateOptValue();
        mapUserIds = currMapWrap.getUserIDS();
        for jj = 1:length(mapUserIds)
            idx = find(strcmp(fromFieldName2ID(mapUserIds{jj}), this.ids ));
            if ~isempty(idx)
                this.estOptValue(idx,:) = currMapWrap.estOptValue(jj,:);
            end
        end
    end
end



        
        

end