function resultsStr = fromMatData2CSVlike(matIn,topLineCell,leftLineCell,crossElement)
if nargin < 4
    crossElement = '';
end

resultsStr = mat2str(matIn);
resultsStr= strrep(resultsStr,'[','');
resultsStr= strrep(resultsStr,']','');
resultsStr= strrep(resultsStr,' ',',');
resultsStr= strrep(resultsStr,';',newline);
resultsStr = [crossElement,',',strjoin(topLineCell,','), newline resultsStr];

for jj = 1:length(leftLineCell)
    newLineIdxs = strfind(resultsStr,newline);
    currIdx = newLineIdxs(jj);
    resultsStr = [resultsStr(1:currIdx), leftLineCell{jj} ',', resultsStr((currIdx+1):end)];
end



end