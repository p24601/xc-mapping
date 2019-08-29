        function featStructOut = keepOnlyTypesStruct(mapp,featStructIn)
            ecgFeatIn = featStructIn.ecgFeat;
            featStructOut = featStructIn;
            featStructOut.ecgFeat = [];
            featNames = fieldnames(ecgFeatIn);
            for ii = 1:length(featNames)
                currName = featNames{ii};
                flag = false;
                for jj = 1:length(mapp.featTypes)
                    flag = (flag) || ( ~isempty(strfind(currName,mapp.featTypes{jj})  )  );
                end
                if flag
                    featStructOut.ecgFeat.(currName) = ecgFeatIn.(currName);
                %else
                    %disp('here');
                end
            end
        end