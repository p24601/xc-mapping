        function featureOut = splitFeatStruct(mapp, featureIn)
            featureOut = featureIn;
            %for ii=1:length(patIds)
                ecgFeatIn = featureIn.ecgFeat;
                featNames = fieldnames(ecgFeatIn);
                ecgFeatOut = [];
                for jj=1:length(featNames)
                    currName = featNames{jj};
                    currFeat = ecgFeatIn.(currName);
                    leftOfMean = currFeat(currFeat < mapp.spltPts.(currName));
                    rightOfMean = currFeat(currFeat >= mapp.spltPts.(currName));
                    ecgFeatOut.([currName, '1']) = leftOfMean;
                    ecgFeatOut.([currName, '2']) = rightOfMean;
                end
                %sourceFeaturesOut.(patIds{ii}).ecgFeat = currEcgFeatOut;
                featureOut.ecgFeat = ecgFeatOut;
            %end
        end