function distrStrucOut = disJoinStructOfDistrs(distrStrucIn,IDsMap)

if isempty(IDsMap) %if IDsMap is empty than I assume no coding has been done. So no decoding needed
    distrStrucOut = distrStrucIn;
else
    %%%checking that the map provided is OK
    featNames = fieldnames(distrStrucIn);

    assert(length(featNames) == size(unique(IDsMap(:,2)),1));

    for ii = 1:length(featNames)
        if all(~strcmp(featNames{ii},IDsMap(:,2)))
            error(['The ID map provided is not complete.', featNames{ii}, ' is missing from the map.' ])
        end
    end
    %%%initialising the output distribution
    assert(length(unique(IDsMap(:,1))) == length(IDsMap(:,1)))
    newDistrNames = IDsMap(:,1);
    userIDs =  fieldnames(distrStrucIn.(featNames{1}));

    distrStrucOut = struct();
    for ii = 1:length(newDistrNames)
        distrStrucOut.(newDistrNames{ii}) = struct();
        for jj = 1:length(userIDs)
             distrStrucOut.(newDistrNames{ii}).(userIDs{jj}) = EmpDistribution([],newDistrNames{ii},{});
        end
    end

    %%%%
    %actually performing the dis-joining...



    for ii = 1:length(newDistrNames)
        currNewName = newDistrNames{ii};
        currOldName = IDsMap{strcmp(currNewName,IDsMap(:,1)),2};
        for jj = 1:length(userIDs)
            distrStrucOut.(currNewName).(userIDs{jj}) = distrStrucIn.(currOldName).(userIDs{jj}).extractEmpDistributions(currNewName); 
        end
    end
end
end
