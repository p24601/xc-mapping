function existIds = get_None_Glasses_Contacts_Ids(existIds,glassesCell,glasses)

noneSetSize = sum(strcmp(glassesCell,'none'));
GoCSetSize = sum(strcmp(glassesCell,'glasses') | strcmp(glassesCell,'contacts'));

trainSetSize = min(noneSetSize,GoCSetSize);

switch glasses
    case 'none'
        glassesIdx = strcmp(glassesCell,'none');
        glassesIdx = keepOnlyFirstK(glassesIdx,trainSetSize);
    case 'GoC'
        glassesIdx = strcmp(glassesCell,'glasses') | strcmp(glassesCell,'contacts');
        glassesIdx = keepOnlyFirstK(glassesIdx,trainSetSize);
    case 'A'
        glassesIdx = false(size(glassesCell));
        kk = 1;
        ii = 1;
        while kk <= ceil(trainSetSize/2)
            if strcmp(glassesCell{ii},'none')
                glassesIdx(ii) = true;
                kk = kk + 1;
            end
            ii = ii +1;
        end
        kk = 1;
        ii = 1;
        while kk <= floor(trainSetSize/2)
            if strcmp(glassesCell{ii},'glasses') || strcmp(glassesCell{ii},'contacts')
                glassesIdx(ii) = true;
                kk = kk + 1;
            end
            ii = ii +1;
        end
    otherwise
        error('String for glassses not implemented')
end
    


  

    
    
existIds = existIds(glassesIdx);




end

function idxCell = keepOnlyFirstK(idxCell,K)
kk = 1;
for ii = 1:length(idxCell)
    if kk <= K
        if idxCell(ii)
            kk = kk + 1;
        end
    else
        idxCell(ii) = false;
    end
end

end