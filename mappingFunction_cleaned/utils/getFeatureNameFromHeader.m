function featIds = getFeatureNameFromHeader(file2Parse)

fid = fopen(file2Parse);
featIds = fgets(fid);
fclose(fid);
while ~(isletter(featIds(end)) || isnumber(featIds(end)))
    featIds = featIds(1:end-1);
end
featIds = strrep(featIds,'-','_');
featIds = strsplit(featIds,',');
for kk = 1:length(featIds)
    if ~isempty(featIds{kk})
        if(isnumber(featIds{kk}(1)))
            featIds{kk} = ['f_',featIds{kk} ];
        end
    end
end

featIds = featIds(~cellfun('isempty',featIds));
featIds = featIds(~strcmp('count',featIds));
end