function createDirIfDoesntExist(dirName)
if exist(dirName,'dir') ~=7
    mkdir(dirName)
end

end