function existIds = get_Male_Female_Both_Ids(existIds,genderCell,gender)

trainSetSize = min(sum(strcmp(genderCell,'F')),sum(strcmp(genderCell,'M')));
if ~strcmp(gender,'B')
    genderIdx = strcmp(genderCell,gender);
    kk = 1;
    for ii = 1:length(genderIdx)
        if kk <= trainSetSize
            if genderIdx(ii)
                kk = kk + 1;
            end
        else
            genderIdx(ii) = false;
        end
    end
else
    genderIdx = false(size(genderCell));
    kk = 1;
    ii = 1;
    while kk <= ceil(trainSetSize/2)
        if strcmp(genderCell{ii},'F')
            genderIdx(ii) = true;
            kk = kk + 1;
        end
        ii = ii +1;
    end
    kk = 1;
    ii = 1;
    while kk <= floor(trainSetSize/2)
        if strcmp(genderCell{ii},'M')
            genderIdx(ii) = true;
            kk = kk + 1;
        end
        ii = ii +1;
    end
end
existIds = existIds(genderIdx);




end