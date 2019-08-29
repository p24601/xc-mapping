function runCrossValidation_main(devCouples,subDevCouples,sessionIDs,dataPath,numOfThreads,degs,featureCoding,saveSubDir,maxTrainSetSize,numOfRep,regrMtd,gender,glasses)
if nargin < 13
    glasses = '';
    if nargin < 12
        gender = '';
        if nargin < 11
            regrMtd = 'lin';
            if nargin < 10
                numOfRep = 1;
                if nargin < 9
                    maxTrainSetSize = inf;
                    if nargin < 8
                        saveSubDir = '';
                        if nargin < 7
                            featureCoding = {};
                            if nargin < 6
                                degs = 1;
                                if nargin < 5
                                    numOfThreads = 1;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
if(numOfThreads > 1)
    if(isempty(gcp('nocreate')))
        parpool('local',numOfThreads);
    end
end
ps = parallel.Settings;
ps.Pool.AutoCreate = false;

[idsFirst, idsSecond,~,genderCell, glassesCell] = getIDs();

cahceMapFunction = false;
%for currSource = sourceDev
idsVecCell{1} = strsplit(int2str(idsFirst'));
idsVecCell{2} = strsplit(int2str(idsSecond'));
for ii = 1:size(devCouples,1)
    currSource = devCouples(ii,1);
    targetDev = devCouples{ii,2};
    for jj = 1:size(subDevCouples,1)
        subDevSource =  subDevCouples{jj,1};
        subDevTarget =  subDevCouples{jj,2};
        for iiS = 1:length(sessionIDs)
            for iiD = 1:length(degs)
                deg = degs(iiD);
                idsVec = idsVecCell{iiS};
                optId = [sessionIDs{iiS},'_',regrMtd,'Deg',int2str(deg),'SV'];
                [existIds, ~,existGenders,existGlasses] = getEstimationIDs(idsVec,dataPath,currSource{:},targetDev,subDevSource,subDevTarget,genderCell,glassesCell);
                if ~isempty(gender)
                    existIds = get_Male_Female_Both_Ids(existIds,existGenders,gender); 
                end
                if ~isempty(glasses)
                    existIds = get_None_Glasses_Contacts_Ids(existIds,existGlasses,glasses); 
                end
                %try
                if(maxTrainSetSize == inf || maxTrainSetSize < (length(existIds)-1))
                    dataDir = getDataDir();
                    dataDir = [dataDir,currSource{:}];
                    if ~isempty(saveSubDir)
                        dataDir = [dataDir,filesep,saveSubDir];
                    end
                    createDirIfDoesntExist(dataDir)
                    modelMatName = [dataDir,filesep,optId,'_', currSource{:}, '_', strjoin(subDevSource), '_',...
                        targetDev,'_', strjoin(subDevTarget), '_Crosser.mat' ];
                    if cahceMapFunction && exist(modelMatName,'file') == 2
                        disp('Cached CrosserObj already exist. I am skipping these optimization.')
                    else
                        disp(['Performing optimization. (cahceMapFunction = ', int2str(cahceMapFunction), ')'])
                        CrosserObj = Crosser(existIds,currSource{:},targetDev,dataPath,subDevSource,subDevTarget,'loo',featureCoding,regrMtd,maxTrainSetSize,numOfRep);
                        CrosserObj = CrosserObj.runCrossVal(numOfThreads,deg,modelMatName);
                        save([dataDir,filesep,optId,'_', currSource{:}, '_', strjoin(subDevSource), '_',...
                            targetDev,'_', strjoin(subDevTarget), '_Crosser.mat' ],'CrosserObj');
                    end
                end
                %catch ME
                %    warning(ME.message)
                %end
            end
        end
        
    end
end




end