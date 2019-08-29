       function FeaturesOut = keepOnlyTypes(mapp,FeaturesIn)
            patIds = fieldnames(FeaturesIn);
            for ii = 1:length(patIds)
                FeaturesOut.(patIds{ii}) = keepOnlyTypesStruct(mapp,FeaturesIn.(patIds{ii}));
            end
            
        end