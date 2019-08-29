        function sourceFeaturesOut = splitFeatures(mapp, sourceFeatures)
            patIds = fieldnames(sourceFeatures);
            sourceFeaturesOut = sourceFeatures;
            for ii=1:length(patIds)
                %currEcgFeat = sourceFeatures.(patIds{ii}).ecgFeat;
                %featNames = fieldnames(currEcgFeat);
                %currEcgFeatOut = [];
                %for jj=1:length(featNames)
                %    currName = featNames{jj};
                %    currFeat = currEcgFeat.(currName);
                %    leftOfMean = currFeat(currFeat < mapp.spltPts.(currName));
                %    rightOfMean = currFeat(currFeat >= mapp.spltPts.(currName));
                %    currEcgFeatOut.([currName, '1']) = leftOfMean;
                %    currEcgFeatOut.([currName, '2']) = rightOfMean;
                %end
                %sourceFeaturesOut.(patIds{ii}).ecgFeat = currEcgFeatOut;
                sourceFeaturesOut.(patIds{ii}) = mapp.splitFeatStruct(sourceFeaturesOut.(patIds{ii}));
            end
        end
        