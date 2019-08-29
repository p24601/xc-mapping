function idOut = getValidDifferentID(idVec, idIn,crossMod)


switch crossMod
    case 'loo'
        if strcmp(idVec{1},idIn)
            idOut = idVec{2};
        else
            idOut = idVec{1};
        end
    case 'no'
        idOut = 'p_all';
    otherwise
        error('crossMod not implemented')
end



end