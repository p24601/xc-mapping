function distrStrucOut = joinStructOfDistrs(distrStrucIn,IDsMap)

if isempty(IDsMap) %if IDsMap is empty than no features coding is performed
    distrStrucOut = distrStrucIn;
else
    %%%checking that the map provided is OK
    featNames = fieldnames(distrStrucIn);

    assert(length(featNames) == size(IDsMap,1));

    for ii = 1:length(featNames)
        if all(~strcmp(featNames{ii},IDsMap(:,1)))
            error(['The ID map provided is not complete.', featNames{ii}, ' is missing from the map.' ])
        end
    end
    %%%initialising the output distribution
    newDistrNames = unique(IDsMap(:,2));
    userIDs =  fieldnames(distrStrucIn.(featNames{1}));

    distrStrucOut = struct();
    for ii = 1:length(newDistrNames)
        distrStrucOut.(newDistrNames{ii}) = struct();
        for jj = 1:length(userIDs)
             distrStrucOut.(newDistrNames{ii}).(userIDs{jj}) = EmpDistribution([],newDistrNames{ii},{});
        end
    end

    %%%%
    %actually performing the joining...



    for ii = 1:length(newDistrNames)
        currNewName = newDistrNames{ii};
        idxs2map = find(strcmp(IDsMap(:,2),currNewName));
        for kk = 1:length(idxs2map)
            currOldName = IDsMap{idxs2map(kk),1};
            for jj = 1:length(userIDs)
                distrStrucOut.(currNewName).(userIDs{jj}) = distrStrucOut.(newDistrNames{ii}).(userIDs{jj}).joinEmpDistributions(...
                    distrStrucIn.(currOldName).(userIDs{jj}),currNewName,currOldName); 
            end

        end


    end
end
end
