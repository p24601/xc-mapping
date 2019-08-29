function this = compInitFitMatrix(this)
%comp init function value of crosser object

if isempty(this.initFit)
    featNames = this.featureIDs;
    this.initFit = cell(length(this.ids),1);
    for ii = 1:length(this.ids)
        this.initFit{ii} = zeros(length(featNames),1);
        currID = this.ids{ii};
        mapID = getValidDifferentID(this.ids, currID,this.crossMod);
        currMap = this.mapWrapperStruct.(fromID2fieldName(mapID));
        
        for jj = 1:length(currMap.subMapNames)
            currSubMapID = currMap.subMapNames{jj};
            currSubMap = currMap.subMaps.(currSubMapID);
            currInitDistrs = currSubMap.inputDistributions;
            currTargetDistrs = currSubMap.outputDistributions;
            currJoinInit = currInitDistrs.(fromID2fieldName(currID));
            currJoinTarget = currTargetDistrs.(fromID2fieldName(currID));
            
            for kk = 1:length(currJoinInit.subDistrIDs)
                currFeatID = currJoinInit.subDistrIDs{kk};
                currMarginalInit = currJoinInit.extractEmpDistributions(currFeatID);
                currMarginalTarget = currJoinTarget.extractEmpDistributions(currFeatID);
                
                this.initFit{ii}(strcmp(currFeatID,featNames)) = currMarginalTarget.computeDistanceFrom(currMarginalInit,'l2',currSubMap.xs_output(kk), currSubMap.c_xs_output(kk));
                
            end
        end
        
        
    end
    
end









end


