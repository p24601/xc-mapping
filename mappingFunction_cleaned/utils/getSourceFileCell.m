function sourceFile = getSourceFileCell(baseDir,currId,sourceDevId,subSourceDev)

if isempty(subSourceDev)
    sourceFile = {[baseDir,currId , filesep, sourceDevId , '.csv' ]};
else
    for jj = 1:length(subSourceDev)
        sourceFile{jj} = [baseDir,currId , filesep, sourceDevId , filesep, subSourceDev{jj} '.csv' ];
    end
end


end