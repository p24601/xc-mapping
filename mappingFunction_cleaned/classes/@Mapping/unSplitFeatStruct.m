        function featureOut = unSplitFeatStruct(mapp,featureIn)
            patNames = fieldnames(mapp.targetFeatures);
            targetFeatNames = fieldnames(mapp.targetFeatures.(patNames{1}).ecgFeat);
            featureOut = featureIn;
            ecgFeatIn = featureIn.ecgFeat;
            splittedNames = fieldnames(ecgFeatIn);
            %auxNames = splittedNames;
            %for ii=1:length(auxNames)
            %    auxNames{ii} = auxNames{ii}(1:end-1);
            %end
            ecgFeatOut = [];
            for ii = 1:length(targetFeatNames)
                currFeatName = targetFeatNames{ii};
                matches = ~cellfun('isempty',strfind(splittedNames,currFeatName));
                if length(find(matches))~= 2
                    error('something wrong with the unsplitting function');
                end
                goodIdxs = find(matches);                                                     
                ecgFeatOut.(currFeatName) = [  ecgFeatIn.(splittedNames{goodIdxs(1)})   ; ecgFeatIn.(splittedNames{goodIdxs(2)}) ];
            end
            
            featureOut.ecgFeat = ecgFeatOut;
        end