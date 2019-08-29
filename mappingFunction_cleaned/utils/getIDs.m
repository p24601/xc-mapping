function [idsFirst, idsSecond,dateDiff,genderCell,glassesCell] = getIDs()
fileName = '../data/biometrics-collect-db - Sheet1.csv';

%fid = fopen(fileName);

%formatStr = '%f%s%s%s%s%f%s%s%f%f%f%f%s%s%f%f%s%f%f%f%f%s%s%f%f%f%f%f%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s';
%C = textscan(fid,formatStr,65,'Delimiter',',','Headerlines',1);

%fclose(fid);
T = readtable(fileName);

%allIds = C{1};
allIds = T.userid;
%sessNum = C{15};
prevIds = T.previous_id;
valids = T.valid;
dateCol = T.date;
genderCol = T.gender;
glassesCol = T.glasses;

goodIdxs = ~isnan(prevIds) & valids;
idsSecond = allIds(goodIdxs);
genderCell = genderCol(goodIdxs);
glassesCell = glassesCol(goodIdxs);
idsFirst = prevIds(goodIdxs);
dateSecond = dateCol(goodIdxs);
for ii = 1:length(dateSecond)
    dateSecond{ii} = parseCsvDateFormat(dateSecond{ii});
end
dateFirst = cell(size(idsFirst));
for ii = 1:length(idsFirst)
    dateFirst{ii} = dateCol{idsFirst(ii) == allIds};
    dateFirst{ii} = parseCsvDateFormat(dateFirst{ii});
end
dateDiff = zeros(size(dateFirst));
for ii = 1:length(dateDiff)
    dateDiff(ii) = max(daysact(dateFirst{ii},dateSecond{ii}),5);
end

end

function dateOut = parseCsvDateFormat(dateIn)
dateIn = dateIn(1:10);
dateIn = strrep(dateIn,'-08-','-aug-');
dateIn = strrep(dateIn,'-09-','-sep-');
dateIn = strrep(dateIn,'-10-','-oct-');
dateOut = strrep(dateIn,'-11-','-nov-');

end

