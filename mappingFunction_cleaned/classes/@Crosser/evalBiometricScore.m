function this = evalBiometricScore(this,sessionID,measID)

fileName = [this.dataPath, this.targetDev , '_session', int2str(sessionID), '_fi.csv'];
fid = fopen(fileName);
%
C = textscan(fid,['%s',repmat('%f',1,length(this.featureIDs))],'Delimiter',',','Headerlines',1); 

measureIDs = C{1};

idx = strcmp(measureIDs,measID);


featW8 = zeros(1,length(C)-1);
for ii = 1:length(featW8)
    featW8(ii) = C{ii+1}(idx);
end
fclose(fid);

this.bioScore = this.secScoreMatrix ./ featW8;
end