        function feature = extendFeatStruct(mapp, featureTypes,srcfeature)
            %srcEcgFeat = srcfeature.ecgFeat;
            typesEcgFeat = featureTypes.ecgFeat;
            feature = srcfeature;
            typesFeatNames = fieldnames(typesEcgFeat);
            for ii = 1:length(typesFeatNames)
                feature.ecgFeat.(typesFeatNames{ii}) = typesEcgFeat.(typesFeatNames{ii});
            end
            
        end